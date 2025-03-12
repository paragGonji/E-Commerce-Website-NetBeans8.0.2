package com.security;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailSender {
    public static void sendEmail(String subject, String body, String encryptedBill, String encodedKey) throws Exception {
        // ✅ Only "veroforxa36@gmail.com" is allowed to send emails
        String toEmail = "paragg22it@student.mes.ac.in";
        String fromEmail = "veroforxa36@gmail.com";
        String password = "prtgixikcorccias";  // ⚠️ Hardcoded for now (secure in production)

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Setup mail session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Create email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // Save encrypted bill to a text file
            File billFile = new File("EncryptedBill.txt");
            try (FileWriter writer = new FileWriter(billFile)) {
                writer.write(encryptedBill);
            } catch (IOException e) {
                throw new Exception("Error writing encrypted bill to file: " + e.getMessage());
            }

            // Email body with decryption key
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText(body + "\nDecryption Key: " + encodedKey);

            // Attachment (Encrypted Bill)
            MimeBodyPart attachmentPart = new MimeBodyPart();
            attachmentPart.attachFile(billFile);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);

            // Send email
            Transport.send(message);
            System.out.println("✅ Email sent successfully!");

            // Delete the file after sending
            if (!billFile.delete()) {
                System.out.println("⚠️ Warning: Could not delete the file after sending.");
            }
        } catch (MessagingException e) {
            throw new Exception("Email sending failed: " + e.getMessage());
        }
    }
}

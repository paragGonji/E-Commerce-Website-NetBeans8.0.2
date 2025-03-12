package com.security;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.io.FileWriter;
import java.util.Properties;

public class RSAEmailSender {
    public static void sendEmail(String subject, String body, String encryptedBill, String privateKey) throws Exception {
        String toEmail = "paragg22it@student.mes.ac.in";
        String fromEmail = "veroforxa36@gmail.com";
        String password = "prtgixikcorccias";  // ⚠️ Hardcoded for now (secure in production)

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            File billFile = new File("EncryptedBill.txt");
            try (FileWriter writer = new FileWriter(billFile)) {
                writer.write(encryptedBill);
            }

            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText(body + "\nPrivate Key: " + privateKey);

            MimeBodyPart attachmentPart = new MimeBodyPart();
            attachmentPart.attachFile(billFile);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);
            Transport.send(message);

            if (!billFile.delete()) {
                System.out.println("⚠️ Warning: Could not delete the file after sending.");
            }
        } catch (MessagingException e) {
            throw new Exception("Email sending failed: " + e.getMessage());
        }
    }
}
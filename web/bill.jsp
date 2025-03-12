<%@ page import="com.security.AESCipher, com.security.EmailSender, javax.crypto.SecretKey, java.util.Base64" %>
<%
    String[] items = request.getParameterValues("items");

    if (items != null) {
        StringBuilder bill = new StringBuilder();
        int total = 0;

        for (String item : items) {
            String[] parts = item.split(" - ");
            String itemName = parts[0];
            int price = Integer.parseInt(parts[1].replace("$", ""));
            bill.append(item).append("\n");
            total += price;
        }
        bill.append("Total: $").append(total);

        // Generate a secret key
        SecretKey key = AESCipher.generateKey();
        String encodedKey = Base64.getEncoder().encodeToString(key.getEncoded());

        // Encrypt the bill
        String encryptedBill = AESCipher.encrypt(bill.toString(), key);

        // Send the email
        try {
            String emailBody = "Your encrypted bill is attached. Use the following decryption key to access it:\n\n" + encodedKey;
            EmailSender.sendEmail("Grocery Bill", emailBody, encryptedBill, encodedKey); // ? Fixed argument count

%>
            <h3>Email sent successfully to paragg22it@student.mes.ac.in!</h3>
<%
        } catch (Exception e) {
%>
            <h3>Error sending email: <%= e.getMessage() %></h3>
<%
        }
    } else {
%>
        <h3>Please select items.</h3>
<%
    }
%>

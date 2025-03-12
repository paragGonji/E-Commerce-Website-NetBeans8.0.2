<%@ page import="com.security.RSAEncryptDishes, com.security.RSAEmailSender, java.security.KeyPair, java.util.Base64" %>
<%
    String[] dishes = request.getParameterValues("dishes");

    if (dishes != null) {
        StringBuilder bill = new StringBuilder();
        int total = 0;

        for (String dish : dishes) {
            String[] parts = dish.split(" - ");
            String dishName = parts[0];
            int price = Integer.parseInt(parts[1].replace("$", ""));
            bill.append(dish).append("\n");
            total += price;
        }
        bill.append("Total: $").append(total);

        KeyPair keyPair = RSAEncryptDishes.generateKeyPair();
        String encryptedBill = RSAEncryptDishes.encrypt(bill.toString(), keyPair.getPublic());
        String privateKey = Base64.getEncoder().encodeToString(keyPair.getPrivate().getEncoded());

        try {
            String emailBody = "Your encrypted bill is attached. Use the following private key to decrypt it:\n\n" + privateKey;
            RSAEmailSender.sendEmail("Dinner Dishes Bill", emailBody, encryptedBill, privateKey);
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
        <h3>Please select dishes.</h3>
<%
    }
%>
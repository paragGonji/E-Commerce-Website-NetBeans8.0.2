<%@ page import="com.security.RSAEncryptDishes, java.security.PrivateKey, java.security.KeyFactory, java.security.spec.PKCS8EncodedKeySpec, java.util.Base64" %>
<%
    String encryptedBill = request.getParameter("encryptedBill");
    String privateKeyStr = request.getParameter("privateKey");

    if (encryptedBill != null && privateKeyStr != null) {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(privateKeyStr);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(decodedKey);
            PrivateKey privateKey = KeyFactory.getInstance("RSA").generatePrivate(keySpec);

            String decryptedBill = RSAEncryptDishes.decrypt(encryptedBill, privateKey);
%>
            <h3>Your Decrypted Bill:</h3>
            <pre><%= decryptedBill %></pre>
<%
        } catch (Exception e) {
%>
            <h3>Error decrypting bill: <%= e.getMessage() %></h3>
<%
        }
    }
%>s
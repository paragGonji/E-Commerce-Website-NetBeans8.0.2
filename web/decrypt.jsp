<%@ page import="com.security.AESCipher, javax.crypto.SecretKey, javax.crypto.spec.SecretKeySpec, java.util.Base64" %>
<%
    String encryptedBill = request.getParameter("encryptedBill");
    String decryptionKey = request.getParameter("decryptionKey");

    if (encryptedBill != null && decryptionKey != null) {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(decryptionKey);
            SecretKey key = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");

            String decryptedBill = AESCipher.decrypt(encryptedBill, key);
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
%>

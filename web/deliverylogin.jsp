<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delivery Login</title>
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
<%!
    // Method to perform Vernam Cipher encryption
    String vernamEncrypt(String plaintext, String secretkey) {
        if (plaintext == null || secretkey == null) {
            return ""; // Return empty string for invalid input
        }
        StringBuilder encryptedString = new StringBuilder();
        for (int i = 0; i < plaintext.length(); i++) {
            char plaintextChar = plaintext.charAt(i);
            if (!Character.isLetterOrDigit(plaintextChar)) {
                encryptedString.append(plaintextChar); // Non-alphabetic/digit characters are added as is
                continue;
            }
            int plaintextInt = Character.toUpperCase(plaintextChar) - 'A'; // Convert to 0-25 range
            int secretkeyInt = Character.toUpperCase(secretkey.charAt(i % secretkey.length())) - 'A'; // Repeat key if shorter
            int encryptedInt = (plaintextInt + secretkeyInt) % 26; // Vernam Cipher logic
            encryptedString.append((char) (encryptedInt + 'A')); // Convert back to char
        }
        return encryptedString.toString();
    }
%>
<%
    // Retrieve form data
    String loginIdStr = request.getParameter("t1"); // Login ID (as a string)
    String password = request.getParameter("t3"); // Password
    String phoneNo = request.getParameter("t2"); // Phone No

    // Validate input
    if (loginIdStr == null || loginIdStr.isEmpty() ||
        password == null || password.isEmpty() ||
        phoneNo == null || phoneNo.isEmpty()) {
%>
    <script>showAlert("Error: Please fill out all fields.");</script>
<%
        return;
    }

    // Secret key for Vernam Cipher
    String secretKey = "NCBTZQARXABCDE"; // Example secret key

    // Encrypt Login ID and Password
    String encryptedLoginId = vernamEncrypt(loginIdStr, secretKey);
    String encryptedPassword = vernamEncrypt(password, secretKey);

    // Database connection and insertion
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/personal", "app", "app");
        PreparedStatement ps = c.prepareStatement("INSERT INTO delivery (login_id, phone_no, delivery_pass) VALUES (?, ?, ?)");
        ps.setString(1, encryptedLoginId); // Store encrypted Login ID
        ps.setString(2, phoneNo); // Store phone number as is
        ps.setString(3, encryptedPassword); // Store encrypted Password
        int i = ps.executeUpdate();
        ps.close();
        c.close();
        if (i > 0) { 
%>
            <script>showAlert("Registration successful! Encrypted Login ID: <%= encryptedLoginId %>\nEncrypted Password: <%= encryptedPassword %>");</script>
<%  
        } else { 
%>
            <script>showAlert("Oops! Registration failed. Please try again.");</script>
<%
        }
    } catch (Exception e) {
%>
        <script>showAlert("Error: <%= e.getMessage() %>");</script>
<%
        e.printStackTrace(new java.io.PrintWriter(out)); // Log full stack trace for debugging
    }
%>
</body>
</html>
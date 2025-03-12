<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign-Up</title>
    <script>
        function showAlert(message, redirect) {
            alert(message);
            if (redirect) {
                window.location.href = "login.html"; // Redirect to login page after success
            }
        }
    </script>
</head>
<body>
<%!
    // Method to perform Monoalphabetic cipher encryption (with numbers)
    String doEncryption(String s) {
        char p[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
                    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}; // Plaintext array
        char ch[] = {'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S',
                     'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M',
                     '#', '$', '%', '&', '*', '@', '!', '^', '~', '+'}; // Ciphertext array
        char c[] = new char[s.length()];
        for (int i = 0; i < s.length(); i++) {
            boolean found = false;
            for (int j = 0; j < p.length; j++) {
                if (p[j] == Character.toLowerCase(s.charAt(i))) {
                    c[i] = ch[j];
                    found = true;
                    break;
                }
            }
            if (!found) {
                c[i] = s.charAt(i); // Non-alphabetic/numeric characters are added as is
            }
        }
        return new String(c);
    }
%>
<%
    // Retrieve form data
    String un = request.getParameter("t1"); // Username
    String p = request.getParameter("t2");  // Password
    String em = request.getParameter("t3"); // Email

    // Encrypt the password using Monoalphabetic cipher
    String encryptedPassword = doEncryption(p);

    // Database connection and insertion
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/personal", "app", "app");
        PreparedStatement ps = c.prepareStatement("INSERT INTO personal (username, email, password) VALUES (?, ?, ?)");
        ps.setString(1, un);
        ps.setString(2, em);
        ps.setString(3, encryptedPassword); // Store the encrypted password
        int i = ps.executeUpdate();
        ps.close();
        c.close();
        
        if (i > 0) { 
%>
            <script>showAlert("Registration successful! Redirecting to login...", true);</script>
<%  
        } else { 
%>
            <script>showAlert("Oops! Registration failed. Please try again.", false);</script>
<%
        }
    } catch (Exception e) {
%>
        <script>showAlert("Error: <%= e.getMessage() %>", false);</script>
<%
        e.printStackTrace();
    }
%>
</body>
</html>

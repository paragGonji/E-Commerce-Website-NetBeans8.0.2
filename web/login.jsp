<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <script type="text/javascript">
            // Function to display an alert message
            function showAlert(message) {
                alert(message);
            }
        </script>
    </head>
    <body>
        <%!
            // Method to perform Monoalphabetic cipher decryption
            String doDecryption(String s) {
                char p[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
                            'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}; // Plaintext array
                char ch[] = {'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S',
                             'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M',
                             '#', '$', '%', '&', '*', '@', '!', '^', '~', '+'}; // Ciphertext array
                char c[] = new char[s.length()];
                for (int i = 0; i < s.length(); i++) {
                    boolean found = false;
                    for (int j = 0; j < ch.length; j++) {
                        if (ch[j] == s.charAt(i)) {
                            c[i] = p[j];
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
            String un = request.getParameter("t1");  // Email input
            String p = request.getParameter("t2");   // Password input

            try {
                // Load the JDBC driver
                Class.forName("org.apache.derby.jdbc.ClientDriver");

                // Establish a connection
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/personal", "app", "app");

                // Prepare the SQL statement to fetch the encrypted password
                PreparedStatement ps = c.prepareStatement("SELECT password FROM personal WHERE email=?");
                ps.setString(1, un);  // Set email in the first placeholder

                // Execute the query
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Retrieve the encrypted password from the database
                    String encryptedPassword = rs.getString("password");

                    // Decrypt the password
                    String decryptedPassword = doDecryption(encryptedPassword);

                    // Compare the decrypted password with the user input
                    if (decryptedPassword.equals(p)) {
                        // Set session attributes
                        session.setAttribute("username", un);
                        session.setAttribute("isLoggedIn", "true");  // Mark as logged in

                        // Show alert for successful login
                        out.println("<script type='text/javascript'>");
                        out.println("alert('Login successful!');");
                        out.println("window.location.href = 'user.html';");  // Redirect after successful login
                        out.println("</script>");
                    } else {
                        // Show alert for invalid username or password
                        out.println("<script type='text/javascript'>");
                        out.println("showAlert('Invalid username or password!!!');");
                        out.println("</script>");
                    }
                } else {
                    // Show alert for invalid username or password
                    out.println("<script type='text/javascript'>");
                    out.println("showAlert('Invalid username or password!!!');");
                    out.println("</script>");
                }
            } catch (Exception e) {
                e.printStackTrace(new java.io.PrintWriter(out)); // Log full stack trace for debugging
                out.println("<script type='text/javascript'>");
                out.println("showAlert('An error occurred: " + e.getMessage() + "');");
                out.println("</script>");
            }
        %>
    </body>
</html>

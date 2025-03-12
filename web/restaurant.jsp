<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Restaurant Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card w-50 mx-auto">
            <div class="card-header bg-primary text-white text-center">
                <h3>Restaurant Registration</h3>
            </div>
            <div class="card-body">
                <form action="restaurant.jsp" method="POST">
                    <div class="mb-3">
                        <label for="restaurant_name" class="form-label">Restaurant Name</label>
                        <input type="text" class="form-control" id="restaurant_name" name="restaurant_name" required>
                    </div>
                    <div class="mb-3">
                        <label for="restaurant_email" class="form-label">Restaurant Email</label>
                        <input type="email" class="form-control" id="restaurant_email" name="restaurant_email" required>
                    </div>
                    <div class="mb-3">
                        <label for="restaurant_phone" class="form-label">Phone Number</label>
                        <input type="text" class="form-control" id="restaurant_phone" name="restaurant_phone" required>
                    </div>
                    <div class="mb-3">
                        <label for="restaurant_address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="restaurant_address" name="restaurant_address" required>
                    </div>
                    <div class="mb-3">
                        <label for="restaurant_pass" class="form-label">Password</label>
                        <input type="password" class="form-control" id="restaurant_pass" name="restaurant_pass" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Register</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%!
        // Rail Fence Cipher Encryption
        public String encrypt(String plaintext) {
            if (plaintext == null || plaintext.isEmpty()) {
                return "";
            }
            String evenchars = "", oddchars = "";
            for (int i = 0; i < plaintext.length(); i += 2) {
                evenchars += String.valueOf(plaintext.charAt(i));
            }
            for (int i = 1; i < plaintext.length(); i += 2) {
                oddchars += String.valueOf(plaintext.charAt(i));
            }
            return evenchars + oddchars;
        }
        // Rail Fence Cipher Decryption
        public String decrypt(String ciphertext) {
            if (ciphertext == null || ciphertext.isEmpty()) {
                return "";
            }
            String decrypted = "";
            int mid = (ciphertext.length() + 1) / 2;
            String evenchars = ciphertext.substring(0, mid);
            String oddchars = ciphertext.substring(mid);
            int j = 0, k = 0;
            for (int i = 0; i < ciphertext.length(); i++) {
                if (i % 2 == 0) {
                    decrypted += String.valueOf(evenchars.charAt(j++));
                } else {
                    decrypted += String.valueOf(oddchars.charAt(k++));
                }
            }
            return decrypted;
        }
    %>
    <%
        // Check if form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Retrieve form data
            String restaurantName = request.getParameter("restaurant_name");
            String restaurantEmail = request.getParameter("restaurant_email");
            String restaurantPhone = request.getParameter("restaurant_phone");
            String restaurantAddress = request.getParameter("restaurant_address");
            String restaurantPass = request.getParameter("restaurant_pass");
            // Validate form data
            if (restaurantName != null && restaurantEmail != null && restaurantPhone != null && restaurantAddress != null && restaurantPass != null) {
                // Encrypt the restaurant name and password using Rail Fence Cipher
                String encryptedRestaurantName = encrypt(restaurantName);
                String encryptedPassword = encrypt(restaurantPass);
                // Database connection and insertion
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/personal", "app", "app");
                    PreparedStatement ps = c.prepareStatement("INSERT INTO restaurant (restaurant_name, restaurant_email, restaurant_phone, restaurant_address, restaurant_pass) VALUES (?, ?, ?, ?, ?)");
                    ps.setString(1, encryptedRestaurantName); // Store the encrypted restaurant name
                    ps.setString(2, restaurantEmail);
                    ps.setString(3, restaurantPhone);
                    ps.setString(4, restaurantAddress);
                    ps.setString(5, encryptedPassword); // Store the encrypted password
                    int i = ps.executeUpdate();
                    ps.close();
                    c.close();
                    if (i > 0) {
    %>
                        <div class="container mt-3">
                            <div class="alert alert-success text-center" role="alert">
                                Registration successful! Encrypted Restaurant Name: <%= encryptedRestaurantName %><br>
                                Encrypted Password: <%= encryptedPassword %>
                            </div>
                        </div>
    <%  
                    } else {
    %>
                        <div class="container mt-3">
                            <div class="alert alert-danger text-center" role="alert">
                                Oops! Registration failed. Please try again.
                            </div>
                        </div>
    <%
                    }
                } catch (Exception e) {
    %>
                    <div class="container mt-3">
                        <div class="alert alert-danger text-center" role="alert">
                            Error: <%= e.getMessage() %>
                        </div>
                    </div>
    <%
                    e.printStackTrace();
                }
            } else {
    %>
                <div class="container mt-3">
                    <div class="alert alert-danger text-center" role="alert">
                        Please fill out all fields in the form.
                    </div>
                </div>
    <%
            }
        }
    %>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
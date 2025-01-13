<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
String id = request.getParameter("userid");
String driver = "org.apache.derby.jdbc.ClientDriver";
String connectionUrl = "jdbc:derby://localhost:1527/";
String database = "product";
String userid = "app";
String password ="app";

try {
    Class.forName(driver);
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<html>
<head>
    <title>E-Commerce Cart</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .quantity-controls {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .quantity-controls .btn {
            padding: 0;
            font-size: 1.5rem;
            border: none;
            background: none;
            color: black;
        }
        .quantity-controls .form-control {
            text-align: center;
            width: 50px;
            margin: 0 10px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index.html">E-Commerce Cart</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="user.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart <span class="badge badge-danger"></span></a></li>
                    <li class="nav-item"><a class="nav-link" href="order.jsp">Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.html">Logout</a></li>
                    <img src="images/user.png" height="40px" background-img="cover">
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container my-3">
        <div class="d-flex py-3">
    <h3>Total Price: ₹<span id="total-price">0</span></h3>
    <button type="button" class="btn btn-sm btn-primary ml-auto" style="margin-left: 20px;" onclick="showSuccessPopup()">Check Out!</button>
</div>

        <table class="table table-light">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Price</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Pay</th>
                </tr>
            </thead>
                        
            <tbody>
                <%
                try {
                    connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                    statement = connection.createStatement();
                    String sql = "SELECT * FROM product";
                    resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {
                        String itemName = resultSet.getString("iteam_name");
                        String itemCategory = resultSet.getString("iteam_category");
                        double itemPrice = resultSet.getDouble("iteam_price");
                %>
                <tr>
                    <td><%= itemName %></td>
                    <td><%= itemCategory %></td>
                    <td>₹<span class="item-price"><%= itemPrice %></span></td>
                    <td>
                        <div class="quantity-controls">
                            <!-- Minus button to reduce quantity -->
                            <button type="button" class="btn minus-btn" onclick="changeQuantity(this, -1, <%= itemPrice %>)">
                                <i class="fas fa-minus-square"></i>
                            </button>
                            
                            <!-- Quantity input (initially set to 0) -->
                            <input type="text" name="quantity" class="form-control quantity-input" value="0" readonly>

                            <!-- Plus button to increase quantity -->
                            <button type="button" class="btn plus-btn" onclick="changeQuantity(this, 1, <%= itemPrice %>)">
                                <i class="fas fa-plus-square"></i>
                            </button>
                        </div>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm btn-success" onclick="showSuccessPopup()">Pay</button>
                    </td>
                </tr>
                <%
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT3mxw7HUHOtbFfC8Aj6rP8CQ9s+zRHEd/h8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pjaaA"></script>

    <!-- JavaScript to handle quantity change and total price calculation -->
    <script>
        // Global variable to store the total price
        let totalPrice = 0;

        // Function to change quantity and update the total price
        function changeQuantity(button, delta, itemPrice) {
            // Get the quantity input field
            let quantityInput = button.parentElement.querySelector('.quantity-input');
            let currentValue = parseInt(quantityInput.value);

            // Calculate new value
            let newValue = currentValue + delta;

            // Ensure that the value never goes below 0
            if (newValue < 0) {
                newValue = 0;
            }

            // Set the new value to the input field
            quantityInput.value = newValue;

            // Update the total price based on the new quantity
            updateTotalPrice();
        }

        // Function to calculate and update the total price
        function updateTotalPrice() {
            // Reset total price
            totalPrice = 0;

            // Loop through all rows to calculate total price
            document.querySelectorAll('tbody tr').forEach(row => {
                let quantity = parseInt(row.querySelector('.quantity-input').value);
                let price = parseFloat(row.querySelector('.item-price').textContent);

                totalPrice += quantity * price;
            });

            // Update the total price in the UI
            document.getElementById('total-price').textContent = totalPrice.toFixed(2);
        }

        // Function to show popup when Pay button is clicked
        function showSuccessPopup() {
            alert("Order Successful!");
        }

        // Initialize the total price when the page loads
        document.addEventListener('DOMContentLoaded', function() {
            updateTotalPrice();
        });
    </script>
</body>
</html>

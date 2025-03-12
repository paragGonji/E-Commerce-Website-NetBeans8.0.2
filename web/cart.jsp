<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
String driver = "org.apache.derby.jdbc.ClientDriver";
String connectionUrl = "jdbc:derby://localhost:1527/";
String database = "product";
String userid = "app";
String password = "app";

try {
    Class.forName(driver);
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;

// Handling form submission for insert and update
String action = request.getParameter("action");
String itemName = request.getParameter("name");
String itemCategory = request.getParameter("category");
String itemPrice = request.getParameter("price");
String itemQuentity = request.getParameter("quantity");

// Handle the Delete operation when the "Remove" button is clicked
String deleteItem = request.getParameter("deleteItem");

try {
    connection = DriverManager.getConnection(connectionUrl + database, userid, password);
    statement = connection.createStatement();

    if ("insert".equals(action)) {
        String insertSQL = "INSERT INTO product (iteam_name, iteam_category, iteam_price, quentity) VALUES ('" + itemName + "', '" + itemCategory + "', '" + itemPrice + "', '" + itemQuentity + "')";
        statement.executeUpdate(insertSQL);
    } else if ("update".equals(action)) {
        String updateSQL = "UPDATE product SET iteam_category = '" + itemCategory + "', iteam_price = '" + itemPrice + "', quentity = '" + itemQuentity + "' WHERE iteam_name = '" + itemName + "'";
        statement.executeUpdate(updateSQL);
    } else if (deleteItem != null) {
        String deleteSQL = "DELETE FROM product WHERE iteam_name = '" + deleteItem + "'";
        statement.executeUpdate(deleteSQL);
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (connection != null) {
        try {
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
%>


<%
    // Check if the user is logged in
    if (session.getAttribute("isLoggedIn") == null || !session.getAttribute("isLoggedIn").equals("true")) {
        // Redirect to login page if not logged in
        response.sendRedirect("login.html");
        return; // Stop further processing
    }
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<html>
<head>
    <title>E-Commerce Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
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
            <a class="navbar-brand" href="user.html">E-Commerce Cart</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="user.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="order.jsp">Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.html">Logout</a></li>
                    <img src="images/user.png" height="40px">
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-3">
        <div class="d-flex py-3">
            <h3>Total Price: ₹<span id="total-price">0</span></h3>
            <a class="mx-3 btn btn-primary" href="order.jsp">Check Out</a>
        </div>

        <!-- Form for Insert/Update -->
        <form method="post" action="cart.jsp">
            <div class="form-group">
                <label for="name">Product Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" class="form-control" id="category" name="category" required>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="text" class="form-control" id="price" name="price" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="text" class="form-control" id="quantity" name="quantity" required>
            </div>
            <button type="submit" name="action" value="insert" class="btn btn-success">Insert</button>
            <button type="submit" name="action" value="update" class="btn btn-warning">Update</button>
        </form>

        <table class="table table-light mt-4">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Price</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Buy Now</th>
                    <th scope="col">Remove</th>
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
                        String productName = resultSet.getString("iteam_name");
                        String productCategory = resultSet.getString("iteam_category");
                        String productPrice = resultSet.getString("iteam_price");
                        String productQuantity = resultSet.getString("quentity");
                %>
                <tr>
                    <td><%= productName %></td>
                    <td><%= productCategory %></td>
                    <td>₹<%= productPrice %></td>
                    <td><%= productQuantity %></td>
                    <td><a href="order.jsp" class="btn btn-sm btn-primary">Buy</a></td>
                    <td>
                        <form method="post" action="cart.jsp">
                            <input type="hidden" name="deleteItem" value="<%= productName %>">
                            <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

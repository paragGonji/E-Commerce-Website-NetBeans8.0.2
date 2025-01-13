<%-- 
    Document   : login
    Created on : Sep 9, 2024, 9:39:23 PM
    Author     : Parag Gonji
--%>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <table>
            <tr>
                <th></th>
            </tr>
        </table>
        <%
    String un = request.getParameter("t1");  // username input
    String p = request.getParameter("t2");   // password input
    
    try {
        // Load the JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish a connection
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/personal", "app", "app");

        // Prepare the SQL statement for authentication
        PreparedStatement ps = c.prepareStatement("select * from personal where email=? and password=?");
        ps.setString(1, un);  // Set username in the first placeholder
        ps.setString(2, p);   // Set password in the second placeholder
        
        // Execute the query
        ResultSet rs = ps.executeQuery();
        
        // Check if user is found
        if (rs.next()) {
            // Set session attribute
            session.setAttribute("username", un);
            // Redirect to the home page (index.html)
            response.sendRedirect("user.html");
        } else {
            out.println("Invalid username or password!!!");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred: " + e.getMessage());
    }
%>

    </body>
</html>

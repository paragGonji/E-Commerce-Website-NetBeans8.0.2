<%-- 
    Document   : signup
    Created on : Sep 9, 2024, 9:59:36 PM
    Author     : Parag Gonji
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign-Up</title>
</head>
<body>
<%
    String un = request.getParameter("t1");
    String p = request.getParameter("t2");
    String em = request.getParameter("t3");


    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/personal","app","app");
    PreparedStatement ps = c.prepareStatement("insert into personal values(?,?,?)");
    ps.setString(1, un);
    ps.setString(2, em);
    ps.setString(3, p);
    int i = ps.executeUpdate();
    
    if(i > 0) {
        out.println("DATA SAVED SUCCESSFULLY");
    } else {
        out.println("Opps!! DATA NOT SAVED");
    }
%>
</body>
</html>

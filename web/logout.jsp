<%
    session.invalidate();  // Destroy the session
    response.sendRedirect("index.html"); // Redirect to home page
%>

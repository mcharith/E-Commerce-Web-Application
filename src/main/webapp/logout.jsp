<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  session.invalidate(); // Destroy the session
  response.sendRedirect("index.jsp"); // Redirect to login page
%>
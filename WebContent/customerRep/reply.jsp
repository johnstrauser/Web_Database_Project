<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reply to user</title>
</head>
<body>
	<p> Reply to Customer: </p>
	<form method="post" action = "sendHandler.jsp"> 
		<table>
			<tr> 
				<td> To: </td>
				<td> <% out.print(request.getParameter("_from_")); %> </td>
			</tr>
			<tr> 
				<td> Message: </td>
				<td> 
					<textarea rows = "5" cols = "50" name = "message"> 
					
					</textarea>
				</td>
			</tr>
			<tr> 
				<td> 
					<input type = "submit" value = "Send">
					<input type = "hidden" name = "_from_" value = "<% out.print(request.getParameter("_from_")); %>">
					<input type = "hidden" name = "userName" value = "<% out.print(request.getParameter("userName")); %>">
					<input type = "hidden" name = "alertId" value = "<% out.print(request.getParameter("alertId")); %>">
				</td>
			</tr>
		</table>
	</form>


</body>
</html>
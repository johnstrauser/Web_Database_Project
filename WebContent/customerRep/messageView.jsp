<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "mainCustomerRep.jsp">
		<input type = "submit" value = "Back to Messages">
	</form>
	<br>
	<table>
		<tr>
			<td> From: </td>
			<td> <% out.print(request.getParameter("_from_")); %> </td>
		</tr>
	</table>
	<table> 
		<tr>
			<td> Message: </td>
			<td> <% out.print(request.getParameter("message")); %></td>
		</tr>
		<tr>
			<td> 
				<form method = "post" action = "reply.jsp"> 
					<input type = "submit" value = "Reply"> 
					<input type = "hidden" name = "_from_" value = "<% out.print(request.getParameter("_from_")); %>">
					<input type = "hidden" name = "message" value = "<% out.print(request.getParameter("message")); %>">
					<input type = "hidden" name = "userName" value = "<% out.print(request.getParameter("userName")); %>">
					<input type = "hidden" name = "alertId" value = "<% out.print(request.getParameter("alertId")); %>">
					<input type = "hidden" name = "to" value = "<% out.print(request.getParameter("to")); %>">
				</form> 
			</td>
			<td> 
				<form method = "post" action = "resolveHandler.jsp"> 
					<input type = "submit" value = "Resolve"> 
				</form> 
			</td>
		</tr>
	</table>
	<br>

	<table>
		<tr>
			<td> Options: </td>
		</tr>
		<tr>
			<td> 
				<form method = "post" action = "changePassword.jsp"> 
					<input type = "submit" value = "Change Password"> 
					<input type = "hidden" name = "_from_" value = "<% out.print(request.getParameter("_from_")); %>">
					<input type = "hidden" name = "message" value = "<% out.print(request.getParameter("message")); %>">
				</form> 
			</td>
			<td> <form> <input type = "submit" value = "Remove Bid"> </form> </td>
			<td> <form> <input type = "submit" value = "Delete Auction"> </form> </td>
		</tr>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>customerRepChangePassword</title>
	</head>
	<body>
		<form method = "post" action = "messageView.jsp">
		<table>
			<tr>
				<td> <input type = "submit" value = "Back to Message"> </td>
				<td> <input type = "hidden" name = "_from_" value = "<% out.print(request.getParameter("_from_")); %>"></td>
				<td> <input type = "hidden" name = "message" value = "<% out.print(request.getParameter("message")); %>"></td>
				<td> <input type = "hidden" name = "userName" value = "<% out.print(request.getParameter("userName")); %>"></td>
			</tr>
		</table>
		</form>
			
	
		<form method = "post" action = "changePasswordHandler.jsp">
		<table>
			<tr> 
				<td> Change Password </td>
			</tr>
			<tr>
				<td> For User: </td> 
				<td> <input type = "text" name = "username"></td>
			</tr>
			<tr>
				<td> New Password: </td>
				<td> <input type = "text" name = "password"></td>
			</tr>
		</table>
		<br>
		<input type = "submit" value = "Change Password">
		</form>	
	</body>
</html>
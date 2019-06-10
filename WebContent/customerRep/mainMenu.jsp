<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Main Activity for Customer Representative</title>
</head>
<body>

	<table>
		<tr>
			<td> Check Messages</td>
		</tr>	
	</table>
	
	<table>
		<tr>
			<td> 
				<form method = "post" action = "changePasswordHandler.jsp"> 
				<input type = "submit" value = "Change Password">
				<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">				
				</form> 
			</td>
			
			<td> 
			<form method = "post" action = "deleteBid.jsp"> 
			<input type = "submit" value = "Delete Bid"> 
			<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
			</form> 
			</td>
			
			<td> 
			<form method = "post" action = "deleteAuction.jsp">
			<input type = "submit" value = "Delete Auction"> 
			<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
			</form> 
			</td>
			
			<td>
			<form method="post" action="../endUser/mainMenu.jsp">
			<input type="submit" value="Switch to End User">
			<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
			</form>
			</td>
		</tr>
	
	</table>
	
	<br>
	<table>
		<tr>
			<td> </td>
			<td> From: </td>
			<td> Message: </td>
			<td> To:  </td>
			<td> Alert ID: </td>
		</tr>
		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			//out.print("Connection Successful.");
			String get = "SELECT * FROM Messages";
			
			ResultSet result = stmt.executeQuery(get);
		
			while(result.next()){
		 		out.print("<tr>");
		 		out.print("<form method='post' action = 'messageView.jsp'>");
		 		out.print("<td><input type='submit' value='View Message'></td>");
		 		out.print("<td>"+result.getString("_from_")+"<input type='hidden' name='_from_' value='"+result.getString("_from_")+"'>"+"</td>");
		 		out.print("<td>"+result.getString("message")+"<input type='hidden' name='message' value='"+result.getString("message")+"'>"+"</td>");
		 		out.print("<td>"+result.getString("userName")+"<input type='hidden' name='to' value='"+result.getString("userName")+"'>"+"</td>");
		 		out.print("<td>"+result.getInt("alertId")+"<input type='hidden' name='alertId' value='"+result.getInt("alertId")+"'>"+"</td>");
		 		out.print("<td>"+"<input type='hidden' name='userName' value='"+request.getParameter("userName")+"'>"+"</td>");
		 		out.print("</form>");
		 		out.print("</tr>");
		 	}
		%>		
	</table>

<form method="post" action="deleteBid.jsp">
<input type="submit" value="Delete Bid"/>
</form>
<form method="post" action="deleteAuction.jsp">
<input type="submit" value="Delete Auction"/>
</form>

</body>
</html>

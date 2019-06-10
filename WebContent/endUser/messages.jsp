<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>
<input type="button" value="Logout" name="Logout" onclick = "openPage('../index.jsp')"/>
<form method="post" action="mainMenu.jsp">
<input type="submit" value="Back to Main Menu"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br><br>
<!-- 
	Layout:
		-Compose message button, brings to compose page
		-Inbox
			Query messages for all messages to this account
			Maybe only display messages that haven't been resolved
			Send to message view with button
 -->
 
<form method="post" action="composeMessage.jsp">
	<input type="submit" value="Compose Message">
	<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br>
<table>
	<tr>
		<td></td>
		<td></td>
		<td>From</td>
		<td>Message</td>
	</tr>
	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String get = "SELECT * FROM Messages WHERE userName='"+request.getParameter("userName")+"'";
	ResultSet result = stmt.executeQuery(get);
	
	while(result.next()){
		out.print("<tr>");
		//Eventually make button on this row
		out.print("<td>");%>
		<form method="post" action="reply.jsp">
			<input type="submit" value="Reply">
			<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
			<input type="hidden" name="to" value="<%out.print(result.getString("_from_")); %>">
			<input type="hidden" name="alertId" value="<%out.print(result.getInt("alertId")); %>">
		</form>
		<%out.print("</td><td>");%>
		<form method="post" action="deleteMessage.jsp">
			<input type="submit" value="Delete">
			<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
			<input type="hidden" name="from" value="<%out.print(result.getString("_from_")); %>">
			<input type="hidden" name="alertId" value="<%out.print(result.getInt("alertId")); %>">
			<input type="hidden" name="message" value="<%out.print(result.getString("message")); %>">
		</form>
		<%out.print("</td>");
		out.print("<td>"+result.getString("_from_")+"</td>");
		out.print("<td>"+result.getString("message")+"</td>");
		out.print("</tr>");
	}
	
	%>
</table>
</body>
</html>
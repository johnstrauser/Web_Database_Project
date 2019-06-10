<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<form method="post" action="messages.jsp">
<input type="submit" value="Back to Messages"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br><br>
<!-- 
	Layout:
		To: (already provided)
		Message:________
		
		[Send]
 -->
<form method="post" action="replyHandler.jsp">
<table>
	<tr>
		<td>To:</td>
		<td><%out.print(request.getParameter("to"));%><input type="hidden" name="to" value="<%out.print(request.getParameter("to"));%>"></td>
	</tr>
	<tr>
		<td>Message:</td>
		<td><input type="text" name="message"></td>
	</tr>
	<tr>
		<td><input type="submit" value="Send"></td>
		<td><input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>"></td>
		<td><input type="hidden" name="alertId" value="<%out.print(request.getParameter("alertId")); %>"></td>
	</tr>
</table>
</form>
</body>
</html>
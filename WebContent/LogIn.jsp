<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log In</title>
</head>
<body>
Log in page
<br>
<input type="button" value="Back to Main Menu" name="Back" onclick = "openPage('index.jsp')"/>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>

<br><br>

<form method="post" action="LoginHandler.jsp">
<table>
<tr>
<td>Username</td><td><input type="text" name="username">
</tr>
<tr>
<td>Password</td><td><input type="text" name="password">
</tr>
</table>
<input type="submit" value="Login"/>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Account</title>
</head>
<body>
Create account page
<br>
<input type="button" value="Back to Main Menu" name="Back" onclick = "openPage('index.jsp')"/>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>

<br><br>

<form method="post" action="CreateHandler.jsp">
<table>
<tr>
<td>Username</td><td><input type="text" name="username"></td>
</tr>
<tr>
<td>Password</td><td><input type="text" name="password"></td>
</tr>
<tr>
<td>Name</td><td><input type="text" name="name"></td>
</tr>
<tr>
<td>Email</td><td><input type="text" name="email"></td>
</tr>
<tr>
<td>Address</td><td><input type="text" name="address"></td>
</tr>
</table>
<input type="submit" value="Create"/>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test Doc</title>
</head>
<body>
Log in or create an account?
<br>
<table>
<tr>
<td><input type="button" value="Create account" name="CreateAccount" onclick = "openPage('CreateAccount.jsp')"/></td>
<td></td>
<td><input type="button" value="Log in" name="LogIn" onclick = "openPage('LogIn.jsp')"/></td>
</tr>
</table>
	
	
	<script type="text/javascript">
	function openPage(pageURL){
		window.location.href = pageURL;
	}
	</script>
<br>
</body>
</html>
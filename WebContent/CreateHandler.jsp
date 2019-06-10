<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.mysql.jdbc.exceptions.jdbc4.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Creation Result</title>
</head>
<body>
<br>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>
<br>
	<%
	try{
		String user = request.getParameter("username");
		String pass = request.getParameter("password");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		
		if(user.compareTo("")!=0 && pass.compareTo("")!=0 && email.compareTo("")!=0 && name.compareTo("")!=0 && address.compareTo("")!=0){
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
		
			Statement stmt = con.createStatement();
			
			String insert = "INSERT INTO account(userName,password,email,name,address,accountType)" + "VALUES (?,?,?,?,?,1)";
			PreparedStatement ps = con.prepareStatement(insert);
			
			ps.setString(1, user);
			ps.setString(2, pass);
			ps.setString(3, email);
			ps.setString(4, name);
			ps.setString(5, address);
			
			ps.executeUpdate();
			
			con.close();
			
			out.print("Account creation successful<br>");
			%> <input type="button" value="Back to Index" onclick = "openPage('index.jsp')"/> <%
		}else{
			out.print("All fields must be filled<br>");
			%> <input type="button" value="Back to Account Creation" onclick = "openPage('CreateAccount.jsp')"/> <%
		}
	}catch(MySQLIntegrityConstraintViolationException e){
		out.print("Account creation failed, username already taken<br>");
		%> <input type="button" value="Back to Account Creation" onclick = "openPage('CreateAccount.jsp')"/> <%
	}catch(Exception e){
		out.print(e);
		out.print("<br>");
		out.print("Create failed<br>");
		%> <input type="button" value="Back to Account Creation" onclick = "openPage('CreateAccount.jsp')"/> <% 
	}
	
	%>
</body>
</html>
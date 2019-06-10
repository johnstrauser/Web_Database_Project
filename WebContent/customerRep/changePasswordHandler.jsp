<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Password Change</title>
</head>
<body>
<br>
	<%
	//List<String> list = new ArrayList<String>();
	
	try{
		String user = request.getParameter("username");
		String pass = request.getParameter("password");
		
		out.print("Username = "+user+"\n");
		out.print("Password = "+pass+"\n");
		
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		out.print("Connection established.");
		Statement stmt = con.createStatement();
		
		//Prepare SQL statement
		String update = "UPDATE account SET password = ? WHERE username = ?";
		PreparedStatement ps = con.prepareStatement(update);
		ps.setString(1, pass);
		ps.setString(2, user);
		
		ps.executeUpdate();
		con.close();
		
	
		out.print("Password successfully changed.<br>");	
		
	}catch(Exception e){
		//out.print(e);
		e.printStackTrace();
		out.print("Password change failed.");
		//out.print("<br><input type='button' value='Back to Login' name='Back' onclick = 'openPage('LogIn.jsp')'/>");
	}
	
	%>

</body>
</html>
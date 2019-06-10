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
	<% 
	try{

		String message = request.getParameter("message");
		String from = request.getParameter("userName");
		String userName = request.getParameter("_from_");
		int alertId = Integer.parseInt(request.getParameter("alertId"));
		
		out.print("Message = "+message+"\n");
		out.print("From = "+from+"\n");
		out.print("To = "+userName+"\n");
		out.print("AlertID = "+alertId+"\n");
		
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		//out.print("Connection established.");
		//Statement stmt = con.createStatement();
		
		//Prepare SQL statement
		String update = "INSERT INTO Messages(_from_, userName, alertId, message) VALUES (?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(update);
		ps.setString(1, from);
		ps.setString(2, userName);
		ps.setString(4, message);
		ps.setInt(3, alertId);
		
		ps.executeUpdate();
		con.close();
		
	
		out.print("Message Sent.<br>");	
		
	}catch(Exception e){
		//out.print(e);
		e.printStackTrace();
		out.print("Message Failed to Send.");
		//out.print("<br><input type='button' value='Back to Login' name='Back' onclick = 'openPage('LogIn.jsp')'/>");
	}
	
	
	
	%>
</body>
</html>
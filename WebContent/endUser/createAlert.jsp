<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException" %>
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
<%
	try{
		int productID = Integer.parseInt(request.getParameter("productID"));
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		//Query for highest alertID in alert
		Statement stmt1 = con.createStatement();
		String highQuery = "SELECT MAX(alertID) maxID FROM Alerts";
		ResultSet highResult = stmt1.executeQuery(highQuery);
		highResult.next();
		int alertID = highResult.getInt("maxID")+1;
		//create entry in alert table
		String alertInsert = "INSERT INTO Alerts(userName, alertId) VALUES (?,?)";
		PreparedStatement ps1 = con.prepareStatement(alertInsert);
		
		ps1.setString(1,request.getParameter("userName"));
		ps1.setInt(2, alertID);
		
		ps1.executeUpdate();
		//create entry in availableitem table
		String availInsert = "INSERT INTO AvailableItem(productID,userName,alertId) VALUES (?,?,?)";
		PreparedStatement ps2 = con.prepareStatement(availInsert);
		
		ps2.setInt(1,productID);
		ps2.setString(2,request.getParameter("userName"));
		ps2.setInt(3, alertID);
		
		ps2.executeUpdate();
		
		out.print("Alert has been successfully created.");
	}catch(MySQLIntegrityConstraintViolationException e){
		out.print("ERROR: Cannot create an alert for an item in which the user already has an alert.");
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
</body>
</html>
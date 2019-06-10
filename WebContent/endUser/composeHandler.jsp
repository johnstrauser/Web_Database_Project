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
<form method="post" action="messages.jsp">
<input type="submit" value="Back to Messages"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br><br>

<!-- 
	Query alerts for new alertID
	If to="customer rep" get name of first customer rep account in accounts table
	Create entry in alerts table
	Create entry in messages table
 -->
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try{
		Statement alertQuery = con.createStatement();
		String alertGet = "SELECT MAX(alertId) maxID FROM Alerts";
		ResultSet alertResult = alertQuery.executeQuery(alertGet);
		alertResult.next();
		int alertID = alertResult.getInt("maxID")+1;
		
		String to = request.getParameter("to");
		String message = request.getParameter("message");
		if(to.equals("")){
			out.print("ERROR: The To field must not be empty.");
		}else if(message.equals("")){
			out.print("ERROR: The message field must not be empty.");
		}else{
			if(to.equals("customer rep")){
				Statement repQuery = con.createStatement();
				String repGet = "SELECT userName FROM account WHERE accountType=2";
				ResultSet repResult = repQuery.executeQuery(repGet);
				repResult.next();
				to = repResult.getString("userName");
			}
			String insert = "INSERT INTO Alerts(userName, alertId)" + " VALUES (?,?)";
			PreparedStatement ps1 = con.prepareStatement(insert);
			
			ps1.setString(1, request.getParameter("userName"));
			ps1.setInt(2, alertID);
			
			ps1.executeUpdate();
			
			String insert2 = "INSERT INTO Messages(_from_,userName,alertId,message)" + " VALUES (?,?,?,?)";
			PreparedStatement ps2 = con.prepareStatement(insert2);
			
			ps2.setString(1, request.getParameter("userName"));
			ps2.setString(2, to);
			ps2.setInt(3, alertID);
			ps2.setString(4, message);
			
			ps2.executeUpdate();
			
			out.print("Message Sent");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	con.close();
%>
</body>
</html>
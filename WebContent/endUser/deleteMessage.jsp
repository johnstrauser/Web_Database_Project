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
	Delete the message provided by params
 -->
<%
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();
try{
	int alertId = Integer.parseInt(request.getParameter("alertId"));
	String from = request.getParameter("from");
	String message = request.getParameter("message");
	
	Statement stmt = con.createStatement();
	String delete = "DELETE FROM Messages WHERE _from_='"+from+"' AND userName='"+request.getParameter("userName")+"' AND alertId="+alertId+" AND message='"+message+"'";
	stmt.executeUpdate(delete);
	
	out.print("Message Deleted");
}catch(Exception e){
	e.printStackTrace();
}
con.close();
%>
</body>
</html>
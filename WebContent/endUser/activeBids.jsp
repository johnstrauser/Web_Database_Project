<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.mysql.jdbc.exceptions.jdbc4.*" %>
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
<!-- 
	Query Bid History for all bids on this account
	Query Auction for all auctions where auctionID exists in bid history and endDate > today
	Print Results in table
 -->
 
<%
	String user = request.getParameter("userName");
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try{
		Statement stmt1 = con.createStatement();
		String bidHistoryQuery = "SELECT bid, auctionID FROM Bid_History WHERE accountID='"+user+"'";
		ResultSet historyResult = stmt1.executeQuery(bidHistoryQuery);
		
		while(historyResult.next()){
			
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	con.close();
%>
</body>
</html>
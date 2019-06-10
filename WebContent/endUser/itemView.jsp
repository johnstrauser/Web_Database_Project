<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
<br><br>
<!-- Item Details -->
<table>
	<tr>
		<td>Category: <%out.print(request.getParameter("category"));%></td>
		<td>Year: <%out.print(request.getParameter("year"));%></td>
	</tr>
	<tr>
		<td>Make: <%out.print(request.getParameter("make"));%></td>
		<td>Model: <%out.print(request.getParameter("model"));%></td>
	</tr>
	<tr>
		<td>Color: <%out.print(request.getParameter("color"));%></td>
		<td>Mileage: <%out.print(request.getParameter("mileage"));%></td>
	</tr>
</table>
<!-- List of active auctions for item -->
<br><br>
<!-- If user doesn't have an alert for this item, allow them to make it -->
<%
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();
Statement alertStmt = con.createStatement();
String alertQuery = "SELECT * FROM AvailableItem WHERE productID="+request.getParameter("productID")+" AND userName='"+request.getParameter("userName")+"'";
ResultSet alertResult = alertStmt.executeQuery(alertQuery);
if(alertResult.next()){
	out.print("You have already created an alert for this item.");
}else{
	%>
		<form method="post" action="createAlert.jsp">
	<input type="submit" value="Create Alert For This Item">
	<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
	<input type="hidden" name="productID" value="<%out.print(request.getParameter("productID")); %>">
</form>
	<%
}

%>
<br><br>
<table border="1">
	<tr>
		<td></td>
		<td>Starting Price</td>
		<td>Current Bid</td>
		<td>Buy Now Price</td>
		<td>End Date</td>
	</tr>
	<!-- for each auction
			create tr
				create form
					create button
					display each column and have hidden field
					have hidden field for username
				close form
			close row
	 -->
	 <%
	 	
		
		Statement stmt = con.createStatement();
		String get = "SELECT * FROM Auction WHERE productID="+request.getParameter("productID");
		
		Calendar c = Calendar.getInstance();
		String cString = c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DAY_OF_MONTH)+" "+c.get(Calendar.HOUR_OF_DAY)+":00:00";;
		
		get += " AND endDate > '"+cString+"'";
		
		//out.print("get="+get);
		
		ResultSet result = stmt.executeQuery(get);
	 
	 	while(result.next()){
	 		out.print("<tr>");
	 		out.print("<form method='post' action='auctionView.jsp'>");
	 		out.print("<td><input type='submit' value='View Auction'></td>");
	 		out.print("<td>$"+result.getString("Start_price")+"<input type='hidden' name='startPrice' value='"+result.getString("Start_price")+"'>"+"</td>");
	 		out.print("<td>$"+result.getString("currentBid")+"<input type='hidden' name='currentBid' value='"+result.getString("currentBid")+"'>"+"</td>");
	 		out.print("<td>$"+result.getString("buyNow")+"<input type='hidden' name='buyNow' value='"+result.getString("buyNow")+"'>"+"</td>");
	 		out.print("<td>"+result.getString("endDate")+"<input type='hidden' name='endDate' value='"+result.getString("endDate")+"'>"+"</td>");
	 		out.print("<input type='hidden' name='userName' value='"+request.getParameter("userName")+"'>");
	 		out.print("<input type='hidden' name='auctionID' value='"+result.getInt("auctionID")+"'>");
	 		out.print("</form>");
	 		out.print("</tr>");
	 	}
	 	con.close();
	 %>
</table>
</body>
</html>
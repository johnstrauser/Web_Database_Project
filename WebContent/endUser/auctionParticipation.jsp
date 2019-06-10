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
	Query bid history for all auctions this user has participated in
	Print List, no buttons
 -->
Auctions You Have Participated In:
<table border="1">
	<tr>
		<td>Status</td>
		<td>Your Bid</td>
		<td>Current Bid</td>
		<td>Buy Now Price</td>
		<td>End Date</td>
		<td>Category</td>
		<td>Year</td>
		<td>Make</td>
		<td>Model</td>
		<td>Color</td>
		<td>Mileage</td>
	</tr>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
 	
 	String user = request.getParameter("userName");
 	Statement bidHistStmt = con.createStatement();
 	String bidHistquery = "SELECT auctionID, bid FROM Bid_History WHERE accountID='"+user+"' ORDER BY bid DESC";
 	ResultSet bidHistResult = bidHistStmt.executeQuery(bidHistquery);
 	
 	ArrayList<Integer> used = new ArrayList<Integer>();
 	while(bidHistResult.next()){
 		if(!used.contains(bidHistResult.getInt("auctionID"))){
 			used.add(bidHistResult.getInt("auctionID"));
 			//Get the auction info
 			Statement auctionStmt = con.createStatement();
 			String auctionquery = "SELECT currentBid,buyNow,endDate,productID,sold FROM Auction WHERE auctionID="+bidHistResult.getInt("auctionID");
 			ResultSet auctionResult = auctionStmt.executeQuery(auctionquery);
 			auctionResult.next();
 			//Get the item info
 			Statement itemStmt = con.createStatement();
 			String itemquery = "SELECT subcategory,Year,make,Model,color,mileage FROM item WHERE productID="+auctionResult.getInt("productID");
 			ResultSet itemResult = itemStmt.executeQuery(itemquery);
 			itemResult.next();
 			//Print
 			out.print("<tr>");
 			if(auctionResult.getInt("sold")==0){
 				out.print("<td>Not Sold</td>");
 			}else{
 				out.print("<td>Sold</td>");
 			}
 			out.print("<td>"+bidHistResult.getDouble("bid")+"</td>");
 			out.print("<td>"+auctionResult.getDouble("currentBid")+"</td>");
 			out.print("<td>"+auctionResult.getDouble("buyNow")+"</td>");
 			out.print("<td>"+auctionResult.getTimestamp("endDate")+"</td>");
 			out.print("<td>"+itemResult.getString("subcategory")+"</td>");
 			out.print("<td>"+itemResult.getInt("Year")+"</td>");
 			out.print("<td>"+itemResult.getString("make")+"</td>");
 			out.print("<td>"+itemResult.getString("Model")+"</td>");
 			out.print("<td>"+itemResult.getString("color")+"</td>");
 			out.print("<td>"+itemResult.getInt("mileage")+"</td>");
 			out.print("</tr>");
 		}
 	}
 	
 %>
</table>
</body>
</html>
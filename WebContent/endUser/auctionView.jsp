<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
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
<!-- Auction Details -->
<table>
	<tr>
		<td>Auction Details</td>
	</tr>
	<tr>
		<td>Starting Price: $<%out.print(request.getParameter("startPrice"));%></td>
		<td>Current Bid: $<%out.print(request.getParameter("currentBid"));%></td>
	</tr>
	<tr>
		<td>Buy Now Price: $<%out.print(request.getParameter("buyNow"));%></td>
		<td>End Date: <%out.print(request.getParameter("endDate"));%></td>
	</tr>
	<tr>
		<td>Item Details</td>
	</tr>
	<%
 		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement stmt = con.createStatement();
		String get = "SELECT productID FROM Auction WHERE auctionID="+request.getParameter("auctionID");
		ResultSet result = stmt.executeQuery(get);
		
		result.next();
		
		stmt = con.createStatement();
		get = "SELECT * FROM item WHERE productID="+result.getInt("productID");
		result = stmt.executeQuery(get);
		
		result.next();
		
		
	%>
	<tr>
		<td>Category: <%out.print(result.getString("subcategory"));%></td>
		<td>Year: <%out.print(result.getString("Year"));%></td>
	</tr>
	<tr>
		<td>Make: <%out.print(result.getString("make"));%></td>
		<td>Model: <%out.print(result.getString("Model"));%></td>
	</tr>
	<tr>
		<td>Color: <%out.print(result.getString("color"));%></td>
		<td>Mileage: <%out.print(result.getString("mileage"));%></td>
	</tr>
</table>
<!-- functions
		-bid
		-buyNow
 -->
<br><br>
<form method="post" action="bidOnAuction.jsp">
	<table>
		<tr>
			<td>New Bid:</td>
			<td><input type="text" name="bid"></td>
			<td><input type="submit" value="Submit"></td>
			<td><input type="hidden" name="userName" value="<%out.print(request.getParameter("userName"));%>"></td>
			<td><input type='hidden' name="auctionID" value=<%out.print(request.getParameter("auctionID"));%>></td>
			<td><input type='hidden' name="productID" value=<%out.print(result.getInt("productID"));%>></td>
		</tr>
	</table>
</form>
<br>
<form method="post" action="buyNow.jsp">
	<table>
		<tr>
			<td><input type="submit" value="<%out.print("Buy Now for $"+request.getParameter("buyNow"));%>"></td>
			<td><input type="hidden" name="userName" value="<%out.print(request.getParameter("userName"));%>">
			<input type='hidden' name='auctionID' value="<%out.print(request.getParameter("auctionID"));%>"></td>
			<td><input type='hidden' name="productID" value=<%out.print(result.getInt("productID"));%>></td>
		</tr>
	</table>
</form>
<br>
<!-- Display bid history of the auction here
		Layout:
			-Bid
			-User
			-Date Time (order by this)
 -->
 Bid History:
 <table border="1">
 	<tr>
 		<td>Bid</td>
 		<td>User</td>
 		<td>Date and Time</td>
 	</tr>
 <%
 	Statement stmt2 = con.createStatement();
 	String histQuery = "SELECT bid, accountID, DateNTime FROM Bid_History WHERE auctionID="+request.getParameter("auctionID")+" ORDER BY DateNTime DESC";
 	ResultSet histResult = stmt2.executeQuery(histQuery);
 	
 	while(histResult.next()){
 		out.print("<tr>");
 		out.print("<td>"+histResult.getString("bid")+"</td>");
 		out.print("<td>"+histResult.getString("accountID")+"</td>");
 		out.print("<td>"+histResult.getDate("DateNTime").toString()+"</td>");
 		out.print("</tr>");
 	}
 
 
 %>
 </table>
 <br><br>
 Similar Auctions From Past Month:
 <table border="1">
 	<tr>
 		<td>Status</td>
 		<td>High Bid</td>
 		<td>Buy Now Price</td>
 		<td>End Date</td>
 		<td>Category</td>
 		<td>Year</td>
 		<td>Make</td>
 		<td>Model</td>
 	</tr>
 	<%
 		SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar c = Calendar.getInstance();
		String cString = c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH))+"-"+c.get(Calendar.DAY_OF_MONTH)+" "+c.get(Calendar.HOUR_OF_DAY)+":00:00";
		java.util.Date d = sdf.parse(cString);
		java.sql.Timestamp ts1 = new java.sql.Timestamp(d.getTime());
		cString = c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DAY_OF_MONTH)+" "+c.get(Calendar.HOUR_OF_DAY)+":00:00";
		d = sdf.parse(cString);
		java.sql.Timestamp ts2 = new java.sql.Timestamp(d.getTime());
		//out.print(ts1.toString()+" -----"+ts2.toString());
		
 		Statement stmt3 = con.createStatement();
 		String simQuery = "SELECT A.sold, A.currentBid, A.buyNow, A.endDate, I.subcategory, I.Year, I.make, I.Model FROM Auction A, item I WHERE (A.productID = I.productID AND A.auctionID!="+request.getParameter("auctionID")+" AND A.endDate>='"+ts1.toString()+"' AND A.endDate<='"+ts2.toString()+"'  ) AND (I.subcategory='"+result.getString("subcategory")+"' OR I.Year="+result.getInt("Year")+" OR I.make='"+result.getString("make")+"' OR I.Model='"+result.getString("model")+"')";
 		ResultSet simResult = stmt3.executeQuery(simQuery);
 		
 		while(simResult.next()){
 	 		out.print("<tr>");
 	 		out.print("<td>");
 	 		if(simResult.getInt("A.sold")==0){
 	 			out.print("Not Sold");
 	 		}else{
 	 			out.print("Sold");
 	 		}
 	 		out.print("</td>");
 	 		out.print("<td>"+simResult.getDouble("A.currentBid")+"</td>");
 	 		out.print("<td>"+simResult.getDouble("A.buyNow")+"</td>");
 	 		out.print("<td>"+simResult.getTimestamp("A.endDate").toString()+"</td>");
 	 		out.print("<td>"+simResult.getString("I.subcategory")+"</td>");
 	 		out.print("<td>"+simResult.getInt("I.Year")+"</td>");
 	 		out.print("<td>"+simResult.getString("I.make")+"</td>");
 	 		out.print("<td>"+simResult.getString("I.Model")+"</td>");
 	 		out.print("</tr>");
 	 	}
 		con.close();
 	%>
 </table>
</body>
</html>
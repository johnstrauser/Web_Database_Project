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
<br><br>
<!-- Get auction information -->
<!-- Query selling -->
<!-- Create entry in History -->
<!-- Set endDate of auction to current Date  -->
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	ResultSet auctionResult = null;
	int auctionID = 0;
	try{
		auctionID = Integer.parseInt(request.getParameter("auctionID"));
		Statement stmt = con.createStatement();
		String get = "SELECT * FROM Auction WHERE auctionID="+auctionID;
		auctionResult = stmt.executeQuery(get);
		auctionResult.next();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	ResultSet sellingResult = null;
	try{
		Statement stmt = con.createStatement();
		String get = "SELECT * FROM Selling WHERE auctionID="+auctionID;
		sellingResult = stmt.executeQuery(get);
		sellingResult.next();
		if(request.getParameter("userName").equals(sellingResult.getString("userName"))){
			out.print("ERROR: cannot buy now on your own auction.");
		}else if(auctionResult.getDouble("buyNow") <= auctionResult.getDouble("currentBid")){
			out.print("Cannot perform buyNow if current bid is already greater.");
		}else{
			SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar c = Calendar.getInstance();
			String cString = c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DAY_OF_MONTH)+" "+c.get(Calendar.HOUR_OF_DAY)+":00:00";
			java.util.Date d = sdf.parse(cString);
			java.sql.Timestamp ts = new java.sql.Timestamp(d.getTime());
			try{
				String insert = "INSERT INTO History(productID,price,userBuys,userSells,auctionID)" + " VALUES (?,?,?,?,?)";
				PreparedStatement ps = con.prepareStatement(insert);
				
				ps.setInt(1, auctionResult.getInt("productID"));
				ps.setInt(2, auctionResult.getInt("buyNow"));
				ps.setString(3, request.getParameter("userName"));
				ps.setString(4, sellingResult.getString("userName"));
				ps.setInt(5,auctionID);
				
				ps.executeUpdate();
				
				String insert2 = "INSERT INTO Bid_History(accountID,bid,auctionID,DateNTime)" + " VALUES (?,?,?,?)";
				PreparedStatement ps2 = con.prepareStatement(insert2);
				
				ps2.setString(1, request.getParameter("userName"));
				ps2.setInt(2, auctionResult.getInt("buyNow"));
				ps2.setInt(3,auctionID);
				ps2.setTimestamp(4, ts);
				
				
				ps2.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			try{
				
				String update = "UPDATE Auction SET endDate=?, currentBid=buyNow, sold=? WHERE auctionID=?";
				PreparedStatement ps = con.prepareStatement(update);
				
				ps.setTimestamp(1, ts);
				ps.setInt(2, 1);
				ps.setInt(3, auctionID);
				
				ps.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
			}
			out.print("You have bought the item at the buy now price<br>");
			
			//Try to provide an alert to users who bid on this item
			String bidHistGet = "SELECT DISTINCT accountID FROM Bid_History WHERE auctionID="+auctionID;
			Statement bidHistStmt = con.createStatement();
			ResultSet bidHistResult = bidHistStmt.executeQuery(bidHistGet);
			
			while(bidHistResult.next()){
				//Get the new alertID
				Statement alertQuery = con.createStatement();
				String alertGet = "SELECT MAX(alertId) maxID FROM Alerts";
				ResultSet alertResult = alertQuery.executeQuery(alertGet);
				alertResult.next();
				int alertID = alertResult.getInt("maxID")+1;
				//Create the new alert in Alerts and OutbidOrBuyNow
				String alertInsert = "INSERT INTO Alerts(userName, alertId)" + " VALUES (?,?)";
				PreparedStatement alertPs = con.prepareStatement(alertInsert);
		
				alertPs.setString(1, bidHistResult.getString("accountID"));
				alertPs.setInt(2, alertID);
		
				alertPs.executeUpdate();
				
				String outbidInsert = "INSERT INTO OutbidOrBuyNow(auctionID,userName,alertId)" + " VALUES (?,?,?)";
				PreparedStatement outbidPs = con.prepareStatement(outbidInsert);
				
				outbidPs.setInt(1,auctionID);
				outbidPs.setString(2, bidHistResult.getString("accountID"));
				outbidPs.setInt(3, alertID);
		
				outbidPs.executeUpdate();
				//Create message for user from admin
				String messageInsert = "INSERT INTO Messages(_from_,userName,alertId,message)" + " VALUES (?,?,?,?)";
				PreparedStatement messagePs = con.prepareStatement(messageInsert);
		
				messagePs.setString(1, "admin");
				messagePs.setString(2, bidHistResult.getString("accountID"));
				messagePs.setInt(3, alertID);
				
				String itemQuery = "SELECT Year,make,Model FROM item WHERE productID="+request.getParameter("productID");
				Statement itemStmt = con.createStatement();
				ResultSet item = itemStmt.executeQuery(itemQuery);
				item.next();
				messagePs.setString(4, "The "+item.getInt("Year")+" "+item.getString("make")+" "+item.getString("Model")+" you bid on has been bought using buyNow for a price of $"+auctionResult.getInt("buyNow"));
		
				messagePs.executeUpdate();
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	con.close();
	
%>
</body>
</html>
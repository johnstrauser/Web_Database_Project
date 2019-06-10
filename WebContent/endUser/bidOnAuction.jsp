<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.sql.Timestamp,java.text.SimpleDateFormat"%>
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
<!-- Check that the bid passed to this page is greater than current bid and starting price -->
<!-- update current bid in auction -->
<!-- create entry for bidHistory -->

<%
	int auctionID = 0;
	try{
		auctionID = Integer.parseInt(request.getParameter("auctionID"));
	}catch(Exception e){
		out.print("failed to parse auctionID = "+request.getParameter("auctionID"));
	}
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	ResultSet auctionResult = null;
	try{
		Statement sellingStmt = con.createStatement();
		String sellingQuery = "SELECT userName FROM Selling WHERE auctionID="+auctionID;
		ResultSet sellingResult = sellingStmt.executeQuery(sellingQuery);
		sellingResult.next();
		if(request.getParameter("userName").equals(sellingResult.getString("userName"))){
			out.print("ERROR: cannot bid on your own auction.");
		}else{
			Statement stmt = con.createStatement();
			String get = "SELECT * FROM Auction WHERE auctionID="+auctionID;
			auctionResult = stmt.executeQuery(get);
			auctionResult.next();
			
			double currBid = auctionResult.getDouble("currentBid");
			double startPrice = auctionResult.getDouble("Start_price");
			
			double newBid = Double.parseDouble(request.getParameter("bid"));
			newBid = Double.parseDouble(String.format("%.2f", newBid));
			
			if(newBid > currBid && newBid >= startPrice){
				String update = "UPDATE Auction SET currentBid=? WHERE auctionID=?";
				PreparedStatement ps = con.prepareStatement(update);
				
				ps.setDouble(1, newBid);
				ps.setInt(2, auctionID);
				
				ps.executeUpdate();
				
				String insert = "INSERT INTO Bid_History(accountID, bid, DateNTime, auctionID)" + " VALUES (?,?,?,?)";
				ps = con.prepareStatement(insert);
				
				SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Calendar c = Calendar.getInstance();
				String cString = c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DAY_OF_MONTH)+" "+c.get(Calendar.HOUR_OF_DAY)+":00:00";
				java.util.Date d = sdf.parse(cString);
				java.sql.Timestamp ts = new java.sql.Timestamp(d.getTime());
				
				ps.setString(1, request.getParameter("userName"));
				ps.setDouble(2, newBid);
				ps.setTimestamp(3, ts);
				ps.setInt(4, auctionID);
				
				ps.executeUpdate();
				out.print("Bid has been placed.");
				
				//Try to proivde alert to user that they have been outbid
				String bidHistGet = "SELECT DISTINCT accountID FROM Bid_History WHERE auctionID="+auctionID+" AND accountID!='"+request.getParameter("userName")+"'";
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
					messagePs.setString(4, "Your bid on "+item.getInt("Year")+" "+item.getString("make")+" "+item.getString("Model")+" has been outbid by a vlaue of $"+newBid);
			
					messagePs.executeUpdate();
				}
				
				
			}else{
				out.print("ERROR: New bid must be greater than current bid and greater than or equal to starting price.");
			}
		}
	}catch(NumberFormatException e){
		out.print("ERROR: New bid must be a number.");
	}catch(Exception e){
		e.printStackTrace();
	}
	
	con.close();
	
%>
</body>
</html>
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
<input type="button" value="Logout" name="Logout" onclick = "openPage('../index.jsp')"/>
<form method="post" action="mainMenu.jsp">
<input type="submit" value="Back to Main Menu"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br><br>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>
<%
	int y=0,m=0,sP=0,mP=0,bNP=0;
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try{
		//Handle item info
		String category = request.getParameter("category");
		int year = Integer.parseInt(request.getParameter("year"));
		y=1;
		String make = request.getParameter("make");
		String model = request.getParameter("model");
		String color = request.getParameter("color");
		int mileage = Integer.parseInt(request.getParameter("mileage"));
		m=1;
		String user = request.getParameter("userName");
		int id=-1;
		
		//Determine if item exists
		Statement stmt = con.createStatement();
		String get = "SELECT productID FROM item WHERE subcategory='"+category+"' AND color='"+color+"' AND make='"+make+"' AND mileage="+mileage+" AND Year="+year+" AND Model='"+model+"'";
		
		ResultSet result = stmt.executeQuery(get);
		int productID;
		if(result.next()){
			//product exists
			//get id from query
			productID = result.getInt("productID");
			//out.print(productID+" exists");
		}else{
			//product does not exist yet
			//Get max product id and add 1, then make new product
			stmt = con.createStatement();
			get = "SELECT MAX(productID) maxID FROM item";
			result = stmt.executeQuery(get);
			result.next();
			productID = result.getInt("maxID")+1;
			//out.print(productID+" is being made");
			
			String insert = "INSERT INTO item(productID,subcategory,color,make,mileage,Year,Model)" + " VALUES (?,?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(insert);
			
			ps.setInt(1, productID);
			ps.setString(2, category);
			ps.setString(3, color);
			ps.setString(4, make);
			ps.setInt(5, mileage);
			ps.setInt(6, year);
			ps.setString(7, model);
			
			ps.executeUpdate();
			//out.print(" done");
		}
		
		//Handle auction info
		Double startPrice = Double.parseDouble(request.getParameter("startPrice"));
		startPrice = Double.parseDouble(String.format("%.2f", startPrice));
		sP=1;
		Double minPrice = Double.parseDouble(request.getParameter("minPrice"));
		minPrice = Double.parseDouble(String.format("%.2f", minPrice));
		mP=1;
		Double buyNowPrice = Double.parseDouble(request.getParameter("buyNowPrice"));
		minPrice = Double.parseDouble(String.format("%.2f", minPrice));
		bNP=1;
		int lengthDays = Integer.parseInt(request.getParameter("days"));
		int lengthHours = Integer.parseInt(request.getParameter("hours"));
		//calculate dates based off length
		SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, lengthDays);
		c.add(Calendar.HOUR_OF_DAY, lengthHours);
		String cString = c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DAY_OF_MONTH)+" "+c.get(Calendar.HOUR_OF_DAY)+":00:00";
		java.util.Date d = sdf.parse(cString);
		java.sql.Timestamp ts = new java.sql.Timestamp(d.getTime());
		//create auction
		stmt = con.createStatement();
		get = "SELECT MAX(auctionID) maxID FROM Auction";
		result = stmt.executeQuery(get);
		result.next();
		int auctionID = result.getInt("maxID")+1;
		//out.print(auctionID+" is being made");
		String insert = "INSERT INTO Auction(auctionID,currentBid,buyNow,endDate,productID,Min_price,Start_price,Sold)" + " VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(insert);
		
		ps.setInt(1, auctionID);
		ps.setDouble(2, 0);
		ps.setDouble(3, buyNowPrice);
		ps.setTimestamp(4, ts);
		ps.setInt(5, productID);
		ps.setDouble(6, minPrice);
		ps.setDouble(7, startPrice);
		ps.setInt(8, 0);
		
		ps.executeUpdate();
		
		//Create new entry in Selling table
		
		insert = "INSERT INTO Selling(auctionID,userName)"+ " VALUES (?,?)";
		ps = con.prepareStatement(insert);
		
		ps.setInt(1, auctionID);
		ps.setString(2, request.getParameter("userName"));
		
		ps.executeUpdate();
		
		//Check if item exists in availableItem alert table
		Statement alertStmt = con.createStatement();
		String alertQuery = "SELECT * FROM AvailableItem WHERE productID="+productID;
		ResultSet alertResult = alertStmt.executeQuery(alertQuery);
		
		while(alertResult.next()){
			String alertUser = alertResult.getString("userName");
			int alertID = alertResult.getInt("alertId");
			
			String messageInsert = "INSERT INTO Messages VALUES(?,?,?,?)";
			PreparedStatement ps2 = con.prepareStatement(messageInsert);
			
			ps2.setString(1, "admin");
			ps2.setString(2, alertUser);
			ps2.setInt(3, alertID);
			ps2.setString(4, "An auction has been created for a "+year+" "+make+" "+model);
			
			ps2.executeUpdate();
		}
		
		//Once all done provide button to go back to main menu
		out.print("Auction creation successful.<br>");
		
	}catch(NumberFormatException e){
		if(y==0){
			out.print("ERROR: year must be a number with no decimals<br>");
		}else if(m==0){
			out.print("ERROR: mileage must be a number with no decimals<br>");
		}else if(sP==0){
			out.print("ERROR: starting price must be a number<br>");
		}else if(mP==0){
			out.print("ERROR: minimum price must be a number<br>");
		}else if(bNP==0){
			out.print("ERROR: buy now price must be a number<br>");
		}
		%>
			<form method="post" action="createAuction.jsp">
				<input type="submit" value="Back to Create Auction"/>
				<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
			</form>
		<%
	}catch(Exception e){
		out.print(e+"<br>");
	}
	con.close();
%>
</body>
</html>
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
<!--  Query bid history for all bids from this user -->
<%
		String user = request.getParameter("userName");
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		try{
			Statement stmt = con.createStatement();
			String get = "SELECT * FROM Bid_History WHERE accountID='"+user+"'";
			ResultSet result = stmt.executeQuery(get);
			int count = 0;
			while(result.next()){
				count++;
				if(count==1){
				%>
				<!-- Display bid history for this user -->
					<table border="1">
						<tr>
							<td>Bid</td>
							<td>Occurred At</td>
							<td>Category</td>
							<td>Year</td>
							<td>Make</td>
							<td>Model</td>
							<td>Color</td>
							<td>Mileage</td>
						</tr>
					
				<%
				}
				//Query Auction table for productID
				Statement stmt2 = con.createStatement();
				String getAuction = "SELECT productID FROM Auction WHERE auctionID="+result.getInt("auctionID");
				ResultSet auctionResult = stmt2.executeQuery(getAuction);
				auctionResult.next();
				//Query item table for product info
				Statement stmt3 = con.createStatement();
				String getItem = "SELECT * FROM item WHERE productID="+auctionResult.getInt("productID");
				ResultSet itemResult = stmt3.executeQuery(getItem);
				itemResult.next();
				//Print info
				out.print("<tr>");
				out.print("<td>"+result.getDouble("bid")+"</td>");
				out.print("<td>"+result.getDate("DateNTime")+"</td>");
				out.print("<td>"+itemResult.getString("subcategory")+"</td>");
				out.print("<td>"+itemResult.getInt("Year")+"</td>");
				out.print("<td>"+itemResult.getString("make")+"</td>");
				out.print("<td>"+itemResult.getString("Model")+"</td>");
				out.print("<td>"+itemResult.getString("color")+"</td>");
				out.print("<td>"+itemResult.getInt("mileage")+"</td>");
				out.print("</tr>");
				
			}
			%>
				</table>
			<%
			if(count == 0){
				out.print("No bid history exists for this user.");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		con.close();
%>
</body>
</html>
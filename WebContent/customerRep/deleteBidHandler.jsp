<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*" %>
  <%@ page import="javax.servlet.http.*, javax.servlet.*" %>
  <%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href=pageURL;
}
</script>
<input type="button" value="Logout" name="Logout" onclick="openPage('../index.jsp')"/>
<form method="post" action="mainMenu.jsp">
<input type="submit" value="Back to Main Menu"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<h2> Successfully Deleted Bid </h2>
<table>
	
	<tr>
		<td>Auction ID: <%out.print(request.getParameter("auctionID")); %></td>
	</tr>
	<tr>
		<td>Account ID: <%out.print(request.getParameter("accountID")); %></td>
	</tr>
	<tr>
		<td>Bid Amount: <%out.print(request.getParameter("bid")); %></td>
	</tr>
	
</table>
	<%
		try{
				
			ApplicationDB db=new ApplicationDB();
			Connection con= db.getConnection();
			
			Statement stmt=con.createStatement();
			BigDecimal bidAMT=new BigDecimal(request.getParameter("bid"));
			int auctionID=Integer.parseInt(request.getParameter("auctionID"));
			
			String delete= "DELETE FROM Bid_History"+" WHERE auctionID='"+auctionID+"' AND accountID='"+request.getParameter("accountID")+"' AND bid='"+bidAMT+"'";
			stmt.executeUpdate(delete);
			
			String prevBid="SELECT MAX(bid) maxBid FROM Bid_History WHERE auctionID='"+auctionID+"'";
			ResultSet rs=stmt.executeQuery(prevBid);
			
			String prevBidSTR;
			if(rs.next()){
				
				prevBidSTR=rs.getString(1);
				
				if(prevBidSTR!=null&&!prevBidSTR.isEmpty()){
					
					BigDecimal updateBid=new BigDecimal(prevBidSTR);
					String updateCurBid="UPDATE Auction SET currentBid='"+updateBid+"' WHERE auctionID='"+auctionID+"'";
					stmt.executeUpdate(updateCurBid);
				}
				else{
					
					BigDecimal zeroBid=new BigDecimal("0.00");
					String zeroBidUpdate="UPDATE Auction SET currentBid='"+zeroBid+"' WHERE auctionID='"+auctionID+"'";
					stmt.executeUpdate(zeroBidUpdate);
				}
												
			}else{
				
				BigDecimal zeroBid=new BigDecimal("0.00");
				String zeroBidUpdate="UPDATE Auction SET currentBid='"+zeroBid+"' WHERE auctionID='"+auctionID+"'";
				stmt.executeUpdate(zeroBidUpdate);
			}
			
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>

</body>
</html>
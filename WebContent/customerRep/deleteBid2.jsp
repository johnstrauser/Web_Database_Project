<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
	<%
		int validQuery=0,y=0,m=0;
		ApplicationDB db=new ApplicationDB();
		Connection con=db.getConnection();
		
		Statement stmt=con.createStatement();
		String get="";
		ResultSet result;
		
		try{
			
			String auctionID=request.getParameter("auctionID");
			
			get="SELECT * FROM Bid_History WHERE auctionID='"+auctionID+"'";
			
			validQuery=1;
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
<form method="post" action="deleteBid2.jsp">
<table>
	<tr>
		<td> AuctionID</td><td><input type="text" name="auctionID">
	</tr>
</table>
<input type="submit" value="Search"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br><br>
<table>
	<tr>
		<td></td>
		<td>Auction ID</td>
		<td>Account ID</td>
		<td>Bid Amount</td>
	</tr>
	<%				
	if(validQuery==1){
		
		
		 result = stmt.executeQuery(get);
		
		while(result.next()){
			out.print("<tr>");
			out.print("<form method='post' action='deleteBidHandler.jsp'>");
			out.print("<td><input type='submit' value='Delete Bid'></td>");
			out.print("<td>"+result.getString("auctionID")+"<input type='hidden' name='auctionID' value='"+result.getString("auctionID")+"'>"+"</td>");
			out.print("<td>"+result.getString("accountID")+"<input type='hidden' name='accountID' value='"+result.getString("accountID")+"'>"+"</td>");
			out.print("<td>"+result.getString("bid")+"<input type='hidden' name='bid' value='"+result.getString("bid")+"'>"+"</td>");
			out.print("<td>"+"<input type='hidden' name='userName' value='"+request.getParameter("userName")+"'>");
			out.print("</form>");
			out.print("</tr>");
		
		}
	}
	
	%>
</table>
</body>
</html>
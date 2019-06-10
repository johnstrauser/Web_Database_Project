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
	<%
		ApplicationDB db=new ApplicationDB();
		Connection con=db.getConnection();
		Statement stmt=con.createStatement();
		
		int auctionID=Integer.parseInt(request.getParameter("auctionID"));
		
		String deleteAuction="DELETE FROM Auction WHERE auctionID='"+auctionID+"'";
		
		stmt.executeUpdate(deleteAuction);
	%>
</body>
</html>
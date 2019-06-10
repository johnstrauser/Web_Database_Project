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
<h3>Delete an Auction</h3>
<table>
	<tr>
		<td></td>
		
		<td>Auction ID</td>
	</tr>

	<%
		ApplicationDB db=new ApplicationDB();
		Connection con=db.getConnection();
		Statement stmt=con.createStatement();
		
		String getAuctions="SELECT * FROM Auction";
		
		ResultSet rs=stmt.executeQuery(getAuctions);
		
		while(rs.next()){
			
			out.print("<form method='post' action='deleteAuctionHandler.jsp'>");
			out.print("<tr>");
			out.print("<td><input type='submit' value='Delete'></td>");
			out.print("<td>"+rs.getString("auctionID")+"<input type='hidden' name='auctionID' value='"+rs.getString("auctionID")+"'>"+"</td>");
			out.print("</tr>");
			out.print("<td>"+"<input type='hidden' name='userName' value='"+request.getParameter("userName")+"'>");
			out.print("</form>");
			
		}
	%>

</table>
</body>
</html>
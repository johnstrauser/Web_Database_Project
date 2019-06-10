<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Total Buy and Sell of End-User Chosen  </h1>

 	<%		 	
 	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

			Statement stmt2 = con.createStatement();
			String get2 = "SELECT SUM(price) sum1 FROM History WHERE userSells='"+ request.getParameter("username") + "'";
			ResultSet result1 = stmt2.executeQuery(get2);
			out.print("User " + request.getParameter("username") +" Sold<br>$");
			if(result1.next()){

				out.print(result1.getDouble("sum1") +"<br>");
			}
				
	//-----------------------------------------
	
			Statement stmt4 = con.createStatement();
			String get4 = "SELECT SUM(price) sum2 FROM History WHERE userBuys='"+ request.getParameter("username") + "'";
			ResultSet result4 = stmt2.executeQuery(get4);
			out.print("User " + request.getParameter("username") +" Spent<br>$");
			if(result4.next()){

				out.print(result4.getDouble("sum2") +"<br>");
			}
	
		out.print("<br>");
		out.print("<br>");
%>

<input type="button" value="Back to Admin menu" onclick = "openPage('mainMenu.jsp')"/>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>

</body>
</html>
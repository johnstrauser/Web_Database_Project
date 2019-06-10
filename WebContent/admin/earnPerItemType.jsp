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
<h1>Total earnings per item type entered  </h1>

 	<%		 	
 	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
 	
	String get2 = "SELECT productID FROM item WHERE subcategory='" + request.getParameter("category") + "'";

	ResultSet result = stmt.executeQuery(get2);	
	Double sum = 0.0;
	while(result.next()){
			Statement stmt2 = con.createStatement();
			String get3 = "SELECT price FROM History WHERE productID="+ result.getInt("productID");
			ResultSet result1 = stmt2.executeQuery(get3);
			if(result1.next()){
				sum += result1.getDouble("price");
			}
	 }
	out.print(request.getParameter("category") +"<br>$");
	out.print(sum);
	
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
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
<h1>Total earnings per item entered  </h1>
 	<%		 	
 	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
 	
 	
 	String get1 = "SELECT SUM(price) sumPrice FROM History WHERE productID='" +request.getParameter("pID") + "'";
	ResultSet result = stmt.executeQuery(get1);	
	out.print("$");
		while(result.next()){
				out.print(result.getInt("sumPrice"));
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Reports</title>
</head>
<body>
 	<h1>Sales Report Page  </h1>
 <%
	 	//Query for all items
	 	ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();

	if(request.getParameter("category").equals("Total Earnings")){
		%><h2>Total Earnings  </h2><%
		String get1 = "SELECT SUM(price) sumPrice FROM History";
		ResultSet result = stmt.executeQuery(get1);	
		out.print("$");
		while(result.next()){
				out.print(result.getInt("sumPrice"));
	 		}	
	}
	else if(request.getParameter("category").equals("Earnings per item")){
	%>
				 <form method="post" action="earnPerItem.jsp"> 	
				<table> 
				<tr>
				<td>Enter Product ID</td><td><input type="text" name="pID">
				</tr>
				
				 </table>     
				   <input type="submit" value="View"/>
				</form>

	<% 	
	 			
	}
	else if(request.getParameter("category").equals("Earnings per item type")){
			 %> <h2>Choose Item Type  </h2>
		<form method="post" action="earnPerItemType.jsp">

			<select name="category" size=1>
							<option value="Sedan">Sedan</option>
							<option value="Coupe">Coupe</option>
							<option value="SUV">SUV</option>

						</select>
						
						<input type="submit" value="View">		
			</form>	
		<%
	}
	else if(request.getParameter("category").equals("Earnings per end-user")){
		%>
		 <form method="post" action="earningEndUser.jsp"> 	
		<table> 
		<tr>
		<td>Enter UserName</td><td><input type="text" name="username">
		</tr>
		
		 </table>     
		   <input type="submit" value="View"/>
		</form>

	<% 
	}
	else if(request.getParameter("category").equals("Best-Selling items")){
		%><h2>Items Sold Best to Worst  </h2><%
		String get1 = "SELECT count(productID) cpID, productID FROM History ORDER BY count(productID) DESC";
		ResultSet result = stmt.executeQuery(get1);	

		while(result.next()){
				out.print("product ID: " + result.getInt("productID") +"   Number sold: "+result.getInt("cpID")+ "<br>");
	 		}	
	}
		
	else if(request.getParameter("category").equals("Best Buyers")){
		%><h2>Buyers Best to Worst  </h2><%
		String get1 = "SELECT count(userBuys) user, userBuys FROM History ORDER BY count(userBuys) DESC";
		ResultSet result = stmt.executeQuery(get1);	

		while(result.next()){
				out.print("User Name: " + result.getString("userBuys") +"   Number items Bought: "+result.getInt("user")+ "<br>");
	 		}	
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
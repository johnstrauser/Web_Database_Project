<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ADMIN HOME</title>
</head>
<body>
   <body> 	<br/>
 	<h1>Welcome Admin!  </h1> 
 	<h3>Create a Customer Representative account  </h3> 

<form method="post" action="createHandler.jsp"> 	
<table> 
<tr>
<td>UserName</td><td><input type="text" name="username">
</tr>
<tr>
<td>PassWord</td><td><input type="text" name="password">
</tr>
 </table>     
   <input type="submit" value="Create"/>
</form>

 
   <h3>Select a Sales Report to generate:  </h3>

<form method="post" action="salesReports.jsp">

<select name="category" size=1>
				<option value="Total Earnings">Total Earnings</option>
				<option value="Earnings per item">Earnings per item</option>
				<option value="Earnings per item type">Earnings per item type</option>
				<option value="Earnings per end-user">Earnings per end-user</option>
				<option value="Best-Selling items">Best-Selling items</option>
				<option value="Best Buyers">Best Buyers</option>
			</select>
			
			<input type="submit" value="View">		
</form>			

<%out.print("<br>");
out.print("<br>");
%>			
<input type="button" value="Back to Index" onclick = "openPage('../index.jsp')"/>
<script type="text/javascript">
	function openPage(pageURL){
		window.location.href = pageURL;
	}
	</script>
</body>
</html>
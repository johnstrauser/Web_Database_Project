<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
<!-- 
	Fields needed:
	-Image? - Maybe if we finish in time
	-Category
	-Year
	-Make
	-Model
	-Color
	
	-Starting Price
	-Minimum Price
	-Buy Now Price
	
	-Length (days)
	-Length (hours)
-->

<form method="post" action="runCreateAuction.jsp">
	<table>
		<tr>
			<td>Item Info:</td>
		</tr>
		<tr>
			<td>Category</td>
			<td><select name="category" size=1>
				<option value="Sedan">Sedan</option>
				<option value="SUV">SUV</option>
				<option value="Coupe">Coupe</option>
			</select></td>
		</tr>
		<tr>
			<td>year</td>
			<td><input type="text" name="year"></td>
		</tr>
		<tr>
			<td>make</td>
			<td><input type="text" name="make"></td>
		</tr>
		<tr>
			<td>model</td>
			<td><input type="text" name="model"></td>
		</tr>
		<tr>
			<td>color</td>
			<td><input type="text" name="color"></td>
		</tr>
		<tr>
			<td>mileage</td>
			<td><input type="text" name="mileage"></td>
		</tr>
		<tr>
			<td><input type="hidden" name="userName" value="<%out.print(request.getParameter("userName"));%>"></td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td>Auction Info:</td>
		</tr>
		<tr>
			<td>Starting Price</td><td><input type="text" name="startPrice"></td>
		</tr>
		<tr>
			<td>Minimum Price (optional)</td><td><input type="text" name="minPrice"></td>
		</tr>
		<tr>
			<td>Buy Now Price</td><td><input type="text" name="buyNowPrice"></td>
		</tr>
		<tr>
			<td>Auction Length (Days)</td>
			<td><select name="days" size=1>
				<%
					for(int i=0; i<=9; i++){
						out.print("<option value='"+i+"'>"+i+"</option>");
					}
				%>
			</select></td>
		</tr>
		<tr>
			<td>Auction Length (Hours)</td>
			<td><select name="hours" size=1>
				<%
					for(int i=0; i<=23; i++){
						out.print("<option value='"+i+"'>"+i+"</option>");
					}
				%>
			</select></td>
		</tr>
		<tr></tr>
		<tr>
			<td><input type="submit" value="Submit"></td>
		</tr>
	</table>
</form>
</body>
</html>
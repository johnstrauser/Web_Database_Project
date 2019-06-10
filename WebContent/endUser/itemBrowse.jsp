<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>
</head>
<body>
<input type="button" value="Logout" name="Logout" onclick = "openPage('../index.jsp')"/>
<form method="post" action="mainMenu.jsp">
<input type="submit" value="Back to Main Menu"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br><br>
<!-- 
	First Page:
		-Select a category (Sedan, SUV, Coup)
			-sends to second page using form
		-List of links to all items
		
	Second Page:
		-Gets category from previous page
		-Populates dropdown menus for details using query
			-submitting dropdown menu sends to same page where the list of items is refined
		-List of links to all items within category and dropdowns
 -->
 <form method="post" action="itemBrowseLv2.jsp">
 <table>
 	<tr>
			<td>Category</td>
			<td><select name="category" size=1>
				<option value="Sedan">Sedan</option>
				<option value="SUV">SUV</option>
				<option value="Coupe">Coupe</option>
			</select></td>
			<td></td>
			<td>year</td>
			<td><input type="text" name="year"></td>
		</tr>
		<tr>
			<td>make</td>
			<td><input type="text" name="make"></td>
			<td></td>
			<td>model</td>
			<td><input type="text" name="model"></td>
		</tr>
		<tr>
			<td>color</td>
			<td><input type="text" name="color"></td>
			<td></td>
			<td>mileage</td>
			<td><input type="text" name="mileage"></td>
		</tr>
		<tr>
			<td><input type="submit" value="Search"></td>
			<td><input type="hidden" name="userName" value="<%out.print(request.getParameter("userName"));%>"></td>
		</tr>
</table>
</form>
<br><br>
<!-- Display list of all items here
		[button][category][year][make][model][color][mileage]
 -->
<table border="1">
	<tr>
		<td></td>
		<td>Category</td>
		<td>Year</td>
		<td>Make</td>
		<td>Model</td>
		<td>Color</td>
		<td>Mileage</td>
	</tr>
	<!-- for each item
			create tr
				create form
					create button
					display each column and have hidden field
					have hidden field for username
				close form
			close row
	 -->
	 <%
	 	//Query for all items
	 	ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement stmt = con.createStatement();
		String get = "SELECT * FROM item";
		
		ResultSet result = stmt.executeQuery(get);
	 
	 	while(result.next()){
	 		out.print("<tr>");
	 		out.print("<form method='post' action='itemView.jsp'>");
	 		out.print("<td><input type='submit' value='View Item'></td>");
	 		out.print("<td>"+result.getString("subcategory")+"<input type='hidden' name='category' value='"+result.getString("subcategory")+"'>"+"</td>");
	 		out.print("<td>"+result.getString("Year")+"<input type='hidden' name='year' value='"+result.getString("Year")+"'>"+"</td>");
	 		out.print("<td>"+result.getString("make")+"<input type='hidden' name='make' value='"+result.getString("make")+"'>"+"</td>");
	 		out.print("<td>"+result.getString("Model")+"<input type='hidden' name='model' value='"+result.getString("Model")+"'>"+"</td>");
	 		out.print("<td>"+result.getString("color")+"<input type='hidden' name='color' value='"+result.getString("color")+"'>"+"</td>");
	 		out.print("<td>"+result.getString("mileage")+"<input type='hidden' name='mileage' value='"+result.getString("mileage")+"'>"+"</td>");
	 		out.print("<input type='hidden' name='userName' value='"+request.getParameter("userName")+"'>");
	 		out.print("<input type='hidden' name='productID' value='"+result.getString("productID")+"'>");
	 		out.print("</form>");
	 		out.print("</tr>");
	 	}
	 	con.close();
	 %>
</table>
</body>
</html>
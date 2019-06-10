<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
	Second Page:
		-Gets category from previous page
		-Populates dropdown menus for details using query
			-submitting dropdown menu sends to same page where the list of items is refined
		-List of links to all items within category and dropdowns
 -->

 <% 
 	int validQuery = 0,y=0,m=0;
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
		 		
	Statement stmt = con.createStatement();
	String get = "";
	ResultSet result;
 	try{
 		//get a list of results using query from other page
 	 	String category = request.getParameter("category");
 		String year = request.getParameter("year");
 		String make = request.getParameter("make");
 		String model = request.getParameter("model");
 		String color = request.getParameter("color");
 		String mileage = request.getParameter("mileage");
 		String user = request.getParameter("userName");
 		
 		
 		//

 		get = "SELECT * FROM item WHERE subcategory = '"+category+"'";
 		if(year.compareTo("") != 0){
 			int yearInt = Integer.parseInt(year);
 			y=1;
 			get += " AND Year="+yearInt+"";
 		}
 		if(make.compareTo("") != 0){
 			get += " AND make='"+make+"'";
 		}
 		if(model.compareTo("") != 0){
 			get += " AND Model='"+model+"'";
 		}
 		if(color.compareTo("") != 0){
 			get += " AND color='"+color+"'";
 		}
 		if(mileage.compareTo("") != 0){
 			int mileInt = Integer.parseInt(mileage);
 			m=1;
 			get += " AND mileage="+mileInt+"";
 		}
 		validQuery=1;
 		//out.print("query= "+get);
 	}catch(NumberFormatException e){
		if(y==0){
			out.print("ERROR: year must be a number with no decimals<br>");
		}else if(m==0){
			out.print("ERROR: mileage must be a number with no decimals<br>");
		}
		%> <input type="button" value="Back to Browse" onclick="openPage('itemBrowse.jsp')"/><%
	}catch(Exception e){
 		e.printStackTrace();
 	}
 %>
 
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
 <%
 	if(validQuery==1){
 		result = stmt.executeQuery(get);
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
 	}
 con.close();
 %>
</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.mysql.jdbc.exceptions.jdbc4.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//out.print(request.getParameter("username") + "<br>");
	//out.print(request.getParameter("password"));
%>
<br>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>
<br>
	<%
	try{
		String user = request.getParameter("username");
		String pass = request.getParameter("password");
		//String email = request.getParameter("email");
		//String name = request.getParameter("name");
		//String address = request.getParameter("address");
		
	//	if(user.compareTo("")!=0 && pass.compareTo("")!=0 && email.compareTo("")!=0 && name.compareTo("")!=0 && address.compareTo("")!=0){
	if(user.compareTo("")!=0 && pass.compareTo("")!=0 ){
		ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
		
			Statement stmt = con.createStatement();
			
			String insert = "INSERT INTO account(userName,password,email,name,address,accountType) VALUES (?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(insert);
			
			ps.setString(1, user);
			ps.setString(2, pass);
			ps.setString(3, "1");
			ps.setString(4, "1");
			ps.setString(5, "1");
			ps.setInt(6, 2);
			
			ps.executeUpdate();
			
			con.close();
			
			out.print("Account creation successful<br>");
			%> <input type="button" value="Back to Index" onclick = "openPage('../index.jsp')"/> <%
		}else{
			out.print("All fields must be filled<br>");
			%> <input type="button" value="Back to Account Creation" onclick = "openPage('./mainMenu.jsp')"/> <%
		}
	}catch(MySQLIntegrityConstraintViolationException e){
		out.print("Account creation failed, username already taken<br>");
		%> <input type="button" value="Back to Account Creation" onclick = "openPage('./mainMenu.jsp')"/> <%
	}catch(Exception e){
		out.print(e);
		out.print("<br>");
		out.print("Create failed<br>");
		%> <input type="button" value="Back to Account Creation" onclick = "openPage('./mainMenu.jsp')"/> <% 
	}
	
	%>
</body>
</html>
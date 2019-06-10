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
Login Successful
<br>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>
<br>
	<%
	//List<String> list = new ArrayList<String>();
	try{
		String user = request.getParameter("username");
		String pass = request.getParameter("password");
		
		//out.print("Username = "+user+"\n");
		//out.print("Password = "+pass+"\n");
		
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement stmt = con.createStatement();
		//TODO - include account type in this query
		String get = "SELECT password,accountType FROM account WHERE userName = '"+user+"'";
		
		ResultSet result = stmt.executeQuery(get);
		
		if(result.next()){
			if(pass.compareTo(result.getString("password")) == 0){
				out.print("Login successful<br>");
				//TODO - adjust this set of if statements as necessary
				if(result.getInt("accountType") == 1){
					//Enduser
					out.print("<form method='post' action='./endUser/mainMenu.jsp'>");
					out.print("<input type='submit' value='Proceed to Main Menu'/>");
					out.print("<input type='hidden' name='userName' value='"+user+"'></form>");
				}else if(result.getInt("accountType") == 2){
					//Customer Rep
					out.print("<form method='post' action='./customerRep/mainMenu.jsp'>");
					out.print("<input type='submit' value='Proceed to Main Menu'/>");
					out.print("<input type='hidden' name='userName' value='"+user+"'></form>");
				}else if(result.getInt("accountType") == 3){
					//Admin
					out.print("<form method='post' action='./admin/mainMenu.jsp'>");
					out.print("<input type='submit' value='Proceed to Main Menu'/>");
					out.print("<input type='hidden' name='userName' value='"+user+"'></form>");
				}else{
					out.print("ERROR: account has no type associated to it<br>");
					%><br><input type="button" value="Back to Login" onclick ="openPage('LogIn.jsp')"/><%
				}
				
				
			}else{
				out.print("login not successful, password does not match");
				%><br><input type="button" value="Back to Login" onclick ="openPage('LogIn.jsp')"/><%
			}
		}else{
			out.print("login not successful, invalid username");
			%><br><input type="button" value="Back to Login" onclick ="openPage('LogIn.jsp')"/><%
		}
		
		con.close();
		
		
	}catch(Exception e){
		//out.print(e);
		out.print("Login failed");
		out.print("<br><input type='button' value='Back to Login' name='Back' onclick = 'openPage('LogIn.jsp')'/>");
	}
	
	%>

</body>
</html>
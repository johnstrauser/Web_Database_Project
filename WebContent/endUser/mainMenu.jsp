<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>end user main menu</title>
</head>
<body>
<script type="text/javascript">
function openPage(pageURL){
	window.location.href = pageURL;
}
</script>
<input type="button" value="Logout" name="Logout" onclick = "openPage('../index.jsp')"/><br>
<!-- Need actions for
		(Core Functionality)
		1. Auction Creation
		3. Item Browse
		
		(Account Functionality)
		4. Check Messages (in/out)
		5. Check Active Bids
		6. Check Bid History
		
-->
<%
	out.print(request.getParameter("userName")+"<br>");
%>

<br>
<form method="post" action="createAuction.jsp">
<input type="submit" value="Create Auction"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br>

<form method="post" action="itemBrowse.jsp">
<input type="submit" value="Browse Items"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>

<br>

<form method="post" action="messages.jsp">
<input type="submit" value="Check Messages"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br>
<form method="post" action="bidHistory.jsp">
<input type="submit" value="Check Bid History"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br>
<form method="post" action="auctionParticipation.jsp">
<input type="submit" value="View Auctions You Have Participated In"/>
<input type="hidden" name="userName" value="<%out.print(request.getParameter("userName")); %>">
</form>
<br>
</body>
</html>
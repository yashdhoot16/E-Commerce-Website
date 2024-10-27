<%@page import="com.myProject.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.myProject.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
		User auth =(User) request.getSession().getAttribute("auth");
		if(auth != null)
		{
			response.sendRedirect("index.jsp");
		}
		ArrayList<Cart>cart_list =(ArrayList<Cart>)session.getAttribute("cart-list");	
		if(cart_list != null){		
		request.setAttribute("cart_list", cart_list);
	}
	 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Shopping Cart Login</title>
<%@include file="includes/head.jsp" %>
</head>
<body>
<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form action="user-login" method="post">
					<div class="form-group">
						<label>Email Address</label>
						<input type="email" name="login-email" class="form-control" placeholder="Enter your Email" required>
					</div>
					<div class="form-group">
						<label>Password</label>
						<input type="password" name="login-password" class="form-control" placeholder="*******" required>
					</div>
					<div class="text-center">
						<button class="btn btn-primary" type="submit">Login</button>
					</div>
				</form>
			</div>
		</div>	
	</div>

<%@include file="includes/footer.jsp" %>
</body>
</html>
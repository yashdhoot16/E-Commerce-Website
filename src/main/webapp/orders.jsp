<%@page import="com.myProject.connection.DbCon"%>
<%@page import="com.myProject.dao.OrderDao"%>
<%@page import="com.myProject.model.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.myProject.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.myProject.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%
   		DecimalFormat dcf = new DecimalFormat("#.##");
   		request.setAttribute("dcf", dcf);
		User auth =(User) request.getSession().getAttribute("auth");
		List<Order> orders= null;
		if(auth != null)
		{
			request.setAttribute("auth", auth);
			orders = new OrderDao(DbCon.getConnection()).userOrders(auth.getId());
		}else{
			response.sendRedirect("login.jsp");
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
<title>Order Page</title>
<%@include file="includes/head.jsp" %>
</head>
<body>
<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card-header my-3">All Orders</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th>Date</th>
					<th>Name</th>
					<th>Category</th>
					<th>Quantity</th>
					<th>Price</th>
					<th>Cancel</th>
				</tr>
			</thead>
			<tbody>
				<%
					if(orders != null){
						for(Order o:orders){%>
						
							<tr>
								<td><%= o.getDate() %> </td>
								<td><%= o.getName() %> </td>
								<td><%= o.getCategory() %> </td>
								<td><%= o.getQuantity() %> </td>
								<td><%= dcf.format(o.getPrice())%> </td>
								<td><a href="cancel-order?id=<%= o.getOrderId() %>" class="btn btn-sm btn-danger">Cancel</a></td>
							</tr>							
						<% }
					}
				 %>
			</tbody>
		</table>
	</div>
<%@include file="includes/footer.jsp" %>
</body>
</html>
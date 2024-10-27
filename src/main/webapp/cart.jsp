<%@page import="java.text.DecimalFormat"%>
<%@page import="com.myProject.connection.DbCon"%>
<%@page import="com.myProject.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="com.myProject.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.myProject.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    	DecimalFormat dcf = new DecimalFormat("#.##");
    	request.setAttribute("dcf", dcf);
		User auth =(User) request.getSession().getAttribute("auth");
		if(auth != null)
		{
			request.setAttribute("auth", auth);
		}
		ArrayList<Cart>cart_list =(ArrayList<Cart>)session.getAttribute("cart-list");//this come form AddToCartServlet
		List<Cart> cartProduct = null;
		if(cart_list != null){
			ProductDao pDao = new ProductDao(DbCon.getConnection());
			cartProduct=pDao.getCartProducts(cart_list);
			request.setAttribute("cart_list", cart_list);
			double total = pDao.getTotalCartPrice(cart_list);
			request.setAttribute("total", total);
		}
	 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cart Page</title>
<%@include file="includes/head.jsp" %>
<style type="text/css">
	.table tbody td {
		vertical-align: middle;
	}
	.btn-incre, .btn-decre{
		box-shadow: none;
		font-size: 25px;
	}
</style>
</head>
<body>
<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="d-flex py-3">
			<h3>Total Price: $ ${(total>0)?dcf.format(total):0 }</h3><a class="btn btn-primary mx-3" href="check-out">Check out</a>
		</div>	
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Name</th><th scope="col">Category</th><th scope="col">Price</th><th scope="col">Buy Now</th><th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
				<%
					if(cart_list != null)
					{
						for(Cart c:cartProduct){ %>
							<tr>
								<td><%= c.getName() %></td>
								<td><%= c.getCategory() %></td>
								<td>$<%= dcf.format(c.getPrice())%></td>
								<td>
									<form action="order-now" method="post" class="form-inline">
										<input type="hidden" name ="id" value ="<%=c.getId() %>" class="form-input">
										<div class="form-group d-flex justify-content-between w-50">
											<a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%= c.getId() %>"><i class="fas fa-minus-square"></i></a>
											<input type="text" name="quantity" class="form-control w-50" value ="<%= c.getQuantity() %>" readonly>
											<a class="btn btn-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%= c.getId() %>"><i class="fas fa-plus-square"></i></a>																								
										</div>
										<button type="submit" class="btn btn-primary btn-sm">Buy Now</button>
									</form>
								</td>
								<td>
									<a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%= c.getId() %>">Remove</a>
								</td>
							</tr>
						<%}
					}					
				 %>
				
			</tbody>
		</table>
	</div>
<%@include file="includes/footer.jsp" %>
</body>
</html>
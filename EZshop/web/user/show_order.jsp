<%@page import="uuu.totalbuy.domain.Product"%>
<%@page import="uuu.totalbuy.domain.OrderItem"%>
<%@page import="uuu.totalbuy.domain.Order"%>
<%@page import="uuu.totalbuy.model.OrderService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getMethod().equalsIgnoreCase("get")) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
        return;
    }

    String oid = request.getParameter("oid");
    if (oid != null && oid.matches("\\d+")) {

        OrderService service = new OrderService();
        Order order = service.get(Integer.parseInt(oid));
        if (order != null) {
%>
<!DOCTYPE html>
<div style="font-size: smaller">
    <h5>Order number: <%= order.getId()%>, Order time: <%= order.getOrderTime()%></h5>
    <table>
        <tr><th>No.</th><th>Name.</th><th>price</th><th>quantity</th><th>gift</th></tr>
                <% for (OrderItem item : order.getOrderItems()) {%>
        <tr><td><%= item.getProduct().getId()%></td>
            <td><%= item.getProduct().getName()%></td>
            <td><%= Product.priceFormat.format(item.getPrice())%></td>
            <td><%= item.getQuantity()%></td>
            <td><%= item.isFree() ? "Yes" : "No"%></td></tr>
            <%}%>
        <tr><td colspan="5">
                <fieldset>
                    <legend>Receiver info</legend>
                    Name: <%= order.getReceiverName()%><br>
                    Email: <%= order.getReceiverEmail()%><br>
                    Phone: <%= order.getReceiverPhone()%><br>
                    Address: <%= order.getShippingAddress()%>
                </fieldset>
            </td></tr>  
    </table>        
</div>
<%      return;
} else { %>
<h5>found no order!</h5>
<%      } %>
<h5>found no order number!</h5>
<%  }%>
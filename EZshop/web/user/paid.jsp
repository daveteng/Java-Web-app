<%@page import="uuu.totalbuy.domain.*"%>
<%@page import="uuu.totalbuy.model.OrderService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/subviews/header.jsp" >
    <jsp:param name="subtitle" value="paid"/>
</jsp:include>
<div id="section">section</div>
<div id="article">
    <%
        String oid = request.getParameter("oid");
        if (oid != null && oid.matches("\\d+")) {

            OrderService service = new OrderService();
            Order order = service.get(Integer.parseInt(oid));
            if (order != null) {
    %>
    <!DOCTYPE html>
    <div style="font-size: smaller">
        <p>order number: <%= order.getId()%>, order time: <%= order.getOrderTime()%>, </p>
        <p>
            status:<%=order.getStatus().getDescription()%>
        </p>
        <table>
            <tr><th>No.</th><th>name.</th><th>price</th><th>quantity</th><th>gift</th></tr>
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
    <h5>No order found!</h5>
    <%      } %>
    <h5>No order number found!</h5>
    <%  }%>
</div>
<div id="aside">aside</div>    
<jsp:include page="/WEB-INF/subviews/footer.jsp" />

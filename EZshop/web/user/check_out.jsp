<%@page import="java.util.List"%>
<%@page import="uuu.totalbuy.domain.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="Confirm checkout"%>
<%
    Customer user = (Customer) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<jsp:include page="/WEB-INF/subviews/header.jsp" >
    <jsp:param name="subtitle" value="<%= this.getServletInfo()%>"/>
</jsp:include>
<div id="section">
    <p>section</p>
</div>
<div id="article">
    <%
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart != null && cart.size() > 0) {
            if (cart.getUser() == null) {
                cart.setUser(user);
            }
            
            List<String> errors = (List<String>)request.getAttribute("errors");
            if (errors != null) {
    %>
    <h3>Failed to Add order: </h3>
    <ul>
        <%for (String msg : errors) {%>
            <li><%= msg%></li>
        <%}%>
    </ul>
    <%}%>     
    <form action="check_out.do" method="POST">
        <table style="width:100%">            
            <thead>
                <tr>
                    <th colspan="3" >Product name</th>
                    <th >price</th>
                    <th >quantity</th>                
                    <th >sum</th>
                </tr>
            </thead>            
            <tfoot>
                <% if (user instanceof VIP) {%>
                <tr >
                    <td colspan="3">original sum:</td><td colspan="2">${cart.listTotalAmount}</td>
                </tr>
                <tr >
                    <td colspan="3">VIP discount:</td><td colspan="2"><%= ((VIP) user).getDiscount()%></td>
                </tr>            
                <%}%>
                <tr >
                    <td colspan="3">discounted sum:</td><td colspan="2">${cart.totalAmount}</td>
                </tr>              
                <tr>
                    <td colspan="3">
                        <label for="paymentType">payment type</label>
                        <select id="paymentType" name="paymentType" style="width:20ex" required onchange="paymentChange()" >
                            <option value="">please select...</option>
                            <%for (Order.PaymentType pType : Order.PaymentType.values()) {%>
                                    <option value="<%=pType.name()%>" <%= request.getParameter("paymentType") != null && request.getParameter("paymentType").length() > 0
                                            && pType.equals(Order.PaymentType.valueOf(request.getParameter("paymentType"))) ? "selected" : ""%>><%=pType%></option>
                            <%}%>
                        </select>
                    </td>
                    <td colspan="3">
                        <label for="shippingType">shipping type</label>
                        <select id="shippingType" name="shippingType" style="width:20ex" required onchange="shippingChange()">                    
                        </select>                        
                    </td>
            <script>
                var originalAmount = ${cart.totalAmount};
                var old_shType = "<%=request.getParameter("shippingType")%>";
                $.getScript('${pageContext.request.contextPath}/js/ps.js');
            </script>
            </tr>
            <tr >
                <td colspan="3">final amount including shipping( amount over $10000 free shipping):</td><td colspan="2"><span id="finalAmount">${cart.totalAmount}</span></td>
            </tr>                          
            <tr>
                <td colspan="6">
                    <div style="width:50%;float: left">
                        <fieldset>
                            <legend>client info</legend>
                            <label for="name">name:</label><input id="name" value="${user.name}" readonly><br>
                            <label for="email">email:</label><input id="email" value="${user.email}" readonly><br>
                            <label for="address">address:</label><input id="address" value="${user.address}" readonly><br>
                            <label for="phone">phone:</label><input id="phone" value="${user.phone}" readonly><br>
                        </fieldset>
                    </div>
                    <div style="width:50%;float: left">
                        <fieldset>
                            <legend>receiver info (<a href="javascript:copyUserData()">copy client info</a>)</legend>
                            <label for="receiverName">name:</label>
                            <input id="receiverName" name="receiverName" value="${param.receiverName}" required><br>
                            <label for="receiverEmail">email:</label>
                            <input id="receiverEmail" name="receiverEmail" value="${param.receiverEmail}" required type="email"><br>
                            <label for="receiverAddress">address:</label>
                            <input id="receiverAddress" name="receiverAddress" value="${param.receiverAddress}" required><br>
                            <label for="receiverPhone">phone:</label>
                            <input id="receiverPhone" name="receiverPhone" value="${param.receiverPhone}" required><br>
                        </fieldset>
                    </div>
                </td>                    
            </tr>
            <tr >
                <td colspan="3">
                    <input type="button" value="back to shopping mall" onclick="location.href = '${pageContext.request.contextPath}/products.jsp'">
                </td>
                <td colspan="3">
                    <input type="reset" value="cancel">
                    <input type="submit" name="submit" value="submit"></td>
            </tr>                 
            </tfoot>
            <tbody>
                <% for (Product p : cart.getProductsKeySet()) {%>
                <tr>
                    <td colspan="2"><h4><%= p.getId()%>. <%= p.getName()%></h4></td>
                    <td ><img style="width:120px" src="<%= p.getUrl() != null ? p.getUrl() : request.getContextPath() + "/images/phone.png"%>" alt=""/></td>
                    <td>
                        <% if (p instanceof Outlet) {%>
                        original price: <%= Product.priceFormat.format(((Outlet) p).getListPrice())%><br>
                        <%}%>
                        sale price: <%= Product.priceFormat.format(p.getUnitPrice())%>
                    </td>
                    <td><%= cart.getQuantity(p)%></td>
                    <td><%= Product.priceFormat.format(cart.getQuantity(p) * p.getUnitPrice())%></td>                
                </tr>
                <%}%>
            </tbody>            
        </table>
    </form>    
    <%}%>    
</div>
<div id="aside">
    <p>aside</p>
</div>        
<%@include file="/WEB-INF/subviews/footer.jsp" %>
<script>
    function copyUserData() {
        $("#receiverName").val($("#name").val());
        $("#receiverEmail").val($("#email").val());
        $("#receiverAddress").val($("#address").val());
        $("#receiverPhone").val($("#phone").val());
    }
</script>




<%@page import="uuu.totalbuy.domain.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="shipping_process"%>
<jsp:include page="/WEB-INF/subviews/header.jsp" >
    <jsp:param name="subtitle" value='<%= this.getInitParameter("subtitle")!=null?this.getInitParameter("subtitle"):this.getServletInfo() %>'/>
</jsp:include>
<div id="section">
    <p>section</p>
</div>        
<div id="article">
    <form method="POST" action="process.do">
        <label for="status">Order Status</label>
        <select id="status" name="status" style="width:20ex">
            <option value="">Please select...</option>
            <%for (Order.Status sType : Order.Status.values()) {%>
            <option value="<%=sType.name()%>" <%= request.getParameter("status") != null && request.getParameter("status").length() > 0
                                            && sType.equals(Order.Status.valueOf(request.getParameter("status"))) ? "selected" : ""%>><%=sType.name()%>-<%=sType.getDescription()%></option>
            <%}%>
        </select><br>
        <label for="paymentType">Payment Type</label>
        <select id="paymentType" name="paymentType" style="width:20ex">
            <option value="">Payment Type...</option>
            <%for (Order.PaymentType pType : Order.PaymentType.values()) {%>
            <option value="<%=pType.name()%>" <%= request.getParameter("paymentType") != null && request.getParameter("paymentType").length() > 0
                                            && pType.equals(Order.PaymentType.valueOf(request.getParameter("paymentType"))) ? "selected" : ""%>><%=pType%></option>
            <%}%>
        </select>
        <label for="paymentCheck">Payment Check</label>
        <select id="paymentCheck" name="paymentCheck" style="width:20ex">
            <option value="">Please select...</option>            
            <option value="false" <%= request.getParameter("paymentCheck")!=null && !Boolean.valueOf(request.getParameter("paymentCheck")) ? "selected" :"" %>>Need Confirmed</option>
            <option value="true" <%= request.getParameter("paymentCheck")!=null && Boolean.valueOf(request.getParameter("paymentCheck")) ? "selected" :"" %>>Confirmed</option>
        </select><br>
        <label for="shippingType">Shipping Type</label>
        <select id="paymentType" name="shippingType" style="width:20ex" >
            <option value="">Please select...</option>
            <%for (Order.ShippingType shType : Order.ShippingType.values()) {%>
            <option value="<%=shType.name()%>" <%= request.getParameter("shippingType") != null && request.getParameter("shippingType").length() > 0
                                            && shType.equals(Order.ShippingType.valueOf(request.getParameter("shippingType"))) ? "selected" : ""%>><%=shType%></option>
            <%}%>
        </select><br>        
        <lable for="id">Order number</lable>
        <input id="id" name="id" type="search" value="${param.id}" style="width:50ex" placeholder="Please type in order number"><br>
        <lable for="id">client ID</lable>
        <input id="customer_id" name="customer_id" type="text" pattern="[A-Za-z][12][0-9]{8}" value="${param.customer_id}" style="width:50ex" placeholder="Please type in client ID">
        <input id="submit" name="submit" type="submit" value="search">
    </form>
    <hr>  

</div>
<div id="aside">
    <p>aside</p>
</div>        
<%@include file="/WEB-INF/subviews/footer.jsp" %>

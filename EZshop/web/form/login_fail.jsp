<%@page contentType="text/html" pageEncoding="UTF-8"info="login fail"%>
<jsp:include page="/WEB-INF/subviews/header.jsp" >
    <jsp:param name="subtitle" value="<%= this.getServletInfo()%>"/>
</jsp:include>    
<div id="section">
    <p>section</p>
</div>        
<div id="article">
    <h1>Sign in failed</h1>
</div>
<div id="aside">
    <p>aside</p>
</div>        
<%@include file="/WEB-INF/subviews/footer.jsp" %>    

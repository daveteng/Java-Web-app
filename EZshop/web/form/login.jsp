<%@page contentType="text/html" pageEncoding="UTF-8" info="Sign in"%>
<jsp:include page="/WEB-INF/subviews/header.jsp" >
    <jsp:param name="subtitle" value="<%= this.getServletInfo() %>"/>
</jsp:include>    
<div id="section">
    <p>section</p>
</div>        
<div id="article">
    <form action="j_security_check" method="POST">
      <table>
        <tr><td>account</td><td><input type="text" size="10" name="j_username"/></td></tr>
        <tr><td>password</td><td><input type="password" size="10" name="j_password"/></td></tr>
      </table>
      <input class="btn" type="submit" value="sign_in"/>
    </form>
</div>
<div id="aside">
    <p>aside</p>
</div>        
<%@include file="/WEB-INF/subviews/footer.jsp" %>    

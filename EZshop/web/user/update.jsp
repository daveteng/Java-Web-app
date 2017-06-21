<%@page import="java.util.List"%>
<%@page import="uuu.totalbuy.domain.BloodType"%>
<%@page import="uuu.totalbuy.domain.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="mytags" %>
<c:set var="title" value="member maintainance" scope="page" />
<jsp:include page="/WEB-INF/subviews/header.jsp">
    <jsp:param name="subtitle" value="${title}"/>
</jsp:include>
<%
    Customer user = (Customer) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<div id="section">
    <p>section</p>
</div>
<div id="article">
    <script>
        $(function () {
            var userAgent = navigator.userAgent;
            //alert(userAgent.indexOf("Chrome"));
            if (userAgent.indexOf("Chrome") < 0 && userAgent.indexOf("ipad") < 0 && userAgent.indexOf("iphone") < 0) {
                $("#birthday").datepicker({
                    changeMonth: true,
                    changeYear: true
                });
            }
        });
    </script>
    <%--  List<String> errors = (List<String>)request.getAttribute("errors");
        if (errors != null && errors.size()>0) {--%>
    <c:if test="${not empty requestScope.errors}">
        <h1>fail to update member profile: </h1>
        <ul>
            <%--for (String msg : errors) {--%>
            <c:forEach items="${requestScope.errors}" var="msg">
            <li>${msg}</li>
            </c:forEach>
            <%--}--%>
        </ul>
    </c:if>
    <%--}--%> 
    <!-- content -->
    <form action="" method="POST">
        <p>
            <label for="userid">user account:</label>
            <input id="userid" type='text' name="id" pattern="[A-Za-z][12][0-9]{8}" required placeholder="Type in user ID" readonly
                   value="<%= (request.getMethod().equalsIgnoreCase("get")) ? user.getId() : request.getParameter("id")%>">
        </p>
        <p>
            <label for="name">Name:</label>
            <input id="name" name="name" type='text' required placeholder="Type in user name"
                   value="${pageContext.request.method=='GET'?user.name:param.name}">
        </p>           
        <p>
            <label for="password1">Password:</label>
            <input type="password" id="password1" minlength="4" maxlength="20" name="password1" placeholder="Please type in length 4~20 password" required>   
            <label for="password2">confirmed password:</label>
            <input type="password" id="password2" minlength="4" maxlength="20" name="password2" placeholder="Please type in length 4~20 password" required>   
        </p>
        <p>
            <label>Gender:</label>
            <input type="radio" id="male" name="gender" value="<%=Customer.MALE%>" 
                   <%= (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("gender").charAt(0) == 'M') ? "checked" : ""%>
                   required><label for="male" >male</label>
            <input type="radio" id="female" name="gender" value="<%=Customer.FEMALE%>" 
                   <%= (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("gender").charAt(0) == 'F') ? "checked" : ""%>
                   required><label for="female">female</label>
        </p>
        <p>
            <label for="Email">Email</label>
            <input id="email" name="email" type='email' required placeholder="Type in Email"
                   value="<%= (request.getMethod().equalsIgnoreCase("get")) ? "" : request.getParameter("email")%>">
        </p>             
        <p>
            <%= user.getBirthday().getClass().getName() %>
            <% System.out.println(user.getBirthday()); %>
            <label for="birthday">birthday</label>
            <input id="birthday" name="birthday" type='date'
                   value="<%= request.getMethod().equalsIgnoreCase("get") && user.getBirthday()!=null ? user.getBirthdayString() :
                           (request.getMethod().equalsIgnoreCase("post")?request.getParameter("birthday"):"")%>">
        </p>
        <p>
            <label for="address">address</label>
            <input id="address" name="address" type='text'
                   value="<%= (request.getParameter("address") == null) ? "" : request.getParameter("address")%>">
        </p> 
        <p>
            <label for="phone">phone</label>
            <input id="phone" name="phone" type='tel'
                   value="<%= (request.getParameter("phone") == null) ? "" : request.getParameter("phone")%>">

        </p> 
        <p>
            <label>Married:</label>
            <input id="married" name="married" type='checkbox' 
                   <%= (request.getParameter("married") == null) ? "" : "checked"%>><label for="married">married</label>
        </p> 
        <p>
            <label for="blood_type">blood type:</label>
            <select id="blood_type" name="blood_type">
                <option value="">please select...</option>
                <%for (BloodType bType : BloodType.values()) {%>
                <option value="<%= bType.name()%>" 
                        <%= (request.getParameter("blood_type") != null && request.getParameter("blood_type").length() > 0
                            && BloodType.valueOf(request.getParameter("blood_type")) == bType) ? "selected" : ""%>>
                    <%= bType.toString()%>
                </option>
                <%}%>
            </select>
        </p>            
        <mytags:checkCode src="../images/register_check.jpg" name ="check_code" label="check code"/>  
        <input type="submit" value="submit">
    </form>
</div>
<div id="aside">
    <p>aside</p>
</div>        
<%@include file="/WEB-INF/subviews/footer.jsp" %>
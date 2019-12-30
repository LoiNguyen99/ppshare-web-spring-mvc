<%-- 
    Document   : 404.jsp
    Created on : Nov 10, 2019, 8:51:11 PM
    Author     : Loi Nguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>404</title>
        <jsp:include page="/WEB-INF/jsp/header/header_source.jsp"/>
    </head>
    <body>
        <h1>lỗi 404</h1>
        <p>Vui lòng kiểm tra lại địa chỉ<br/><a href="${pageContext.request.contextPath}/">Trang chủ</a></p>
    </body>
</html>

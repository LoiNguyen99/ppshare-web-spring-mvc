<%-- 
    Document   : login_admin
    Created on : Nov 7, 2019, 12:49:30 PM
    Author     : Loi Nguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <jsp:include page="/WEB-INF/jsp/header/header_source.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/header/header_body.jsp"/>
        <h2 class="title">ADMIN LOGIN</h2>
        <div class="container">
            <form action="login" method="POST" style="width: 50%;margin-left: auto;margin-right: auto;">
                <div class="form-group">
                    <label for="suserid">User ID:</label>
                    <input class="form-control" name="userId" type="text"/>
                    <div class="invalid-message" id="error-category-name"></div>
                </div>  
                <div class="form-group">
                    <label for="sname">Password: </label>
                    <input class="form-control" name="password" type="password"/>
                    <div class="invalid-message" id="error-category-name"></div>
                </div>
                <button class="btn btn-primary">Login</button>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>

<%-- 
    Document   : header
    Created on : Sep 9, 2019, 7:56:14 PM
    Author     : Loi Nguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <body>
        <nav class="navbar navbar-expand-md navbar-light">
            <div class="container-fluid">
                <h1 class="m-0">
                    <a class="navbar-branch" href="${pageContext.request.contextPath}/">
                        <img src="${pageContext.request.contextPath}/resources/logo.png" /> PPShare
                    </a>
                </h1>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/">TRANG CHỦ</a>
                        </li>
                        <li class="nav-item dropdown position-static">
                            <a class="nav-link dropdown-toggle" id="dropMenu" data-toggle="dropdown" href="#">DANH MỤC</a>
                            <div class="dropdown-menu full-menu drop-hover" aria-labelledby="dropMenu">
                                <div class="sub-menu p-5">
                                    <div class="d-flex flex-sm-row flex-column justify-content-center">
                                        <c:forEach items="${applicationScope.categories}" var="category" varStatus="counter">
                                            <div class="p-md-3 bd-highlight">
                                                <h6 style="text-transform: uppercase;">
                                                    <a href="${pageContext.request.contextPath}/trang-trinh-chieu/${category.convertURL()}?cat=${category.categoryId}">${category.categoryName}</a>
                                                </h6>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item mr-3">
                            <a class="nav-link" href="#">LIÊN HỆ</a>
                        </li>
                        <li class="nav-item">
                            <form class="form-inline search" action="${pageContext.request.contextPath}/search" method="GET">
                                <div class="d-flex">
                                    <input name="searchValue" id="searchValue" type="search" class="form-control mr-0" type="text" placeholder="Search">
                                    <button id="btnSearch" class="btn" type="submit"><i class="fas fa-search"></i></button>
                                </div>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

        <script>
            $('.navbar-toggler-icon').click(function () {
                var navbar = $('.navbar').css('background-color');
                if (navbar === 'rgba(0, 0, 0, 0)') {
                    $('.navbar').css('background-color', 'white');
                    $('.navbar').css('color', 'black');
                } else {
                    $('.navbar').css('background', 'none');
                }

            })

            $('#btnSearch').click(function (e) {
                if ($('#searchValue').val().length < 3) {
                    e.preventDefault();
                }
            })

        </script>
    </body>
</html>

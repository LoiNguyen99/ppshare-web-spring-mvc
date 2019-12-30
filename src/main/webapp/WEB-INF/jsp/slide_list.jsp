<%-- 
    Document   : product-list
    Created on : Oct 20, 2019, 2:18:43 PM
    Author     : Loi Nguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách trang trình chiếu ${title}</title>
        <jsp:include page="/WEB-INF/jsp/header/header_meta.jsp" flush="true"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}\resources\js\pagination.js"></script>
        <jsp:include page="/WEB-INF/jsp/header/header_source.jsp"/>
    </head>
    <body>
        <c:url var="root" value="/" scope="request"/>
        <jsp:include page="/WEB-INF/jsp/header/header_body.jsp"/>
        <div class="container-fluid mt-4">
            <nav class="pl-4 pr-4 mb-3" style="margin: 7px;">
                <ol class="breadcrumb mb-1 bg-white color-black underline">
                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${root}trang-trinh-chieu">Trang trình chiếu</a></li>
                        <c:forEach items="${applicationScope.categories}" var="category" varStatus="counter">
                            <c:if test="${category.categoryId == param.cat}">
                                <c:set var="bcategory" value="${category.categoryName}"/>
                            </c:if>
                        </c:forEach>
                    <li class="breadcrumb-item active" aria-current="page">${param.cat == '0' || param.cat == null ? 'Tất cả': bcategory}</li>
                </ol>
            </nav>
            <form class="ml-4 mr-4" action="${root}trang-trinh-chieu" style="padding: 7px;">
                <select name="cat" class="custom-select" style="width: auto;">
                    <option value="0">Tất cả danh mục</option>
                    <c:forEach items="${categories}" var="category" varStatus="counter">
                        <option value="${category.categoryId}" ${param.cat == category.categoryId ? 'selected' : ''}>${category.categoryName}</option>
                    </c:forEach>
                </select>
                <select name="order" class="custom-select" style="width: auto;">
                    <c:forEach items="${orders}" var="order" varStatus="counter">
                        <option value="${order.key}" ${param.order == order.key ? 'selected' : ''}>${order.value}</option>
                    </c:forEach>
                </select>
                <input type="submit" class="btn btn-info" value="Chọn" />
            </form>

            <div class="row mb-0">
                <c:forEach items="${slides}" var="slide" varStatus="counter">
                    <div class="col-sm-6 col-md-6 col-lg-3 h-auto">
                        <div class="card h-100 shadow1">
                            <img class="card-img-top" src="${slide.avatarPath}" alt="${slide.convertURL()}" style="width:100%;">
                            <div class="card-body">
                                <h4 class="card-title">
                                    <a class="middle-underline" href="${root}trang-trinh-chieu/${slide.slideId}/${slide.convertURL()}">${slide.slideName}</a>
                                </h4>
                            </div>
                            <div class="card-footer text-muted">
                                <a href="${root}trang-trinh-chieu/${slide.slideId}/${slide.convertURL()}" class="btn btn-primary gradient">Chi Tiết</a>

                                <c:set var="fileParts" value="${fn:split(slide.filePath,'/')}"/>
                                <c:set var="fileName" value="${fileParts[fn:length(fileParts) - 1]}"/>
                                <a href="${root}download/${slide.slideId}/${fileName}" class="btn float-right">
                                    <i class="fas fa-download" style="font-size: 22px; color: #F74F67;"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <nav class="row mb-0">
                <ul class="col-12 pagination pagination-md" id="paging">
                </ul>
            </nav>

            <!-- CHANGE PAGE -->
            <form action="trang-trinh-chieu" method="GET" id="change-page">
                <c:if test="${param.category != null}">
                    <input type="hidden" value="${param.category}" name="category"/>
                </c:if>
                <c:if test="${param.orderBy != null}">
                    <input type="hidden" value="${param.orderBy}" name="orderBy"/>
                </c:if>
                <input id="page-value" type="hidden" value="1" name="page"/>
            </form>
        </div>

        <div class="container-fluid mb-4">
            <!-- wide ads -->
            <div class="wide-ads">
                <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                <ins class="adsbygoogle"
                     style="display:inline-block;width:100%;height:120px"
                     data-ad-client="ca-pub-8947345672774709"
                     data-ad-slot="5438314698"></ins>
                <script>
                    (adsbygoogle = window.adsbygoogle || []).push({});
                </script>
            </div>
        </div>      

        <jsp:include page="footer.jsp"/>
        <script>
            // pagingation
            var numsOfPage = "${numsOfPage}";
            var currentPage = "${page}";
            pagination(numsOfPage, currentPage);
            currentURL();

        </script>
        <script>
            (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
    </body>
</html>

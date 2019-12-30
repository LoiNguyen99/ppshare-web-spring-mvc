<%-- 
    Document   : search
    Created on : Oct 29, 2019, 6:36:29 PM
    Author     : Loi Nguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Search - ${param.searchValues}</title>
        <jsp:include page="/WEB-INF/jsp/header/header_meta.jsp" flush="true"/>
        <jsp:include page="/WEB-INF/jsp/header/header_source.jsp"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}\resources\js\pagination.js"></script>
    </head>
    <body>
        <c:url var="root" value="/" scope="request"/>
        <jsp:include page="header/header_body.jsp"/>
        <div class="container-fluid mt-4">
            <h5 class="ml-4" style="padding: 7px;color: white;">Kết quả tìm kiếm cho ${param.searchValue}</h5>
            <c:if test="${slides != null}">
                <div class="row mb-0">
                    <c:forEach items="${slides}" var="slide" varStatus="counter">
                        <div class="col-sm-6 col-md-6 col-lg-3 h-auto">
                            <div class="card h-100 shadow1">
                                <img class="card-img-top" src="${slide.avatarPath}" alt="${slide.convertURL()}" style="width:100%;">
                                <c:url var="slide_details" value="slide/${slide.slideName}">
                                    <c:param name="id" value="${slide.slideId}"/>
                                </c:url>
                                <div class="card-body">
                                    <h4 class="card-title">
                                        <a href="${root}trang-trinh-chieu/${slide.slideId}/${slide.convertURL()}">${slide.slideName}</a>
                                    </h4>
                                </div>
                                <div class="card-footer text-muted">
                                    <a href="${root}trang-trinh-chieu/${slide.slideId}/${slide.convertURL()}" class="btn btn-primary gradient">Chi tiết</a>

                                    <c:set var="fileParts" value="${fn:split(slide.filePath,'/')}"/>
                                    <c:set var="fileName" value="${fileParts[fn:length(fileParts) - 1]}"/>

                                    <a href="download/${slide.slideId}/${fileName}" class="btn float-right">
                                        <i class="fas fa-download" style="font-size: 22px; color: #F74F67;"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <%-- PAGING --%>
        <c:if test="${slides.size() != 0}">
            <nav class="row">
                <ul class="col-12 pagination pagination-md" id="paging">
                </ul>
            </nav>

            <form action="trang-trinh-chieu" method="GET" id="change-page">
                <input type="hidden" name="searchValue" value="${param.searchValue}"/>
                <input id="page-value" type="hidden" value="1" name="page"/>
            </form>  
        </c:if>
        <jsp:include page="footer.jsp"/> 


        <script>
            // pagingation
            var numsOfPage = "${numsOfPage}";
            var currentPage = "${page}";
            pagination(numsOfPage, currentPage);

        </script>
    </body>
</html>

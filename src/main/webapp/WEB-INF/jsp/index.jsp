<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <title>PPShare chia sẻ mẫu slide PowerPoint miễn phí</title>
    <!-- Required meta tags -->
    <jsp:include page="/WEB-INF/jsp/header/header_meta.jsp" flush="true"/>
    <meta name="description" content="Tổng hợp hàng ngàn mẫu trang trình chiếu - slide PowperPoint đẹp, độc đáo, chuyên ngiệp luôn được cập nhật thường xuyên. Gồm nhiều thể loại mẫu trình chiếu kinh doanh, công nghệ, giáo dục và được chia sẻ hoàn toàn miễn phí." />
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <jsp:include page="/WEB-INF/jsp/header/header_source.jsp"/>
</head>

<body>
    <c:url var="root" value="/" scope="request"/>
    <jsp:include page="/WEB-INF/jsp/header/header_body.jsp"/>
    <h2 class="title"><a href="trang-trinh-chieu?order=1">MỚI NHẤT</a></h2>
    <div class="container-fluid">
        <div class="row">
            <c:forEach var="newSlide" items="${applicationScope.newSlides}">
                <div class="col-sm-6 col-md-6 col-lg-3">
                    <div class="card h-100 shadow1">
                        <img class="card-img-top" src="${newSlide.avatarPath}" alt="${newSlide.convertURL()}" style="width:100%;">
                        <div class="card-body">
                            <h4 class="card-title">
                                <a class="middle-underline" href="${root}trang-trinh-chieu/${newSlide.slideId}/${newSlide.convertURL()}">${newSlide.slideName}</a>
                            </h4>
                        </div>
                        <div class="card-footer text-muted">

                            <a href="${root}trang-trinh-chieu/${newSlide.slideId}/${newSlide.convertURL()}/" class="btn btn-primary gradient">Chi Tiết</a>

                            <c:set var="fileParts" value="${fn:split(newSlide.filePath,'/')}"/>
                            <c:set var="fileName" value="${fileParts[fn:length(fileParts) - 1]}"/>

                            <a href="download/${newSlide.slideId}/${fileName}" class="btn float-right">
                                <i class="fas fa-download" style="font-size: 22px; color: #F74F67;"></i>
                            </a>
                        </div>
                    </div>
                </div>

            </c:forEach>
        </div>
    </div>
    <h2 class="title"><a href="trang-trinh-chieu?order=3">Phổ Biến</a></h2>
    <div class="container-fluid">
        <div class="row">
            <c:forEach var="hotSlide" items="${applicationScope.hotSlides}">
                <div class="col-sm-6 col-md-6 col-lg-3">
                    <div class="card shadow1 h-100">
                        <img class="card-img-top" src="${hotSlide.avatarPath}" alt="${hotSlide.convertURL()}" style="width:100%;">
                        <div class="card-body">
                            <h4 class="card-title">
                                <a class="middle-underline" href="${root}trang-trinh-chieu/${hotSlide.slideId}/${hotSlide.convertURL()}">${hotSlide.slideName}</a>
                            </h4>
                        </div>
                        <div class="card-footer text-muted">
                            <a href="${root}trang-trinh-chieu/${hotSlide.slideId}/${hotSlide.convertURL()}" class="btn btn-primary gradient">Chi Tiết</a>

                            <c:set var="fileParts" value="${fn:split(hotSlide.filePath,'/')}"/>
                            <c:set var="fileName" value="${fileParts[fn:length(fileParts) - 1]}"/>

                            <a href="download/${hotSlide.slideId}/${fileName}" class="btn float-right">
                                <i class="fas fa-download" style="font-size: 22px; color: #F74F67;"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="container-fluid">
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

    <div class="mt-4"></div>
    <jsp:include page="footer.jsp"/>

</body>

</html>

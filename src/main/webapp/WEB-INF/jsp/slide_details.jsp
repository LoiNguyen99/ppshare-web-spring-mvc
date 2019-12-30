<%-- 
    Document   : slide_details
    Created on : Oct 5, 2019, 4:05:29 PM
    Author     : Loi Nguyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>${slide.slideName} - Mẫu slide PowerPoint miễn phí</title>
        <jsp:include page="/WEB-INF/jsp/header/header_meta.jsp" flush="true"/>
        <meta name="description" content="Tải xuống miễn phí mẫu trang trình chiếu - slide PowerPoint ${slide.slideName} với phong cách chuyên nhiệp dành cho ${slide.category.categoryName}." />
        <jsp:include page="/WEB-INF/jsp/header/header_source.jsp"/>
        <meta property ="og:image" content="ppshare.site${slide.avatarPath}"/>
    </head>
    <body>
        <c:url var="root" value="/" scope="request"/>
        <jsp:include page="/WEB-INF/jsp/header/header_body.jsp"/>
        <div class="container mt-4">
            <nav class="px-sm-4">
                <ol class="breadcrumb mb-1 bg-white">
                    <li class="breadcrumb-item"><a href="${root}">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${root}trang-trinh-chieu">Trang trình chiếu</a></li>
                    <li class="breadcrumb-item"><a href="${root}trang-trinh-chieu/${slide.category.convertURL()}?cat=${slide.category.categoryId}&order=1">${slide.category.categoryName}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${slide.slideName}</li>
                </ol>
            </nav>
            <div class="row mt-3">

                <!-- IMAGES -->

                <div class="col-xl-8 col-lg-8 col-md-7 detail-padding">
                    <div class="card menu-data">
                        <h4 style="font-weight: bold;">${slide.slideName}</h4>
                        <div class="menu-data-scroll mt-3">
                            <img class="avatar" src="${slide.avatarPath}" alt="${slide.convertURL()}-avatar"/>
                            <div class="row p-0 mb-0">
                                <c:forEach items="${slide.listImages}"  var="img" varStatus="counter">
                                    <c:if test="${counter.count % 2 != 0}">
                                        <div class="col-6 pl-0 pr-1 pt-2 pb-0">
                                            <img class="avatar" src="${img.imagePath}" alt="${slide.convertURL()}-description-${counter.count}"/>
                                        </div>
                                    </c:if>
                                    <c:if test="${counter.count % 2 == 0}">
                                        <div class="col-6 pr-0 pl-1 pt-2 pb-0">
                                            <img class="avatar" src="${img.imagePath}" alt="${slide.convertURL()}-description-${counter.count}"/>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- RELATIVE SLIDE -->
                    <h4 class="title text-left">Liên quan</h2>
                        <div class="card-columns relative">
                            <c:forEach items="${relative_slides}" var="rslide" varStatus="counter">
                                <a href="${root}trang-trinh-chieu/${rslide.slideId}/${rslide.convertURL()}" class="card bg-light" style="border: none;">
                                    <div class="overlay-img">
                                        <img class="card-img" src="${rslide.avatarPath}" />
                                        <div class="overlay-title">
                                            ${rslide.slideName}
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-5 detail-padding">
                    <div class="card menu-data">
                        <c:set var="fileParts" value="${fn:split(slide.filePath,'/')}"/>
                        <c:set var="fileName" value="${fileParts[fn:length(fileParts) - 1]}"/>

                        <a href="${root}download/${slide.slideId}/${fileName}">
                            <button class="btn btn-danger gradient w-100">Tải xuống</button>
                        </a>

                        <h5 class="mt-3">Thông tin</h5>
                        <table class="table table-borderless detail">
                            <tbody>
                                <tr>
                                    <td>
                                        <b>Kích thước</b>
                                    </td>
                                    <td>
                                        <fmt:formatNumber type="number" pattern="###.##" value="${slide.size/1024/1024}"/> MB

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Danh mục</b>
                                    </td>
                                    <td>
                                        ${slide.category.categoryName}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Lượt tải</b>
                                    </td>
                                    <td>
                                        ${slide.download}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="card menu-data mt-3">
                        <h5 class="mb-3">Chia sẻ</h5>
                        <div class="inline"> 
                            <a class="btn bg-facebook" id="fb-share" href="" target="_blank">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <button class="btn bg-twitter">
                                <i class="fab fa-twitter"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card menu-data mt-3">
                        <h5 class="mb-3">Ads</h5>
                        <div class="inline">
                            <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                            <!-- Vertical ads -->
                            <ins class="adsbygoogle"
                                 style="display:block"
                                 data-ad-client="ca-pub-8947345672774709"
                                 data-ad-slot="2299686478"
                                 data-ad-format="auto"
                                 data-full-width-responsive="true"></ins>
                            <script>
                                (adsbygoogle = window.adsbygoogle || []).push({});
                            </script>
                        </div>
                    </div>
                </div>

            </div>
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
            setShareURL();
            function setShareURL() {
                var x = location.href;
                $('#fb-share').attr('href', 'http://www.facebook.com/sharer/sharer.php?u=' + x);
            }
        </script>

    </body>

</html>
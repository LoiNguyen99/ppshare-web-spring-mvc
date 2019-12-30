<%-- 
    Document   : manage_slide
    Created on : Sep 9, 2019, 9:58:15 PM
    Author     : Loi Nguyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <jsp:include page="/WEB-INF/jsp/header/header_source.jsp"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}\resources\js\pagination.js"></script>
    </head>
    <body>
        <c:url var="root" value="/" scope="request"/>
        <jsp:include page="header/header_body.jsp"/>
        <h2 class="title">Management page</h2>
        <div class="container-fluid">
            <div class="row">
                <!-- MENU -->
                <div class="col-xl-3 col-lg-4 col-md-5">
                    <div class="card manager-menu">
                        <h4 style="font-weight: bold;">MENU</h3>
                            <ul>
                                <a href="#">
                                    <li>
                                        <i class="far fa-address-card"></i> ${sessionScope.admin.firstName} ${sessionScope.admin.lastName}(${sessionScope.admin.userId})
                                    </li>
                                </a>
                                <a href="slide">
                                    <li class="active"> 
                                        <i class="far fa-image"></i> Slide
                                    </li>
                                </a>
                                <a href="category">
                                    <li>
                                        <i class="far fa-list-alt"></i> Category
                                    </li>
                                </a>
                                <a href="logout">
                                    <li>
                                        <i class="fas fa-sign-out-alt"></i> Log out
                                    </li>
                                </a>
                            </ul>
                    </div>
                </div>

                <c:url var="listUrl" value="slide">
                    <c:param name="action" value="list"/>
                </c:url>
                <c:url var="addUrl" value="slide">
                    <c:param name="action" value="add"/>
                </c:url>

                <!-- FUNCTION -->
                <c:choose>
                    <c:when test="${action == 'list'}">
                        <div class="col-xl-9 col-xl-8 col-md-7">
                            <div class="btn-group">
                                <a href="${listUrl}">
                                    <button type="button" class="btn-circle active">
                                        <i class="fas fa-list"></i>
                                    </button>
                                </a>
                                <a href="${addUrl}">
                                    <button type="button" class="btn-circle">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </a>
                                <button type="button" class="btn-circle">
                                    <i class="far fa-edit"></i>
                                </button>
                            </div>
                            <h2 class="mt-4 mb-3">Slide List</h2>
                            <form action="slide" id="form-status">
                                <div class="form-group">
                                    <label for="pwd">Select status:</label>
                                    <select class="form-control w-25" name="formStatus" id="select-form-status">
                                        <option value="true" label="True" ${formStatus == true ? 'selected': '' }/>
                                        <option value="false" label="False" ${formStatus == false ? 'selected': '' }/>
                                    </select>
                                    <div class="invalid-message"></div>
                                </div>
                            </form>
                            <div class="table-responsive">
                                <table class="table table-hover bg-white">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Name</th>
                                            <th>Size</th>
                                            <th>Category</th>
                                            <th>Date</th>
                                            <th>Downloads</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="slide" items="${slides}" varStatus="status"> 
                                            <tr data-toggle="modal" data-target="#infoModal" onclick="getDetails(${status.index}, ${slide.slideId})">
                                                <td>
                                                    <img src="${slide.avatarPath}" width="75px;" />
                                                </td>
                                                <td>${slide.slideName}</td>
                                                <td>
                                                    <fmt:formatNumber value="${slide.size/1024/1024}" maxFractionDigits="1"/> MB
                                                </td>
                                                <td>${slide.category.categoryName}</td>
                                                <td>
                                                    <fmt:formatDate value="${slide.dateCreate}" pattern="dd/MM/yy"/>
                                                </td>
                                                <td>${slide.download}</td>
                                                <td class="removeToggle">
                                                    <form action="slide/delete">
                                                        <input type="hidden" name="slideId" value="${slide.slideId}"/>
                                                        <button class="btn btn-danger btn-sm mr-1 mb-1" style=" width: 35px;">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </button>
                                                    </form>
                                                    <form action="slide">
                                                        <input type="hidden" name="action" value="edit"/>
                                                        <input type="hidden" name="slideId" value="${slide.slideId}"/>
                                                        <button class="btn btn-info btn-sm mb-1" style="width: 35px; ">
                                                            <i class="fas fa-edit "></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- TABLE PAGING -->
                            <nav class="table-responsive">
                                <ul class="pagination pagination-md" id="paging">
                                </ul>
                            </nav>

                            <!-- CHANGE PAGE -->
                            <form action="slide" method="GET" id="change-page">
                                <input id="page-value" type="hidden" value="1" name="page"/>
                            </form>

                        </div>

                        <!-- DIALOG -->

                        <div id="infoModal" class="modal fade" role="dialog">
                            <div class="modal-dialog modal-dialog-centered modal-xl">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">SLIDE DETAILS</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                                    </div>
                                    <div class="model-body">
                                        <div class="row">
                                            <div class="col-xl-7 mt-3" id="images" style="padding: 0px;">

                                                <!-- content here -->

                                            </div>
                                            <div class="col-xl-5">
                                                <table class="table table-borderless detail">
                                                    <tbody>
                                                        <tr>
                                                            <td  colspan="2" id="slideName">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>Code</b>
                                                            </td>
                                                            <td id="slideId">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>Size</b>
                                                            </td>
                                                            <td id="size">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>Category</b>
                                                            </td>
                                                            <td id="category">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>Date create</b>
                                                            </td>
                                                            <td id="date">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>Downloads</b>
                                                            </td>
                                                            <td id="download">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${action == 'add'}">
                        <div class="col-xl-6 col-lg-7 col-md-7">
                            <!-- BUTTON -->
                            <div class="btn-group">
                                <a href="${listUrl}">
                                    <button type="button" class="btn-circle">
                                        <i class="fas fa-list"></i>
                                    </button>
                                </a>
                                <a href="${addUrl}">
                                    <button type="button" class="btn-circle active">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </a>
                                <button type="button" class="btn-circle">
                                    <i class="far fa-edit"></i>
                                </button>
                            </div>

                            <!-- ACTION -->

                            <!-- **********FORM************ -->
                            <form:form action="slide/insert" class="mt-4" modelAttribute="slide" enctype="multipart/form-data" acceptCharset="UTF-8" id="add-form">
                                <div class="form-group">
                                    <label for="sname">Slide name:</label>
                                    <form:input class="form-control" placeholder="Enter Slide's name" path="slideName"/>
                                    <div class="invalid-message" id="error-slide-name"></div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Select category:</label>
                                    <form:select class="form-control" path="category.categoryId" items="${categories}" itemValue="categoryId" itemLabel="categoryName"/>
                                </div>
                                <p class="file-label">Select avatar:</p>
                                <div class="custom-file mb-2">
                                    <input type="file" class="custom-file-input" id="customAvatar" name="avatarFile" accept=".jpg,.png">
                                    <label class="custom-file-label" for="customAvatar">Choose file</label>
                                    <div class="invalid-message" id="invalid-avatar-path"></div>
                                </div>
                                <div class="file-list mb-2">
                                    <!--child append here-->
                                </div> 
                                <p class="file-label">Select images:</p>
                                <div class="custom-file mb-2">
                                    <input type="file" class="custom-file-input" id="customDesctiptionImgFile" name="descriptionImgFile" multiple="multiple" accept=".jpg,.png">
                                    <label class="custom-file-label" for="customDesctiptionImgFile">Choose file</label>
                                    <div class="invalid-message" id="invalid-imgs-path"></div>
                                </div>
                                <div class="file-list mb-2">
                                    <!--child append here-->
                                </div>
                                <p class="file-label">Slide file(.pptx):</p>
                                <div class="custom-file mb-4">
                                    <input type="file" class="custom-file-input" id="customSlideFile" name="slideFile" accept=".pptx">
                                    <label class="custom-file-label" for="customSlideFile">Choose file</label>
                                    <div class="invalid-message" id="invalid-slide-path"></div>
                                </div>                  
                                <button class="btn btn-primary" id="submit-add">Submit</button>
                            </form:form>
                        </div>
                    </c:when>
                    <c:when test="${action == 'edit'}">
                        <div class="col-xl-6 col-lg-7 col-md-7">
                            <!-- BUTTON -->
                            <div class="btn-group">
                                <a href="${listUrl}">
                                    <button type="button" class="btn-circle">
                                        <i class="fas fa-list"></i>
                                    </button>
                                </a>
                                <a href="${addUrl}">
                                    <button type="button" class="btn-circle">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </a>
                                <button type="button" class="btn-circle active">
                                    <i class="far fa-edit"></i>
                                </button>
                            </div>

                            <!-- ACTION -->

                            <!-- **********FORM************ -->
                            <form:form action="slide/edit" class="mt-4" modelAttribute="slide" enctype="multipart/form-data" acceptCharset="UTF-8" id="add-form">
                                <form:hidden path="slideId"/>
                                <form:hidden path="avatarPath"/>
                                <form:hidden path="filePath"/>
                                <form:hidden path="size"/>
                                <div class="form-group">
                                    <label for="sname">Slide name:</label>
                                    <form:input class="form-control" placeholder="Enter Slide's name" path="slideName"/>
                                    <div class="invalid-message" id="error-slide-name"></div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Select category:</label>
                                    <form:select class="form-control" path="category.categoryId" items="${categories}" itemValue="categoryId" itemLabel="categoryName"/>
                                    <div class="invalid-message"></div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Select status:</label>
                                    <form:select class="form-control" path="status">
                                        <form:option value="true" label="True"/>
                                        <form:option value="false" label="False"/>
                                    </form:select>
                                    <div class="invalid-message"></div>
                                </div>
                                <p class="file-label">Select new avatar:</p>
                                <div class="card w-50">
                                    <img class="card-img-top" src="${slide.avatarPath}" alt="${hotSlide.slideName}" style="width:100%;">
                                </div>

                                <div class="custom-file mb-2 mt-2">
                                    <input type="file" class="custom-file-input" id="customAvatar" name="avatarFile" accept=".jpg,.png">
                                    <label class="custom-file-label" for="customAvatar">Choose new avatar</label>
                                    <div class="invalid-message" id="invalid-avatar-path"></div>
                                </div>
                                <div class="file-list mb-2">
                                    <!--child append here-->
                                </div> 
                                <div class="form-group">
                                    <label for="img">Description images:</label>
                                    <div class="card-columns select-image" id="des-img">
                                        <c:forEach items="${slide.listImages}" var="image" varStatus="counter">
                                            <div class="card">
                                                <label class="checkbox-container check-image">
                                                    <img class="card-img" src="${image.imagePath}" />
                                                    <input type="checkbox" name="imageId" value="${image.imageId}" class="hide check-box-image"/>
                                                    <div class="custom-checkbox"></div>
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button class="btn btn-success btn-sm" id="btn-check-all">Select All</button>
                                    <button class="btn btn-info btn-sm hide" id="btn-undo-all">Undo</button>
                                    <button class="btn btn-danger btn-sm" id="btn-delete-image"><i class="fas fa-trash-alt"></i></button>
                                </div>

                                <p class="file-label">Add more images:</p>
                                <div class="custom-file mb-2">
                                    <input type="file" class="custom-file-input" id="customDesctiptionImgFile" name="descriptionImgFile" multiple="multiple" accept=".jpg,.png">
                                    <label class="custom-file-label" for="customDesctiptionImgFile">Add new files</label>
                                    <div class="invalid-message" id="invalid-imgs-path"></div>
                                </div>
                                <div class="file-list mb-2">
                                    <!--child append here-->
                                </div>
                                <p class="file-label">Slide file(.pptx): <font color="#000000">${slide.filePath}</font></p>
                                <div class="custom-file mb-4">
                                    <input type="file" class="custom-file-input" id="customSlideFile" name="slideFile" accept=".pptx">
                                    <label class="custom-file-label" for="customSlideFile">Choose new file</label>
                                    <div class="invalid-message" id="invalid-slide-path"></div>
                                </div>                  
                                <button class="btn btn-primary" id="submit-edit">Save Change</button>
                            </form:form>
                        </div>
                    </c:when>

                </c:choose> 
            </div>
        </div>



        <!-- MESSAGE -->
        <div class="modal fade" id="messageModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h5 class="modal-title">Message</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body" id="message">
                        Modal body..
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <button id="display-message" type="button" style="display: none;" data-toggle="modal" data-target="#messageModal">
            Open modal
        </button>

        <jsp:include page="footer.jsp"/>

        <!-- SCRIPT -->
        <script>

            // pagingation
            var numsOfPage = "${numsOfPage}";
            var currentPage = "${page}";
            var action = "${param.action}"
            pagination(numsOfPage, currentPage);

            function getDetails(index, id) {
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: "${root}manage/slide/detail",
                    data: {
                        id: id
                    },
                    timeout: 10000,
                    success: function (response) {
                        var slide = JSON.parse(response);
                        $("#slideId").html("<h5><span class='badge badge-info'>" + slide.slideId + "</span></h5>");
                        $("#slideName").html("<h4><b>" + slide.slideName + "</b></h4>");
                        var date = new Date(parseInt(slide.dateCreate));
                        var dateString = date.getDate() + "/" + date.getMonth() + "/" + date.getFullYear();
                        $("#date").html(dateString);
                        $("#category").html("<h5><span class='badge badge-primary'>" + slide.category.categoryName + "</span></h5>");
                        var size = slide.size / 1024 / 1024;
                        $("#size").html(size.toFixed(1) + " MB");
                        $("#download").html(slide.download);

                        // DISPLAY IMAGES
                        var subimg = "";
                        for (var i = 0; i < slide.listImages.length; i++) {
                            subimg = subimg +
                                    "<div class='col-6 pr-0 pl-1 pt-2 pb-0'>" +
                                    "<img class='avatar' src='" + slide.listImages[i].imagePath + "'/>" +
                                    "</div>"
                        }
                        ;

                        $("#images").html(
                                "<img class='avatar' src='" + slide.avatarPath + "'/>" +
                                "<div class='row p-0 mb-0'>" + subimg + "</div>"
                                );


                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.status + " " + textStatus);
                        alert(errorThrown);
                    }
                });
            }


            $('.removeToggle').on('click', function (e) {
                //Remove display toggle of parent class
                e.stopPropagation();
            });

            $('#select-form-status').change(function () {
                $('#form-status').submit();
            });
            document.getElementById("customSlideFile").onchange = function () {
                var files = this.files;
                var label = document.getElementsByClassName("custom-file-label")[2];
                label.innerHTML = files[0].name;
            }
            document.getElementById("customDesctiptionImgFile").onchange = function () {
                var fileList = document.getElementsByClassName("file-list")[1];
                fileList.classList.add("mb-3");
                while (fileList.firstChild) {
                    fileList.removeChild(fileList.firstChild);
                }
                var files = this.files;
                var label = document.getElementsByClassName("custom-file-label")[1];
                label.innerHTML = files.length + " files selected"
                for (var i = 0; i < files.length; i++) {
                    var div = document.createElement('div');
                    div.className = "file-list-item";
                    var img = '<img src="' + URL.createObjectURL(this.files[i]) + '"/>';
                    var name = files.item(i).name;
                    if (name.length > 20) {
                        name = name.substring(0, 20) + "..." + name.substring(name.length - 8, name.length);
                    }
                    var size = parseInt(files.item(i).size / 1024);
                    div.innerHTML = img + name + ' - Size: ' + size + " KB";
                    fileList.appendChild(div);
                }
            }
            document.getElementById("customAvatar").onchange = function () {
                var fileList = document.getElementsByClassName("file-list")[0];
                fileList.classList.add("mb-3");
                while (fileList.firstChild) {
                    fileList.removeChild(fileList.firstChild);
                }
                var files = this.files;
                var label = document.getElementsByClassName("custom-file-label")[0];
                label.innerHTML = files.length + " files selected"
                for (var i = 0; i < files.length; i++) {
                    var div = document.createElement('div');
                    div.className = "file-list-item";
                    var img = '<img src="' + URL.createObjectURL(this.files[i]) + '"/>';
                    var name = files.item(i).name;
                    if (name.length > 20) {
                        name = name.substring(0, 20) + "..." + name.substring(name.length - 8, name.length);
                    }
                    var size = parseInt(files.item(i).size / 1024);
                    div.innerHTML = img + name + ' - Size: ' + size + " KB";
                    fileList.appendChild(div);
                }
            }

            $("#submit-add").click(function (e) {
                var isValid = [];
                var slidename = $("#slideName").val();
                if (slidename.length == 0)
                {
                    $("#error-slide-name").text("Please enter slide name");
                    $("#error-slide-name").css("display", "inline-block");
                    isValid[0] = false;
                } else {
                    $("#error-slide-name").text("");
                    isValid[0] = true;
                }
                var avatarpath = $("#customAvatar").val();
                if (avatarpath == "") {
                    $("#invalid-avatar-path").text("Please choose avatar file");
                    $("#invalid-avatar-path").css("display", "inline-block");
                    isValid[1] = false;
                } else {
                    $("#invalid-avatar-path").text("");
                    isValid[1] = true;
                }
                var imagesPath = $("#customDesctiptionImgFile").val();
                if (imagesPath[0] == null) {
                    $("#invalid-imgs-path").text("Please choose description images");
                    $("#invalid-imgs-path").css("display", "inline-block");
                    isValid[2] = false;
                } else {
                    $("#invalid-imgs-path").text("");
                    isValid[2] = true;
                }
                var slidePath = $("#customSlideFile").val();
                if (slidePath == "") {
                    $("#invalid-slide-path").text("Please choose slide file");
                    $("#invalid-slide-path").css("display", "inline-block");
                    $("#submit-add").addClass("mt-4");
                    isValid[3] = false;
                } else {
                    $("#invalid-slide-path").text("");
                    isValid[3] = true;
                }

                for (var i = 0; i < isValid.length; i++) {
                    if (isValid[i] == false) {
                        e.preventDefault();
                    }
                }
            });

            $("#submit-edit").click(function (e) {
                var isValid = [];
                var slidename = $("#slideName").val();
                if (slidename.length === 0)
                {
                    $("#error-slide-name").text("Please enter slide name");
                    $("#error-slide-name").css("display", "inline-block");
                    isValid[0] = false;
                } else {
                    $("#error-slide-name").text("");
                    isValid[0] = true;
                }
                for (var i = 0; i < isValid.length; i++) {
                    if (isValid[i] === false) {
                        e.preventDefault();
                    }
                }
            });

            var message = "${message}";

            if (message.length > 0) {
                $("#display-message").click();
                $("#message").text(message);
            }

            $('#btn-delete-image').click(function (e) {
                e.preventDefault();
                var selected = [];
                $('.check-image input:checked').each(function () {
                    selected.push($(this).val());

                });
                deleteImage(selected);
            });

            function deleteImage(selected) {
                var slideId = "${slide.slideId}";

                if (selected.length > 0 && slideId.length > 0)
                {
                    $.ajax({
                        type: 'GET',
                        contentType: "application/json",
                        url: "${root}manage/image/delete",
                        data: {
                            imagesIdList: selected,
                            slideId: slideId
                        },
                        timeout: 10000,
                        success: function (response) {
                            var images = JSON.parse(response);
                            var desImg = $('#des-img');
                            var imgCard = "";
                            for (var i = 0; i < images.length; i++) {
                                imgCard = imgCard +
                                        "<div class='card'>" +
                                        "<label class='checkbox-container check-image'>" +
                                        "<img class='card-img' src='" + images[i].imagePath + "' />" +
                                        "<input type='checkbox' value='" + images[i].imageId + "' class='hide check-box-image'/>" +
                                        "<div class='custom-checkbox'></div>" +
                                        "</label>" +
                                        "</div>";

                            }
                            desImg.html(imgCard);
                            $('#btn-undo-all').css('display', 'none');
                            $('.check-image').click(function (e) {
                                $('#btn-undo-all').css('display', 'inline-block');
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error:  " + jqXHR.status + " " + textStatus);
                            alert(errorThrown);
                        }});
                }
            }

            $('#btn-check-all').click(function (e) {
                e.preventDefault()
                $('.check-box-image').prop('checked', true);
                $('#btn-undo-all').css('display', 'inline-block');
            });
            $('#btn-undo-all').click(function (e) {
                e.preventDefault()
                $('.check-box-image').prop('checked', false);
                $('#btn-undo-all').css('display', 'none');
            });
            $('.check-image').click(function (e) {
                $('#btn-undo-all').css('display', 'inline-block');
            });
        </script>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    </body>
</html>

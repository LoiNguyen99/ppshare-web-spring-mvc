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
                                    <li>
                                        <i class="far fa-image"></i> Slide
                                    </li>
                                </a>
                                <a href="category">
                                    <li class="active">
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

                <c:url var="listUrl" value="category">
                    <c:param name="action" value="list"/>
                </c:url>
                <c:url var="addUrl" value="category">
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

                            <h2 class="mt-4 mb-3">Category List</h2>
                            <form action="category" id="form-status">
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
                                            <th style="width: 15%;">ID</th>
                                            <th style="width: 70%;">Name</th>
                                            <th style="width: 15%;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="category" items="${categories}" varStatus="counter"> 
                                            <tr>
                                                <td>${category.categoryId}</td>
                                                <td>${category.categoryName}</td>
                                                <td>
                                                    <div class="inline">
                                                        <form style="float: left;" action="category/delete">
                                                            <input type="hidden" name="categoryId" value="${category.categoryId}"/>
                                                            <button class="btn btn-danger btn-sm mr-1 mb-1" style=" width: 35px;">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </button>
                                                        </form>
                                                        <form style="float: left;" action="category">
                                                            <input type="hidden" name="action" value="edit"/>
                                                            <input type="hidden" name="categoryId" value="${category.categoryId}"/>
                                                            <input type="hidden" name="categoryName" value="${category.categoryName}"/>
                                                            <input type="hidden" name="status" value="${category.status}"/>
                                                            <button class="btn btn-info btn-sm mb-1" style="width: 35px; ">
                                                                <i class="fas fa-edit "></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- TABLE PAGING -->
                            <!--                            <nav class="table-responsive">
                                                            <ul class="pagination pagination-md" id="paging">
                                                            </ul>
                                                        </nav>-->

                            <!-- CHANGE PAGE -->
                            <form action="category" method="GET" id="change-page">
                                <input id="page-value" type="hidden" value="1" name="page"/>
                            </form>
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
                            <form:form action="category/insert" class="mt-4" modelAttribute="category" enctype="multipart/form-data" acceptCharset="UTF-8" id="add-form">
                                <div class="form-group">
                                    <label for="sname">Category name:</label>
                                    <form:input class="form-control" placeholder="Category name" path="categoryName"/>
                                    <div class="invalid-message" id="error-slide-name"></div>
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
                            <form:form action="category/edit" class="mt-4" modelAttribute="category" enctype="multipart/form-data" acceptCharset="UTF-8" id="edit-form">
                                <div class="form-group">
                                    <label for="sname">Category name:</label>
                                    <form:input class="form-control" path="categoryName"/>
                                    <div class="invalid-message" id="error-category-name"></div>
                                </div>             
                                <div class="form-group">
                                    <label for="pwd">Select status:</label>
                                    <form:select class="form-control" path="status">
                                        <form:option value="true" label="True"/>
                                        <form:option value="false" label="False"/>
                                    </form:select>
                                    <div class="invalid-message"></div>
                                </div>
                                <form:hidden  path="categoryId"/>
                                <button class="btn btn-primary" id="submit-add">Submit</button>
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


            $("#submit-add").click(function (e) {
                var isValid = [];
                var categoryname = $("#categoryName").val();
                if (categoryname.length < 5)
                {
                    $("#error-category-name").text("Please enter category name > 4 characters");
                    $("#error-category-name").css("display", "none");
                    isValid[0] = false;
                } else {
                    $("#error-category-name").text("");
                    isValid[0] = true;
                }
                for (var i = 0; i < isValid.length; i++) {
                    if (isValid[i] == false) {
                        e.preventDefault();
                    }
                }
            })
            var message = "${message}";
            if (message.length > 0) {
                $("#display-message").click();
                $("#message").text(message);
            }

            $('#select-form-status').change(function () {
                $('#form-status').submit();
            });

        </script>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

    </body>
</html>

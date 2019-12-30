/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function pagination(numsOfPage, currentPage) {
    var pagingClass = document.getElementById("paging");
    if (pagingClass != null) {
        var page = "<nav aria-label='Page navigation'><ul class='pagination' id='paging'>";
        if (parseInt(currentPage) === 1)
        {
            page = page + "<li class='page-item disabled'><a class='page-link'>Previous</a></li>";
        } else {
            page = page + "<li class='page-item'><a class='page-link'>Previous</a></li>";
        }
        if (numsOfPage < 7) {
            for (var i = 0; i < Number(numsOfPage); i++) {
                if (i == parseInt(currentPage) - 1)
                {
                    page = page + "<li class='page-item active'><a class='page-link'>" + (i + 1) + "</a></li>";
                } else {
                    page = page + "<li class='page-item'><a class='page-link'>" + (i + 1) + "</a></li>";
                }
            }
        } else {
            if (currentPage < 5) {


                for (var i = 0; i < 5; i++) {
                    if (i == parseInt(currentPage) - 1)
                    {
                        page = page + "<li class='page-item active'><a class='page-link'>" + (i + 1) + "</a></li>";
                    } else {
                        page = page + "<li class='page-item'><a class='page-link'>" + (i + 1) + "</a></li>";
                    }
                }
                page = page + "<li class='page-item disabled'><a class='page-link'>" + "..." + "</a></li>";
                page = page + "<li class='page-item'><a class='page-link'>" + parseInt(numsOfPage) + "</a></li>";
            } else if (currentPage > parseInt(numsOfPage) - 4)
            {
                page = page + "<li class='page-item'><a class='page-link'>" + "1" + "</a></li>";
                page = page + "<li class='page-item'><a class='page-link'>" + "..." + "</a></li>";
                for (var i = parseInt(numsOfPage) - 5; i < numsOfPage; i++) {
                    if (i == parseInt(currentPage) - 1)
                    {
                        page = page + "<li class='page-item active'><a class='page-link'>" + (i + 1) + "</a></li>";
                    } else {
                        page = page + "<li class='page-item'><a class='page-link'>" + (i + 1) + "</a></li>";
                    }
                }
            } else {
                page = page + "<li class='page-item'><a class='page-link'>" + "1" + "</a></li>";
                page = page + "<li class='page-item disabled'><a class='page-link'>" + "..." + "</a></li>";

                for (var i = parseInt(currentPage) - 1; i <= parseInt(currentPage) + 1; i++) {
                    if (i == parseInt(currentPage))
                    {
                        page = page + "<li class='page-item active'><a class='page-link'>" + i + "</a></li>";
                    } else {
                        page = page + "<li class='page-item'><a class='page-link'>" + i + "</a></li>";
                    }
                }

                page = page + "<li class='page-item disabled'><a class='page-link'>" + "..." + "</a></li>";
                page = page + "<li class='page-item'><a class='page-link'>" + parseInt(numsOfPage) + "</a></li>";
            }
        }
        if (parseInt(currentPage) == parseInt(numsOfPage))
        {
            page = page + "<li class='page-item disabled'><a class='page-link'>Next</a></li>" + "</ul>" + "</nav>";
        } else
        {
            page = page + "<li class='page-item'><a class='page-link'>Next</a></li>" + "</ul>" + "</nav>";
        }

        pagingClass.innerHTML = page;

        $(".page-link").click(function () {
            var page = $(this).text();
            if (page === "Next") {
                if (parseInt(currentPage) < parseInt(numsOfPage))
                {
                    page = parseInt(currentPage) + 1;
                } else {
                    page = numsOfPage;
                }
            }
            if (page === "Previous") {
                if (currentPage > 1) {
                    page = parseInt(currentPage) - 1;
                } else {
                    page = 1;
                }
            }
            $("#page-value").val(page);
            $("#change-page").submit();
        });
    }
}


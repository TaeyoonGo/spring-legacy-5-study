<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Register</h1>
<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
    For more information about DataTables, please visit the <a target="_blank"
                                                               href="https://datatables.net">official DataTables
        documentation</a>.</p>

<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Board Register</h6>
    </div>
    <div class="card-body">
        <form action="/board/register" method="post">
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">title</span>
                </div>
                <input type="text" name="title" class="form-control">
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">content</span>
                </div>
                <input type="text" name="content" class="form-control">
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">writer</span>
                </div>
                <input type="text" name="writer" class="form-control">
            </div>
            <div>
                <button type="submit" class="btn btn-dark">버튼</button>
            </div>
        </form>
    </div>
</div>
<script>

</script>
<%@ include file="../includes/footer.jsp" %>
<%@ include file="../includes/end.jsp" %>
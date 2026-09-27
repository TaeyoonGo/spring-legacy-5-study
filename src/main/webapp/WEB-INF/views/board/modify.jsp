<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">modify</h1>
<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
    For more information about DataTables, please visit the <a target="_blank"
                                                               href="https://datatables.net">official DataTables
        documentation</a>.</p>

<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Board modify</h6>
    </div>
    <div class="card-body">
        <form id="actionForm" action="/board/modify" method="post">
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">Bno</span>
                </div>
                <input type="text" name="bno" class="form-control" value="<c:out value="${vo.bno}"/>" readonly>
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">title</span>
                </div>
                <input type="text" name="title" class="form-control" value="<c:out value="${vo.title}"/>">
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">content</span>
                </div>
                <input type="text" name="content" class="form-control" value="<c:out value="${vo.content}"/>">

            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">writer</span>
                </div>
                <input type="text" class="form-control" value="<c:out value="${vo.writer}"/>" readonly>
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">regDate</span>
                </div>
                <input type="text" class="form-control" value="<c:out value="${vo.regDate}"/>" readonly>
            </div>
            <div>
                <button type="button" class="btn btn-primary btnList">List</button>
                <button type="button" class="btn btn-info btnModify">Modify</button>
                <button type="button" class="btn btn-danger btnRemove">Remove</button>
            </div>
        </form>
    </div>
</div>
<form id="listForm" action="/board/list" method="get">
    <input type="hidden" name="pageNum" value="${cri.pageNum}">
    <input type="hidden" name="amount" value="${cri.amount}">
    <c:if test="${cri.types != null && cri.keyword != null}">
        <c:forEach var="type" items="${cri.types}">
            <input type="hidden" name="types" value="${type}">
        </c:forEach>
        <input type="hidden" name="keyword" value="${cri.keyword}">
    </c:if>
</form>
<script>
    const bno = '${vo.bno}'
    const actionForm = document.querySelector('#actionForm');
    const listForm = document.querySelector("#listForm")

    document.querySelector('.btnList').addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        listForm.submit();
    }, false)

    document.querySelector('.btnModify').addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();

        actionForm.action = '/board/modify/' + bno
        actionForm.method = 'post'
        actionForm.submit();
    }, false)


    document.querySelector('.btnRemove').addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();

        actionForm.action = '/board/remove/' + bno
        actionForm.method = 'post'
        actionForm.submit();
    }, false)
</script>

<%@ include file="../includes/footer.jsp" %>
<%@ include file="../includes/end.jsp" %>

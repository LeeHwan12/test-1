<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="addurl" value="/addtalent" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재능 등록</title>
    <link href="<c:url value='/resources/css/bootstrap.min.css' />" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/nav.jsp" />
<div class="container mt-5">
    <h2 class="mb-4">재능 등록</h2>

    <form:form modelAttribute="newTalent"
               method="post"
               action="${addurl}">

        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <form:input path="title" cssClass="form-control" id="title"/>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">설명</label>
            <form:textarea path="description" rows="5" cssClass="form-control" id="description"/>
        </div>

        <div class="mb-3">
            <label class="form-label">카테고리</label>
            <div class="form-check">
                <form:radiobutton path="category" value="디자인" cssClass="form-check-input" id="cat1"/>
                <label for="cat1" class="form-check-label">디자인</label>
            </div>
            <div class="form-check">
                <form:radiobutton path="category" value="프로그래밍" cssClass="form-check-input" id="cat2"/>
                <label for="cat2" class="form-check-label">프로그래밍</label>
            </div>
            <div class="form-check">
                <form:radiobutton path="category" value="번역" cssClass="form-check-input" id="cat3"/>
                <label for="cat3" class="form-check-label">번역</label>
            </div>
            <div class="form-check">
                <form:radiobutton path="category" value="음악" cssClass="form-check-input" id="cat4"/>
                <label for="cat4" class="form-check-label">음악</label>
            </div>
            <div class="form-check">
                <form:radiobutton path="category" value="영상편집" cssClass="form-check-input" id="cat5"/>
                <label for="cat5" class="form-check-label">영상편집</label>
            </div>
            <div class="form-check">
                <form:radiobutton path="category" value="글쓰기" cssClass="form-check-input" id="cat6"/>
                <label for="cat6" class="form-check-label">글쓰기</label>
            </div>
            <div class="form-check">
                <form:radiobutton path="category" value="과외" cssClass="form-check-input" id="cat7"/>
                <label for="cat7" class="form-check-label">과외</label>
            </div>
            <div class="form-check">
                <form:radiobutton path="category" value="생활서비스" cssClass="form-check-input" id="cat8"/>
                <label for="cat8" class="form-check-label">생활서비스</label>
            </div>
            <div class="form-check mb-3">
                <form:radiobutton path="category" value="기획창작" cssClass="form-check-input" id="cat9"/>
                <label for="cat9" class="form-check-label">기획/창작</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="timeSlot" class="form-label">판매 시간 (분 단위)</label>
            <form:input path="timeSlot" cssClass="form-control" id="timeSlot"/>
        </div>

        <button type="submit" class="btn btn-primary">등록하기</button>
    </form:form>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>

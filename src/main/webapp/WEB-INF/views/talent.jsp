<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>재능 게시판</title>

    <!-- Pretendard 폰트 -->
    <link href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="<c:url value='/resources/css/bootstrap.min.css' />" rel="stylesheet">

    <style>
        body {
            font-family: 'Pretendard', sans-serif;
            background: linear-gradient(to right, #ffe6f0, #fff0f5);
        }

        h5, h4 {
            color: #ff69b4;
        }

        .custom-card {
            border-radius: 20px;
            background: linear-gradient(to right, #fffdfd, #fff0f5);
            border: 1px solid #ffd6e6;
            box-shadow: 0 4px 12px rgba(255, 105, 180, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            color: inherit;
        }

        .custom-card:hover {
            transform: scale(1.015);
            box-shadow: 0 8px 20px rgba(255, 105, 180, 0.2);
            background: #fff0f7;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #333;
        }

        .card-category {
            font-size: 0.95rem;
            font-weight: 500;
            color: #ff69b4;
        }

        .card-username {
            font-size: 0.95rem;
            font-weight: 600;
            color: #555;
        }

        .card-meta {
            font-size: 0.85rem;
            font-weight: 400;
            color: #888;
        }

        .btn-primary {
            background-color: #ff99cc;
            border-color: #ff99cc;
        }

        .btn-primary:hover {
            background-color: #ff66b2;
            border-color: #ff66b2;
        }

        .btn-outline-primary {
            color: #ff69b4;
            border-color: #ff69b4;
        }

        .btn-outline-primary:hover {
            background-color: #ff69b4;
            color: white;
        }

        .list-group-item.active {
            background-color: #ff99cc;
            border-color: #ff99cc;
        }

        .pagination .page-item.active .page-link {
            background-color: #ff99cc;
            border-color: #ff99cc;
            color: white;
        }

        .page-link {
            color: black;
            border: 1px solid #ffb6d9;
        }

        .page-link:hover {
            background-color: #ffe6f0;
            color: #ff3366;
            border-color: #ff99cc;
        }

        .fs-4.text-muted {
            font-size: 1.25rem;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/nav.jsp" />

<div class="container mt-3">
    <div class="row align-items-start">
        <!-- 좌측 카테고리 -->
        <div class="col-md-3">
            <h5 class="mb-3">카테고리</h5>
            <div class="list-group mb-3">
                <a href="<c:url value='/talent/전체' />" class="list-group-item list-group-item-action ${category == '전체' ? 'active' : ''}">전체</a>
                <a href="<c:url value='/talent/디자인' />" class="list-group-item list-group-item-action ${category == '디자인' ? 'active' : ''}">디자인</a>
                <a href="<c:url value='/talent/프로그래밍' />" class="list-group-item list-group-item-action ${category == '프로그래밍' ? 'active' : ''}">프로그래밍</a>
                <a href="<c:url value='/talent/번역' />" class="list-group-item list-group-item-action ${category == '번역' ? 'active' : ''}">번역</a>
                <a href="<c:url value='/talent/음악' />" class="list-group-item list-group-item-action ${category == '음악' ? 'active' : ''}">음악</a>
                <a href="<c:url value='/talent/영상편집' />" class="list-group-item list-group-item-action ${category == '영상편집' ? 'active' : ''}">영상편집</a>
                <a href="<c:url value='/talent/글쓰기' />" class="list-group-item list-group-item-action ${category == '글쓰기' ? 'active' : ''}">글쓰기</a>
                <a href="<c:url value='/talent/과외' />" class="list-group-item list-group-item-action ${category == '과외' ? 'active' : ''}">과외</a>
                <a href="<c:url value='/talent/생활서비스' />" class="list-group-item list-group-item-action ${category == '생활서비스' ? 'active' : ''}">생활서비스</a>
                <a href="<c:url value='/talent/기획창작' />" class="list-group-item list-group-item-action ${category == '기획창작' ? 'active' : ''}">기획/창작</a>
            </div>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <a href="<c:url value='/addtalent' />" class="btn btn-primary w-100">등록</a>
            </c:if>
        </div>

        <!-- 우측 콘텐츠 -->
        <div class="col-md-9">
            <form class="mb-4" action="<c:url value='/talent/search' />" method="get">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요" value="${keyword}" required />
                    <button class="btn btn-outline-primary" type="submit">검색</button>
                </div>
            </form>

            <!-- 카드 리스트 -->
            <div class="row">
                <c:choose>
                    <c:when test="${not empty talentList}">
                        <c:forEach var="dto" items="${talentList}">
                            <div class="col-md-6 mb-4">
                                <a href="<c:url value='/talent/view?id=${dto.talent_id}' />" class="custom-card d-block">
                                    <div class="card-body">
                                        <h5 class="card-title">${dto.title}</h5>
                                        <p class="card-category">카테고리: ${dto.category}</p>
                                        <p class="card-username">작성자: ${dto.username}</p>
                                        <p class="card-meta">판매 시간: ${dto.timeSlotDisplay}</p>
                                        <p class="card-meta">등록일: ${dto.formattedCreatedAt}</p>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="col-12 d-flex justify-content-center align-items-center" style="height: 200px;">
                            <p class="fs-4 text-muted">표시할 재능이 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이징 -->
            <c:set var="queryString" value="" />
            <c:if test="${not empty keyword}">
                <c:set var="queryString" value="&keyword=${keyword}" />
            </c:if>
            <c:if test="${not empty category}">
                <c:set var="queryString" value="&category=${category}" />
            </c:if>

            <c:if test="${totalPages > 1}">
                <div class="d-flex justify-content-center mt-4">
                    <nav>
                        <ul class="pagination">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}${queryString}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
</div>

<div style="text-align: center; margin-top: 30px;">
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</div>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전문가 게시판</title>

    <!-- 감성 폰트 Pretendard -->
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

        .card {
            border: 1px solid #ffcce0;
            border-radius: 12px;
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 10px rgba(255, 105, 180, 0.15);
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

        .pagination .active .page-link {
            background-color: #ff99cc;
            border-color: #ff99cc;
        }

        .page-link {
            color: #ff69b4;
        }

        .page-link:hover {
            color: #ff3366;
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
                <a href="<c:url value='/expert/전체' />" class="list-group-item list-group-item-action ${category == '전체' ? 'active' : ''}">전체</a>
                <a href="<c:url value='/expert/디자인' />" class="list-group-item list-group-item-action ${category == '디자인' ? 'active' : ''}">디자인</a>
                <a href="<c:url value='/expert/프로그래밍' />" class="list-group-item list-group-item-action ${category == '프로그래밍' ? 'active' : ''}">프로그래밍</a>
                <a href="<c:url value='/expert/마케팅' />" class="list-group-item list-group-item-action ${category == '마케팅' ? 'active' : ''}">마케팅</a>
                <a href="<c:url value='/expert/상담' />" class="list-group-item list-group-item-action ${category == '상담' ? 'active' : ''}">상담</a>
                <a href="<c:url value='/expert/기획' />" class="list-group-item list-group-item-action ${category == '기획' ? 'active' : ''}">기획</a>
            </div>

            <!-- 로그인 + 전문가인 경우에만 등록 버튼 표시 -->
            <c:if test="${not empty sessionScope.loggedInUser and sessionScope.loggedInUser.expert}">
                <a href="<c:url value='/expert/add' />" class="btn btn-primary w-100">➕ 전문가 등록</a>
            </c:if>
        </div>

        <!-- 우측 콘텐츠 -->
        <div class="col-md-9">
            <!-- 검색창 -->
            <form class="mb-4" action="<c:url value='/expert/search' />" method="get">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" placeholder="전문가를 검색하세요" value="${keyword}" required />
                    <button class="btn btn-outline-primary" type="submit">검색</button>
                </div>
            </form>

            <!-- 카드 리스트 -->
            <div class="row">
                <c:choose>
                    <c:when test="${not empty expertList}">
                        <c:forEach var="dto" items="${expertList}">
                            <div class="col-md-6 mb-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <a href="<c:url value='/expert/view?id=${dto.expert_board_id}' />">${dto.title}</a>
                                        </h5>
                                        <p class="card-text">${dto.content}</p>
                                        <p>카테고리: ${dto.category}</p>
                                        <p>닉네임: ${dto.expert_id}</p>
                                        <p>예약 가능 시간: ${dto.available_time}</p>
                                        <p>가격: ${dto.price}원</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="col-12 d-flex justify-content-center align-items-center" style="height: 200px;">
                            <p class="fs-4 text-muted">표시할 전문가가 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이징 -->
            <c:if test="${totalPages > 1}">
                <div class="d-flex justify-content-center mt-4">
                    <nav>
                        <ul class="pagination">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&category=${category}${isSearch ? '&keyword=' + keyword : ''}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
        
    </div>
    
</div>
<jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>

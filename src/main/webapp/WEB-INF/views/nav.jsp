<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네비게이션 바</title>
<link href="<c:url value='/resources/css/bootstrap.min.css' />" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css" rel="stylesheet">

<style>
    body {
        font-family: 'Pretendard', sans-serif;
    }

    .navbar-custom .nav-link {
        font-weight: 600;
        color: #333;
    }

    .btn-mypage {
        background-color: #ff99cc;
        color: white;
        border: none;
        padding: 6px 12px;
        border-radius: 6px;
        font-size: 0.9rem;
    }

    .btn-mypage:hover {
        background-color: #ff66b2;
        color: white;
    }

    .btn-logout {
        background-color: #ffcccc;
        color: #333;
        border: none;
        padding: 6px 12px;
        border-radius: 6px;
        font-size: 0.9rem;
    }

    .btn-logout:hover {
        background-color: #ff9999;
        color: white;
    }
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm sticky-top navbar-custom">
    <div class="container d-flex justify-content-between align-items-center">

        <!-- 왼쪽 메뉴 -->
        <div class="d-flex gap-3">
            <a class="nav-link" href="<c:url value='/' />">홈</a>
            <a class="nav-link" href="<c:url value='/talent' />">시간 거래소</a>
            <a class="nav-link" href="<c:url value='/expert' />">전문가</a>
            <a class="nav-link" href="<c:url value='/ranking' />">랭킹</a>
        </div>

        <!-- 오른쪽 로그인/회원가입 or 마이페이지/로그아웃 -->
        <div class="d-flex align-items-center gap-3">
		    <c:choose>
		        <c:when test="${not empty sessionScope.loggedInUser}">
		            <span class="fw-bold text-primary me-2">${sessionScope.loggedInUser.userName}님</span>
		            <a href="<c:url value='/mypage' />" class="btn btn-mypage">마이페이지</a>
		            <a href="<c:url value='/logout' />" class="btn btn-logout">로그아웃</a>
		        </c:when>
		        <c:otherwise>
		            <a href="<c:url value='/login' />" class="btn btn-outline-primary btn-sm">로그인</a>
		            <a href="<c:url value='/signUp' />" class="btn btn-outline-secondary btn-sm">회원가입</a>
		        </c:otherwise>
		    </c:choose>
		</div>

    </div>
</nav>
</body>
</html>

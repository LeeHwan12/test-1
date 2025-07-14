<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>

    <!-- 감성 폰트 Pretendard -->
    <link href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="<c:url value='/resources/css/bootstrap.min.css' />" rel="stylesheet">

    <style>
        body {
            font-family: 'Pretendard', sans-serif;
            background: linear-gradient(to right, #ffe6f0, #fff0f5);
        }

        .card {
            border: 1px solid #ffcce0;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(255, 105, 180, 0.1);
        }

        .card-header {
            background-color: #ff99cc;
        }

        .card-header h4 {
            color: white;
            margin-bottom: 0;
        }

        p {
            font-size: 1rem;
            margin: 0.5rem 0;
        }

        strong {
            color: #ff69b4;
        }
        .card-header h4 {
		    color: #ff69b4; /* 더 진한 흰색 */
		    margin-bottom: 0;
		}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/nav.jsp" />

<div class="container mt-5">
    <div class="card">
	    <div class="card-header">
	        <h4>마이페이지</h4>
	    </div>
	    <div class="card-body">
	        <p><strong>ID:</strong> ${member.member_id}</p>
	        <p><strong>닉네임:</strong> ${member.userName}</p>
	        <p><strong>이름:</strong> ${member.name}</p>
	        <p><strong>이메일:</strong> ${member.email}</p>
	        <p><strong>전화번호:</strong> ${member.phone}</p>
			<a href="<c:url value='/purchase/received' />" class="btn btn-outline-primary mt-3">
            	받은 구매 요청 확인하기
        	</a>
	        <c:if test="${sessionScope.loggedInUser.member_id == member.member_id}">
	            <p><strong>주소:</strong> ${member.addr}</p>
	        </c:if>
	    </div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>

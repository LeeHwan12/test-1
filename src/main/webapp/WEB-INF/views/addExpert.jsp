<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전문가 등록</title>

    <!-- 감성 폰트 Pretendard -->
    <link href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="<c:url value='/resources/css/bootstrap.min.css' />" rel="stylesheet">

    <style>
        body {
            font-family: 'Pretendard', sans-serif;
            background: linear-gradient(to right, #ffe6f0, #fff0f5);
        }

        h3 {
            color: #ff69b4;
        }

        .btn-primary {
            background-color: #ff99cc;
            border-color: #ff99cc;
        }

        .btn-primary:hover {
            background-color: #ff66b2;
            border-color: #ff66b2;
        }

        .form-control:focus {
            border-color: #ff99cc;
            box-shadow: 0 0 0 0.2rem rgba(255, 153, 204, 0.25);
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/nav.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h3 class="text-center mb-4">📝 전문가 재능 등록</h3>

            <form action="<c:url value='/expert/add' />" method="post">
                <div class="mb-3">
                    <label for="title" class="form-label">제목</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">내용</label>
                    <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="category" class="form-label">카테고리</label>
                    <select class="form-select" id="category" name="category" required>
                        <option value="" disabled selected>선택하세요</option>
                        <option value="디자인">디자인</option>
                        <option value="프로그래밍">프로그래밍</option>
                        <option value="마케팅">마케팅</option>
                        <option value="상담">상담</option>
                        <option value="기획">기획</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="price" class="form-label">가격 (원)</label>
                    <input type="number" class="form-control" id="price" name="price" min="0" required>
                </div>

                <div class="mb-3">
                    <label for="available_time" class="form-label">예약 가능 시간 (예: 월 14:00, 화 15:00)</label>
                    <input type="text" class="form-control" id="available_time" name="available_time" required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <a href="<c:url value='/expert' />" class="btn btn-outline-secondary ms-2">취소</a>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>

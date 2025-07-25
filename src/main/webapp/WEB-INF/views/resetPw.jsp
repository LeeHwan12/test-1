<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 재설정</title>
  <link href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css" rel="stylesheet">

  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Pretendard', sans-serif;
      background: linear-gradient(to right, #ffe6f0, #fff0f5);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      flex-direction: column;
    }

    h2 {
      font-size: 36px;
      color: #ff69b4;
      margin-bottom: 20px;
    }

    form {
      background: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: column;
      width: 320px;
      gap: 15px;
    }

    input[type="password"] {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 16px;
    }

    button {
      padding: 12px;
      background-color: #ff99cc;
      border: none;
      border-radius: 8px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #ff66b2;
    }

    .error {
      color: red;
      font-size: 15px;
      margin-top: 10px;
    }
  </style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/nav.jsp" />
  
  <p>넘어온 member_id: ${member_id}</p>

  <h2>비밀번호 재설정</h2>

  <form method="post" action="${pageContext.request.contextPath}/resetPw">
    <!-- 아이디는 hidden 처리해서 같이 보냄 -->
    <input type="hidden" name="member_id" value="${member_id}" />

    <input type="password" name="newPw" placeholder="새 비밀번호" required />
    <input type="password" name="confirmPw" placeholder="비밀번호 확인" required />

    <button type="submit">비밀번호 변경하기</button>
  </form>

  <c:if test="${not empty error}">
    <p class="error">${error}</p>
  </c:if>
</body>
</html>

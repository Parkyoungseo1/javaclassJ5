<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Main Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file = "../../include/bs4.jsp" %>
  <style>
    .fakeimg {
      height: 200px;
      background: #aaa;
    }
    .container {
      margin-top: 30px;
    }
    .col-sm-8 h2, .col-sm-8 h5 {
      margin-bottom: 20px;
    }
    .table th, .table td {
      vertical-align: middle;
    }
    .table-hover tbody tr:hover {
      background-color: #f1f1f1;
    }
    .table thead th {
      background-color: #007bff;
      color: #fff;
    }
    .img-fluid {
      border-radius: 8px;
    }
    .content {
      background: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .custom-img {
      width: 100%;
      height: 400px; /* 원하는 높이로 설정 */
      object-fit: cover; /* 이미지 비율 유지하며 잘라내기 */
    }
  </style>
</head>
<body>
<%@ include file = "../../include/header.jsp" %>

<!-- 메뉴바(Nav) -->
<%@ include file = "../../include/nav.jsp" %>

<div class="container">
  <div class="row">
    <div class="col-sm-4">
      <img src="${ctp}/images/member/junggomain.jpg" alt="Description of image" class="img-fluid custom-img mb-3">
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-8 content">
      <h2>실시간 채팅</h2>
      <h5>Title description, Dec 7, 2017</h5>
      <h5 class="mb-4">로그인 중인 회원 : ${sName}</h5>
      <h6 class="text-right">최근 올라온 채팅</h6>
      <table class="table table-hover text-center">
        <thead>
          <tr>
            <th>번호</th>
            <th>아이디</th>
            <th>성명</th>
            <th>나이</th>
            <th>성별</th>
            <th>주소</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="vo" items="${vos}" varStatus="st">
            <tr>
              <td>${vo.idx}</td>
              <td>${vo.mid}</td>
              <td>${vo.name}</td>
              <td>${vo.age}</td>
              <td>${vo.gender}</td>
              <td>${vo.address}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <p></p>
      <p></p>
      <hr/>
      <h2></h2>
      <h5></h5>
      <div class="fakeimg">Fake Image</div>
      <p></p>
      <p></p>
    </div>
  </div>
</div>
<%@ include file = "../../include/footer.jsp" %>
</body>
</html>
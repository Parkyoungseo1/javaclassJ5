<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminLeft.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
    body {
      background-color: #f8f9fa;
      color: #343a40;
    }
    .sidebar {
      background-color: #343a40;
      color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .sidebar h5 {
      margin-top: 20px;
    }
    .sidebar a {
      color: #ffc107;
      text-decoration: none;
    }
    .sidebar a:hover {
      color: #fff;
    }
    .small-image {
      width: 80px;
      height: auto;
      border-radius: 50%;
      margin-bottom: 20px;
    }
    hr {
      border-color: #ffc107;
    }
    .link-group {
      margin-bottom: 20px;
    }
    .link-group a {
      display: block;
      padding: 10px;
      border: 1px solid #ffc107;
      border-radius: 4px;
      margin-bottom: 5px;
      text-align: left;
    }
  </style>
</head>
<body>
  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-15 col-md-8 col-lg-6 sidebar text-center">
        <!-- 관리자 메뉴 로고 이미지 추가 -->
        <img src="${ctp}/images/member/admin.png" class="small-image" alt="관리자 로고">
        <h5><a href="AdminMain.ad" target="_top">관리자 메뉴</a></h5>
        <hr/>
        <p><a href="${ctp}/Main" target="_top">홈으로</a></p>
        <hr/>
        <div class="link-group">
          <h5>게시판</h5>
          <div><a href="BoardList.ad" target="adminContent">게시판 리스트</a></div>
        </div>
        <hr/>
        <div class="link-group">
          <h5>회원관리</h5>
          <div><a href="MemberList.ad" target="adminContent">회원 리스트</a></div>
          <div><a href="ComplaintList.ad" target="adminContent">신고 리스트</a></div>
        </div>
        <hr/>
      </div>
    </div>
  </div>
</body>
</html>
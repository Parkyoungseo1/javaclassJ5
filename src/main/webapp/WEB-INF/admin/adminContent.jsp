<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminContent.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
    body {
      background-color: #f8f9fa;
      color: #343a40;
    }
    .container {
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    h3 {
      margin-bottom: 20px;
    }
    .stat-card {
      background-color: #ffc107;
      color: #fff;
      padding: 20px;
      border-radius: 8px;
      text-align: center;
      margin-bottom: 20px;
    }
    .stat-card a {
      color: #fff;
      text-decoration: none;
    }
    .stat-card a:hover {
      color: #343a40;
    }
    .stat-card b {
      font-size: 1.5rem;
    }
  </style>
</head>
<body>
  <div class="container mt-5">
    <h3>관리자 메인화면</h3>
    <hr/>
    <!--
      - 방명록은 최근 1주일안에 작성된글의 개수를 보여준다.
      - 게시판은....__________
      - 신규등록건수 출력
      - 탈퇴신청회원 건수 출력
    -->
    <div class="row">
      <div class="col-md-6">
        <div class="stat-card">
          <p>게시글 새글</p>
          <a href="BoardList.ad?level=1"><b>${mCount}</b></a>건
        </div>
      </div>
      <div class="col-md-6">
        <div class="stat-card">
          <p>신고글(최근 1주일)</p>
          <a href="Complaint.ad?level=1"><b>${mCount}</b></a>건
        </div>
      </div>
      <div class="col-md-6">
        <div class="stat-card">
          <p>신규등록회원</p>
          <a href="MemberList.ad?level=1"><b>${mCount}</b></a>건
        </div>
      </div>
      <div class="col-md-6">
        <div class="stat-card">
          <p>탈퇴신청회원</p>
          <a href=""><b>${m99Count}</b></a>건
        </div>
      </div>
    </div>
  </div>
  <p><br/></p>
</body>
</html>
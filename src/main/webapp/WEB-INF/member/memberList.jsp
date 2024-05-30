<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Member List</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
    'use strict';

    $(document).ready(function(){
      $("#userDisplay").hide();

      $("#userInfor").on("click", function(){
        if($("#userInfor").is(':checked')) {
          $("#totalList").hide();
          $("#userDisplay").show();
        } else {
          $("#totalList").show();
          $("#userDisplay").hide();
        }
      });
    });
  </script>
  <style>
    body {
      background-color: #f2f2f2;
    }
    .container {
      background: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      margin-top: 30px;
    }
    .form-check-label {
      cursor: pointer;
    }
    h3 {
      color: #333;
      margin-bottom: 20px;
    }
    table {
      background-color: #fff;
    }
    .table thead th {
      background-color: #007bff;
      color: #fff;
    }
    .table-hover tbody tr:hover {
      background-color: #f1f1f1;
    }
    .badge {
      font-size: 90%;
    }
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<div class="container">
  <c:if test="${sLevel == 0}">
    <div class="form-check">
      <input class="form-check-input" type="checkbox" id="userInfor">
      <label class="form-check-label" for="userInfor">비공개회원만보기/전체보기</label>
    </div>
  </c:if>
  <hr/>
  <div id="totalList">
    <h3 class="text-center">전체 회원 리스트</h3>
    <table class="table table-hover table-striped text-center">
      <thead>
        <tr>
          <th>번호</th>
          <th>아이디</th>
          <th>닉네임</th>
          <th>성명</th>
          <th>생일</th>
          <th>성별</th>
          <th>최종방문일</th>
          <c:if test="${sLevel == 0}">
            <th>오늘방문횟수</th>
            <th>활동여부</th>
          </c:if>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${vos}" varStatus="st">
          <c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
            <tr>
              <td>${vo.idx}</td>
              <td><a href="MemberSearch.mem?mid=${vo.mid}" class="text-primary">${vo.mid}</a></td>
              <td>${vo.nickName}</td>
              <td>${vo.name}</td>
              <td>${fn:substring(vo.birthday, 0, 10)}</td>
              <td>${vo.gender}</td>
              <td>${fn:substring(vo.lastDate, 0, 10)}</td>
              <c:if test="${sLevel == 0}">
                <td>${vo.todayCnt}</td>
                <td>
                  <c:choose>
                    <c:when test="${vo.userDel == 'OK'}">
                      <span class="badge bg-danger">탈퇴신청</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge bg-success">활동중</span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </c:if>
            </tr>
          </c:if>
        </c:forEach>
      </tbody>
    </table>
  </div>
  <div id="userDisplay">
    <c:if test="${sLevel == 0}">
      <h3 class="text-center">비공개 회원 리스트</h3>
      <table class="table table-hover table-striped text-center">
        <thead>
          <tr>
            <th>번호</th>
            <th>아이디</th>
            <th>닉네임</th>
            <th>성명</th>
            <th>생일</th>
            <th>성별</th>
            <th>최종방문일</th>
            <th>오늘방문횟수</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="vo" items="${vos}" varStatus="st">
            <c:if test="${vo.userInfor == '비공개'}">
              <tr>
                <td>${vo.idx}</td>
                <td>${vo.mid}</td>
                <td>${vo.nickName}</td>
                <td>${vo.name}</td>
                <td>${fn:substring(vo.birthday, 0, 10)}</td>
                <td>${vo.gender}</td>
                <td>${fn:substring(vo.lastDate, 0, 10)}</td>
                <td>${vo.todayCnt}</td>
              </tr>
            </c:if>
          </c:forEach>
        </tbody>
      </table>
    </c:if>
  </div>
</div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
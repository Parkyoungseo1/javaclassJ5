<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
       <table class="table table-hover m-0 p-0 text-center">
    <tr class="table-dark text-dark">
      <th>글제목</th>
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>분류</th>
      <th>조회수(추천)</th>
    </tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <%-- 
      <c:if test="${vo.openSw == 'OK' || sLevel == 0 || sNickName == vo.nickName}">
      	<c:if test="${vo.complaint == 'NO' || sLevel == 0 || sNickName == vo.nickName}">
       --%>
			    <tr>
			      <td class="text-left">
			        <a>${vo.title}</a>
			        <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/member/new.gif"/></c:if>  
			        <c:if test="${vo.replyCnt != 0}">(${vo.replyCnt})</c:if>
			      </td>
			      <td>
			        ${vo.nickName}
			        <c:if test="${sLevel == 0}">
			          <a href="#" onclick="modalCheck('${vo.idx}','${vo.price}','${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#myModal" class="badge badge-success">모달</a>
			        </c:if>
			      </td>
			      <td>
			        <!-- 1일(24시간) 이내는 시간만 표시(10:43), 이후는 날짜와 시간을 표시 : 2024-05-14 10:43 -->
			        ${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}
			      </td>
			      <td>${vo.part}</td>
			      <td>${vo.readNum}(${vo.good})</td>
			    </tr>
			<%-- 
		    </c:if>
	    </c:if>
	     --%>
	    <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
	  </c:forEach>
	  <tr><td colspan="7" class="m-0 p-0"></td></tr>
  </table>     
      <p></p>
      <p></p>
    </div>
  </div>
</div>
<%@ include file = "../../include/footer.jsp" %>
</body>
</html>
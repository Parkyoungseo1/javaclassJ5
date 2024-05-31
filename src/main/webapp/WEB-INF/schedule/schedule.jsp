<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Schedule</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style>
    #td1, #td8, #td15, #td22, #td29, #td36 {color:red;}
    #td7, #td14, #td21, #td28, #td35 {color:blue;}

    .today {
      background-color: #ffebcd;
      color: #000;
      font-weight: bolder;
    }
    .btn-custom {
      background-color: #4CAF50;
      color: white;
      border: none;
    }
    .btn-custom:hover {
      background-color: #45a049;
    }
    .table-bordered th, .table-bordered td {
      border: 1px solid #dee2e6;
    }
    .table-dark th {
      background-color: #343a40;
      color: white;
    }
    .table th, .table td {
      vertical-align: middle;
    }
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="text-center mb-3">
    <button type="button" onclick="location.href='Schedule.sc?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="Previous Year">◁</button>
    <button type="button" onclick="location.href='Schedule.sc?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="Previous Month">◀</button>
    <span class="h4">${yy}년 ${mm+1}월</span>
    <button type="button" onclick="location.href='Schedule.sc?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="Next Month">▶</button>
    <button type="button" onclick="location.href='Schedule.sc?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="Next Year">▷</button>
    <button type="button" onclick="location.href='Schedule.sc';" class="btn btn-secondary btn-sm" title="Today's Date">♥</button>
  </div>
  <div class="table-responsive">
    <table class="table table-bordered text-center">
      <thead class="table-dark">
        <tr>
          <th style="width:14%; color:red;">일</th>
          <th style="width:14%;">월</th>
          <th style="width:14%;">화</th>
          <th style="width:14%;">수</th>
          <th style="width:14%;">목</th>
          <th style="width:14%;">금</th>
          <th style="width:14%; color:blue;">토</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <!-- 시작일 이전을 공백으로 처리한다. -->
          <c:forEach var="prevDay" begin="${prevLastDay - (startWeek - 2)}" end="${prevLastDay}">
            <td class="text-muted small">${prevYear}-${prevMonth+1}-${prevDay}</td>
          </c:forEach>
          
          <!-- 해당월의 1일을 startWeek위치부터 출력한다. -->
          <c:set var="cell" value="${startWeek}" />
          <c:forEach begin="1" end="${lastDay}" varStatus="st">
            <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
            <td id="td${cell}" class="${todaySw==1 ? 'today' : ''}" style="text-align:left;vertical-align:top;height:90px;">
              <c:set var="ymd" value="${yy}-${mm+1}-${st.count}"/>
              <a href="ScheduleMenu.sc?ymd=${ymd}" class="text-decoration-none text-reset">
                ${st.count}<br/>
                <c:forEach var="vo" items="${vos}">
                  <c:if test="${fn:substring(vo.sDate,8,10)==st.count}">
                    <span class="d-block small text-info">- ${vo.part}(${vo.partCnt})</span>
                  </c:if>
                </c:forEach>
              </a>
            </td>
            <c:if test="${cell % 7 == 0}"></tr><tr></c:if>
            <c:set var="cell" value="${cell + 1}" />
          </c:forEach>
          
          <!-- 마지막일 이후를 다음달의 시작일자로부터 채워준다. -->
          <c:if test="${(cell - 1) % 7 != 0}">
            <c:forEach begin="${nextStartWeek}" end="7" varStatus="st">
              <td class="text-muted small">${nextYear}-${nextMonth+1}-${st.count}</td>
            </c:forEach>
          </c:if>
        </tr>
      </tbody>
    </table>
  </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>scheduleMenu.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
    'use strict';
    
    $(function() {
    	$("#scheduleInputClose").hide();
    });
    
    function scheduleInputView() {
    	let str = '<div id="scheduleInputForm">';
    	str += '<form name="scheduleForm">';
    	str += '<table class="table table-bordered">';
    	str += '<tr>';
    	str += '<th>거래분류</th><td>';
    	str += '<select name="part" class="form-control">';
    	str += '<option>신발</option>';
    	str += '<option>가구</option>';
    	str += '<option>옷</option>';
    	str += '<option>전자제품</option>';
    	str += '<option>기타</option>';
    	str += '</select>';
    	str += '</td></tr>';
    	str += '<tr><th>내역</th><td>';
    	str += '<textarea name="content" rows="4" class="form-control"></textarea>';
    	str += '</td></tr>';
    	str += '<tr><td colspan="2" class="text-center">';
    	str += '<input type="button" value="일정등록" onclick="scheduleInputOk()" class="btn btn-success form-control"/>';
    	str += '</td></tr>';
    	str += '</table>';
    	str += '</form>';
    	str += '</div>';
    	
    	$("#scheduleInputView").hide();
    	$("#scheduleInputClose").show();
    	
    	$("#demo").html(str);
    }
    
    function scheduleInputClose() {
    	$("#scheduleInputView").show();
    	$("#scheduleInputClose").hide();
    	$("#scheduleInputForm").hide();
    }
    
    // 일정 등록하기
    function scheduleInputOk() {
    	let part = scheduleForm.part.value;
    	let content = scheduleForm.content.value;
    	if(content.trim() == "") {
    		alert("일정을 입력하세요");
    		scheduleForm.content.focus();
    		return false;
    	}
    	let query = {
    			mid  : '${sMid}',
    			sDate: '${ymd}',
    			part : part,
    			content:content
    	}
    	
    	$.ajax({
    		url  : "ScheduleInputOk.sc",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("일정이 등록되었습니다.");
    				location.reload();
    			}
    			else alert("일정 등록 실패~");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 일정 삭제하기
    function scheduleDeleteCheck(idx) {
    	let ans = confirm("선택된 일정을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "ScheduleDeleteOk.sc",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert("일정이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("일정 삭제 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    // 모달창에 상세내역 뿌리기
    function modalView(part, content) {
    	$("#myModal #part").html(part);
    	$("#myModal #content").html(content);
    }
  </script>
  <style>
    th {
      text-align: center;
      background-color: #ccc;
    }
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h4>${ymd}의 일정입니다.</h4>
  <p>오늘의 일정은 총 ${scheduleCnt}건이 있습니다.</p>
  <hr/>
  <div>
    <input type="button" value="일정등록" onclick="scheduleInputView()" id="scheduleInputView" class="btn btn-success mb-2"/>
    <input type="button" value="일정닫기" onclick="scheduleInputClose()" id="scheduleInputClose" class="btn btn-success mb-2"/>
    <c:set var="ymds" value="${fn:split(ymd, '-')}"/>
    <input type="button" value="돌아가기" onclick="location.href='Schedule.sc?yy=${ymds[0]}&mm=${ymds[1]-1}';" class="btn btn-warning mb-2"/>
  </div>
  <div id="demo"></div>
  <hr/>
  <c:if test="${scheduleCnt != 0}">
    <table class="table table-hover text-center">
      <tr class="table-dark text-dark">
        <th>번호</th>
        <th>분류</th>
        <th>내역</th>
        <th>비고</th>
      </tr>
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <tr>
          <td>${st.count}</td>
          <td>${vo.part}</td>
          <td class="text-left">
            <a href="#" onclick="modalView('${vo.part}','${fn:replace(vo.content,newLine,'<br/>')}')" data-toggle="modal" data-target="#myModal">
              <c:if test="${fn:indexOf(vo.content, newLine) != -1}">${fn:replace(vo.content,newLine,'<br/>')}</c:if>
              <c:if test="${fn:indexOf(vo.content, newLine) == -1}">
	            	<c:if test="${fn:length(vo.content) >= 15}">${fn:substring(vo.content,0,16)}...</c:if>
	            	<c:if test="${fn:length(vo.content) < 15}">${vo.content}</c:if>
	            </c:if>
            </a>
          </td>
          <td>
            <input type="button" value="수정" onclick="scheduleUpdate()" class="btn btn-primary btn-sm"/>
            <input type="button" value="삭제" onclick="scheduleDeleteCheck(${vo.idx})" class="btn btn-danger btn-sm"/>
          </td>
        </tr>
      </c:forEach>
      <tr><td colspan="4" class="m-0 p-0"></td></tr>
    </table>
  </c:if>
</div>
<p><br/></p>
<!-- 일정 상세내역출력을 위한 모달처리 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">>> <b>${ymd}</b></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
          <table class="table table-bordered">
            <tr><th>분류</th><td><span id="part"></span></td>
            <tr><th>내용</th><td><span id="content"></span></td>
          </table>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
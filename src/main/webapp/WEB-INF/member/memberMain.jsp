<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ include file = "/include/certification.jsp" %> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Member Main Page</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style>
    body {
      font-family: 'Arial', sans-serif;
    }
    .container {
      margin-top: 20px;
    }
    .chat-container {
      background: #f8f9fa;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .chat-header {
      font-size: 1.5rem;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .chat-frame {
      border: 1px solid #ced4da;
      border-radius: 8px;
      overflow: hidden;
    }
    .chat-input {
      display: flex;
      margin-top: 10px;
    }
    .chat-input input[type="text"] {
      flex-grow: 1;
      border-top-left-radius: 8px;
      border-bottom-left-radius: 8px;
    }
    .chat-input input[type="button"] {
      border-top-right-radius: 8px;
      border-bottom-right-radius: 8px;
    }
    .member-info {
      margin-top: 20px;
      display: flex;
      flex-wrap: wrap;
    }
    .member-info .col {
      flex: 1;
      min-width: 200px;
      margin-bottom: 20px;
    }
    .member-info img {
      max-width: 100%;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .activity-log {
      margin-top: 20px;
    }
  </style>
  <script>
    'use strict';
    
    function chatInput() {
      let chat = $("#chat").val();
      if(chat.trim() != "") {
        $.ajax({
          url  : "MemberChatInput.mem",
          type : "post",
          data : {chat : chat},
          error: function() {
            alert("전송오류!!");
          }
        });
      }
    }

    $(function(){
      $("#chat").on("keydown", function(e){
        if(e.keyCode == 13) chatInput();
      });
    });
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<div class="container">
  <h2>회원 전용방</h2>
  <hr/>
  <!-- 실시간 채팅방(DB) -->
  <div class="chat-container">
    <div class="chat-header">실시간 대화방</div>
    <iframe src="#" width="100%" height="200px" class="chat-frame"></iframe>
    <div class="chat-input input-group mt-1">
      <input type="text" name="chat" id="chat" class="form-control" placeholder="대화내용을 입력하세요" autofocus/>
      <div class="input-group-append">
        <input type="button" value="글등록" onclick="chatInput()" class="btn btn-success">
      </div>
    </div>
  </div>
  <hr/>
  <div class="member-info">
    <div class="col">
      <p>현재 <b><font color="blue">${sNickName}</font>(<font color="red">${strLevel}</font>)</b> 님이 로그인 중이십니다.</p>
      <p>총 방문횟수 : <b>${mVo.visitCnt}</b> 회</p>
      <p>오늘 방문횟수 : <b>${mVo.todayCnt}</b> 회</p>
      <p>총 보유 포인트 : <b>${mVo.point}</b> 점</p>
    </div>
    <div class="col">
      <img src="${ctp}/images/member/${mVo.photo}" alt="Member Photo"/>
    </div>
  </div>
  <hr/>
  <div class="activity-log">
    <h5>활동내역</h5>
    <p>방명록에 올린글수 : <b>${guestCnt}</b> 건</p> <!-- 방명록에 올린이가 '성명/아이디/닉네임'과 같은면 모두 같은 사람이 올린글로 간주한다. -->
    <p>게사판에 올린글수 : 건</p>
    <p>자료실에 올린글수 : ___건</p>
  </div>
</div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
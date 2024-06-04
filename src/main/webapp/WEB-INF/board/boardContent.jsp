<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Board Content</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 0;
    }
    .container {
      margin-top: 30px;
    }
    .table th, .table td {
      vertical-align: middle;
      text-align: center;
    }
    .table th {
      background-color: #007bff;
      color: #fff;
    }
    .table .content-cell {
      height: 220px;
      overflow-y: auto;
      text-align: left;
    }
    .actions .btn {
      margin-right: 10px;
    }
    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
    }
    .btn-danger {
      background-color: #dc3545;
      border-color: #dc3545;
    }
    .navigation a {
      color: #007bff;
      text-decoration: none;
    }
    .navigation a:hover {
      text-decoration: underline;
    }
    .text-danger {
      color: #dc3545 !important;
    }
    .text-success {
      color: #28a745 !important;
    }
    .text-primary {
      color: #007bff !important;
    }
    .modal-content {
      border-radius: 8px;
    }
    .modal-header {
      background-color: #007bff;
      color: white;
    }
    .modal-footer {
      background-color: #f1f1f1;
    }
    .table.table-hover tbody tr:hover {
      background-color: #f1f1f1;
    }
  </style>
  <script>
    'use strict';
    
    function boardDelete() {
      let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
      if(ans) location.href = "BoardDelete.bo?idx=${vo.idx}";
    }
    
    function goodCheck() {
      $.ajax({
        url: "BoardGoodCheck.bo",
        type: "post",
        data: { idx: ${vo.idx} },
        success: function(res) {
          if(res != "0") location.reload();
        },
        error: function() {
          alert("전송오류");
        }
      });
    }
    
    function goodCheck2() {
      $.ajax({
        url: "BoardGoodCheck2.bo",
        type: "post",
        data: { idx: ${vo.idx} },
        success: function(res) {
          if(res != "0") location.reload();
          else alert("이미 좋아요 버튼을 클릭하셨습니다.");
        },
        error: function() {
          alert("전송오류");
        }
      });
    }
    
    function goodCheckPlus() {
      $.ajax({
        url: "BoardGoodCheckPlusMinus.bo",
        type: "post",
        data: {
          idx: ${vo.idx},
          goodCnt: +1
        },
        success: function(res) {
          location.reload();
        },
        error: function() {
          alert("전송오류");
        }
      });
    }
    
    function goodCheckMinus() {
      $.ajax({
        url: "BoardGoodCheckPlusMinus.bo",
        type: "post",
        data: {
          idx: ${vo.idx},
          goodCnt: -1
        },
        success: function(res) {
          if(res != "0") location.reload();
        },
        error: function() {
          alert("전송오류");
        }
      });
    }
    
    function etcShow() {
      $("#complaintTxt").show();
    }
    
    function complaintCheck() {
      if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
        alert("신고항목을 선택하세요");
        return false;
      }
      if($("input[type=radio]:checked").val() == '기타' && $("#complaintTxt").val() == "") {
        alert("기타 사유를 입력해 주세요.");
        return false;
      }
      
      let cpContent = modalForm.complaint.value;
      if(cpContent == '기타') cpContent += '/' + $("#complaintTxt").val();
      
      let query = {
        part: 'board',
        partIdx: ${vo.idx},
        cpMid: '${sMid}',
        cpContent: cpContent
      }
      
      $.ajax({
        url: "boardComplaintInput.ad",
        type: "post",
        data: query,
        success: function(res) {
          if(res != "0") {
            alert("신고 되었습니다.");
            location.reload();
          } else {
            alert("신고 실패~~");
          }
        },
        error: function() {
          alert("전송 오류!");
        }
      });
    }
    
    function replyCheck() {
      let content = $("#content").val();
      if(content.trim() == "") {
        alert("댓글을 입력하세요");
        return false;
      }
      let query = {
        boardIdx: ${vo.idx},
        mid: '${sMid}',
        nickName: '${sNickName}',
        price: '${pageContext.request.remoteAddr}',
        content: content
      }
      
      $.ajax({
        url: "BoardReplyInput.bo",
        type: "post",
        data: query,
        success: function(res) {
          if(res != "0") {
            alert("댓글이 입력되었습니다.");
            location.reload();
          } else {
            alert("댓글 입력 실패~~");
          }
        },
        error: function() {
          alert("전송 오류!");
        }
      });
    }
    
    function replyDelete(idx) {
      let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        url: "BoardReplyDelete.bo",
        type: "post",
        data: { idx: idx },
        success: function(res) {
          if(res != "0") {
            alert("댓글이 삭제되었습니다.");
            location.reload();
          } else {
            alert("삭제 실패~~");
          }
        },
        error: function() {
          alert("전송 오류!");
        }
      });
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<div class="container mt-5">
  <h2 class="text-center mb-4">글 내 용 보 기</h2>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.wDate, 0, 16)}</td>
    </tr>
    <tr>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
      <th>가격</th>
      <td>${vo.price}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">
        ${vo.title}
        (<a href="javascript:goodCheck()" class="text-danger">❤</a> : ${vo.good}) /
        <a href="javascript:goodCheckPlus()" class="text-success"><i class="fa-regular fa-thumbs-up"></i></a> &nbsp;
        <a href="javascript:goodCheckMinus()" class="text-danger"><i class="fa-regular fa-thumbs-down"></i></a> /
        (<a href="javascript:goodCheck2()" class="text-primary" style="font-size: 1.5rem;">♥</a> : ${vo.good})
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" class="content-cell">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4">
        <div class="row actions">
          <div class="col">
            <hr/>
            <!-- 자료실에 등록된 자료가 사진이라면, 아래쪽에 모두 보여주기 -->
            <div class="text-center">
				    <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
						<c:forEach var="fSName" items="${fSNames}" varStatus="st">
							${fNames[st.index]}<br/>
							<c:set var="len" value="${fn:length(fSName)}"/>
						  <c:set var="ext" value="${fn:substring(fSName, len-3, len)}"/>
						  <c:set var="extLower" value="${fn:toLowerCase(ext)}"/>
							<c:if test="${extLower == 'jpg' || extLower == 'gif' || extLower == 'png'}">
				        <img src="${ctp}/images/member/${fSName}" width="50%" />
				      </c:if>
				      <hr/>
				    </c:forEach>
				  </div>
          </div>
          <div class="col text-right">
            <c:if test="${sessionScope.sMid eq vo.mid || sLevel == 0}">
              <a href="${ctp}/BoardUpdate.bo?idx=${vo.idx}" class="btn btn-primary btn-sm">수정</a>
              <button onclick="boardDelete()" class="btn btn-danger btn-sm">삭제</button>
            </c:if>
            <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#exampleModal">신고</button>
            <a href="${ctp}/BoardList.bo" class="btn btn-info btn-sm">목록</a>
          </div>
        </div>
      </td>
    </tr>
  </table>

  <div class="row">
    <div class="col">
      <h4 class="mt-4 mb-3">댓글</h4>
      <table class="table table-hover">
        <tbody>
          <c:forEach var="reply" items="${replyVos}">
            <tr>
              <td>${reply.nickName}</td>
              <td>${fn:replace(reply.content, newLine, '<br>')}</td>
              <td>${fn:substring(reply.wDate, 0, 16)}</td>
              <td>
                <c:if test="${sessionScope.sMid eq reply.mid}">
                  <button onclick="replyDelete(${reply.idx})" class="btn btn-danger btn-sm">삭제</button>
                </c:if>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty replyVos}">
            <tr>
              <td colspan="4" class="text-center text-danger">댓글이 없습니다</td>
            </tr>
          </c:if>
          <tr>
            <td colspan="4" class="text-center">
              <textarea id="content" class="form-control" rows="3" placeholder="댓글을 입력하세요"></textarea>
              <button onclick="replyCheck()" class="btn btn-primary mt-2">댓글입력</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- 신고 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">신고하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form name="modalForm">
        <div class="modal-body">
          <div class="form-check">
            <input class="form-check-input" type="radio" name="complaint" value="광고글">
            <label class="form-check-label">광고글</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="complaint" value="음란글">
            <label class="form-check-label">음란글</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="complaint" value="욕설글">
            <label class="form-check-label">욕설글</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="complaint" value="사기">
            <label class="form-check-label">사기</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="complaint" value="사기">
            <label class="form-check-label">도배</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="complaint" value="기타" onclick="etcShow()">
            <label class="form-check-label">기타</label>
          </div>
          <textarea id="complaintTxt" class="form-control mt-2" rows="3" style="display:none;" placeholder="기타 사유 입력"></textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
          <button type="button" onclick="complaintCheck()" class="btn btn-primary">전송</button>
        </div>
      </form>
    </div>
  </div>
</div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
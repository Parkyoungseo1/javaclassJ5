<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원 가입</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
    body {
      background-color: #f8f9fa;
    }
    .container {
      max-width: 600px;
      margin-top: 50px;
    }
    .form-control:focus {
      box-shadow: none;
    }
    .btn-custom {
      background-color: #007bff;
      color: #fff;
      border-radius: 50px;
      transition: all 0.3s;
    }
    .btn-custom:hover {
      background-color: #0056b3;
    }
    .form-group img {
      display: none;
      margin-top: 10px;
    }
  </style>
  <script>
    'use strict';

    let idCheckSw = 0;
    let nickCheckSw = 0;

    function fCheck() {
      // 유효성 검사
      let regMid = /^[a-zA-Z0-9_]{4,20}$/;
      let regNickName = /^[가-힣0-9_]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;

      let mid = myform.mid.value.trim();
      let pwd = myform.pwd.value.trim();
      let nickName = myform.nickName.value.trim();
      let name = myform.name.value.trim();
      let email1 = myform.email1.value.trim();
      let email2 = myform.email2.value;
      let email = email1 + "@" + email2;
      let tel1 = myform.tel1.value;
      let tel2 = myform.tel2.value.trim();
      let tel3 = myform.tel3.value.trim();
      let tel = `${tel1}-${tel2}-${tel3}`;
      let postcode = myform.postcode.value.trim();
      let roadAddress = myform.roadAddress.value.trim();
      let detailAddress = myform.detailAddress.value.trim();
      let extraAddress = myform.extraAddress.value.trim();
      let address = `${postcode} / ${roadAddress} / ${detailAddress} / ${extraAddress}`;

      if (!regMid.test(mid)) {
        alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
        myform.mid.focus();
        return false;
      } else if (pwd.length < 4 || pwd.length > 20) {
        alert("비밀번호는 4~20 자리로 작성해주세요.");
        myform.pwd.focus();
        return false;
      } else if (!regNickName.test(nickName)) {
        alert("닉네임은 한글, 숫자, 언더바(_)만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      } else if (!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }

      let fName = document.getElementById("file").value;
      if (fName.trim() != "") {
        let ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
        let maxSize = 1024 * 1024 * 5;
        let fileSize = document.getElementById("file").files[0].size;

        if (!['jpg', 'gif', 'png'].includes(ext)) {
          alert("그림파일만 업로드 가능합니다.");
          return false;
        } else if (fileSize > maxSize) {
          alert("업로드할 파일의 최대용량은 5MByte입니다.");
          return false;
        }
      }

      if (idCheckSw == 0) {
        alert("아이디 중복체크버튼을 눌러주세요");
        document.getElementById("midBtn").focus();
        return false;
      }
      if (nickCheckSw == 0) {
        alert("닉네임 중복체크버튼을 눌러주세요");
        document.getElementById("nickNameBtn").focus();
        return false;
      }

      myform.email.value = email;
      myform.tel.value = tel;
      myform.address.value = address;

      myform.submit();
    }

    function idCheck() {
      let mid = myform.mid.value.trim();
      if (mid == "") {
        alert("아이디를 입력하세요!");
        myform.mid.focus();
        return;
      }
      idCheckSw = 1;
      $.ajax({
        url: "${ctp}/MemberIdCheck.mem",
        type: "get",
        data: { mid: mid },
        success: function(res) {
          if (res != '0') {
            alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
            myform.mid.focus();
          } else {
            alert("사용 가능한 아이디 입니다.");
          }
        },
        error: function() {
          alert("전송 오류!");
        }
      });
    }

    function nickCheck() {
      let nickName = myform.nickName.value.trim();
      if (nickName == "") {
        alert("닉네임을 입력하세요!");
        myform.nickName.focus();
        return;
      }
      nickCheckSw = 1;
      $.ajax({
        url: "${ctp}/MemberNickCheck.mem",
        type: "get",
        data: { nickName: nickName },
        success: function(res) {
          if (res != '0') {
            alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
            myform.nickName.focus();
          } else {
            alert("사용 가능한 닉네임 입니다.");
          }
        },
        error: function() {
          alert("전송 오류!");
        }
      });
    }

    $(function() {
      $("#mid").on("blur", function() {
        idCheckSw = 0;
      });

      $("#nickName").on("blur", function() {
        nickCheckSw = 0;
      });

      $("#file").on("change", function() {
        let reader = new FileReader();
        reader.onload = function(e) {
          $('#photoDemo').attr('src', e.target.result).show();
        }
        reader.readAsDataURL(this.files[0]);
      });
    });

    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          document.getElementById('postcode').value = data.zonecode;
          document.getElementById('roadAddress').value = data.roadAddress;
          document.getElementById('detailAddress').focus();
        }
      }).open();
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<div class="container">
  <form name="myform" method="post" action="${ctp}/MemberJoinOk.mem" class="border p-4 bg-white rounded shadow-sm" enctype="multipart/form-data">
    <h2 class="mb-4">회원 가입</h2>
    <div class="form-group">
      <label for="mid">아이디</label>
      <div class="input-group">
        <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요" required>
        <div class="input-group-append">
          <button type="button" class="btn btn-secondary" id="midBtn" onclick="idCheck()">중복확인</button>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호</label>
      <input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요" required>
    </div>
    <div class="form-group">
      <label for="nickName">닉네임</label>
      <div class="input-group">
        <input type="text" class="form-control" id="nickName" name="nickName" placeholder="닉네임을 입력하세요" required>
        <div class="input-group-append">
          <button type="button" class="btn btn-secondary" id="nickNameBtn" onclick="nickCheck()">중복확인</button>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" name="name" placeholder="성명을 입력하세요" required>
    </div>
    <div class="form-group">
      <label for="email">이메일</label>
      <div class="form-row">
        <div class="col">
          <input type="text" class="form-control" id="email1" name="email1" required>
        </div>
        <div class="col-auto">@</div>
        <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com" selected>naver.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="nate.com">nate.com</option>
            </select>
          </div>
      </div>
    </div>
    <div class="form-group">
      <label for="tel">전화번호</label>
      <div class="form-row">
        <div class="col">
          <select class="form-control" id="tel1" name="tel1" required>
            <option value="010">010</option>
            <option value="011">011</option>
            <option value="016">016</option>
            <option value="017">017</option>
            <option value="018">018</option>
            <option value="019">019</option>
          </select>
        </div>
        <div class="col">
          <input type="text" class="form-control" id="tel2" name="tel2" required>
        </div>
        <div class="col">
          <input type="text" class="form-control" id="tel3" name="tel3" required>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자">여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-2">
        <input type="text" class="form-control" id="postcode" name="postcode" placeholder="우편번호" required>
        <div class="input-group-append">
          <button type="button" class="btn btn-secondary" onclick="execDaumPostcode()">우편번호 검색</button>
        </div>
      </div>
      <input type="text" class="form-control mb-2" id="roadAddress" name="roadAddress" placeholder="도로명 주소" required>
      <input type="text" class="form-control mb-2" id="detailAddress" name="detailAddress" placeholder="상세 주소" required>
      <input type="text" class="form-control" id="extraAddress" name="extraAddress" placeholder="참고 항목">
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="file">프로필 사진</label>
     	<input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
      <div><img id="photoDemo" width="100px"/></div>
    </div>
    <input type="hidden" name="email">
    <input type="hidden" name="tel">
    <input type="hidden" name="address">
    <button type="button" class="btn btn-custom btn-block" onclick="fCheck()">회원 가입</button>
    <button type="reset" class="btn btn-custom btn-block">다시작성</button> &nbsp;
    <button type="button" class="btn btn-custom btn-block" onclick="location.href='${ctp}/MemberLogin.mem';">돌아가기</button>
  </form>
</div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
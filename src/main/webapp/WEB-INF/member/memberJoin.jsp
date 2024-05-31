<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Member Join</title>
  <jsp:include page="/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
    'use strict';

    let idCheckSw = 0;
    let nickCheckSw = 0;

    function fCheck() {
      let regMid = /^[a-zA-Z0-9_]{4,20}$/;
      let regNickName = /^[가-힣0-9_]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;

      let mid = myform.mid.value.trim();
      let pwd = myform.pwd.value.trim();
      let nickName = myform.nickName.value;
      let name = myform.name.value;

      let email1 = myform.email1.value.trim();
      let email2 = myform.email2.value;
      let email = email1 + "@" + email2;

      let tel1 = myform.tel1.value;
      let tel2 = myform.tel2.value.trim();
      let tel3 = myform.tel3.value.trim();
      let tel = tel1 + "-" + tel2 + "-" + tel3;

      let postcode = myform.postcode.value + " ";
      let roadAddress = myform.roadAddress.value + " ";
      let detailAddress = myform.detailAddress.value + " ";
      let extraAddress = myform.extraAddress.value + " ";
      let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;

      if (!regMid.test(mid)) {
        alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
        myform.mid.focus();
        return false;
      } else if (pwd.length < 4 || pwd.length > 20) {
        alert("비밀번호는 4~20 자리로 작성해주세요.");
        myform.pwd.focus();
        return false;
      } else if (!regNickName.test(nickName)) {
        alert("닉네임은 한글, 숫자, 밑줄만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      } else if (!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }

      if (tel2 === "" || tel3 === "") {
        tel2 = " ";
        tel3 = " ";
        tel = tel1 + "-" + tel2 + "-" + tel3;
      }

      let fName = document.getElementById("file").value;
      if (fName.trim() !== "") {
        let ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
        let maxSize = 1024 * 1024 * 5;
        let fileSize = document.getElementById("file").files[0].size;

        if (ext !== 'jpg' && ext !== 'gif' && ext !== 'png') {
          alert("그림파일만 업로드 가능합니다.");
          return false;
        } else if (fileSize > maxSize) {
          alert("업로드할 파일의 최대용량은 5MByte입니다.");
          return false;
        }
      } else return false;

      if (idCheckSw === 0) {
        alert("아이디 중복체크버튼을 눌러주세요");
        document.getElementById("midBtn").focus();
        return false;
      } else if (nickCheckSw === 0) {
        alert("닉네임 중복체크버튼을 눌러주세요");
        document.getElementById("nickNameBtn").focus();
        return false;
      } else {
        myform.email.value = email;
        myform.tel.value = tel;
        myform.address.value = address;

        myform.submit();
      }
    }

    function idCheck() {
      let mid = myform.mid.value.trim();

      if (mid === "") {
        alert("아이디를 입력하세요!");
        myform.mid.focus();
      } else {
        idCheckSw = 1;

        $.ajax({
          url: "${ctp}/MemberIdCheck.mem",
          type: "get",
          data: { mid: mid },
          success: function (res) {
            if (res !== '0') {
              alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
              myform.mid.focus();
            } else alert("사용 가능한 아이디 입니다.");
          },
          error: function () {
            alert("전송 오류!");
          }
        });
      }
    }

    function nickCheck() {
      let nickName = myform.nickName.value.trim();

      if (nickName === "") {
        alert("닉네임을 입력하세요!");
        myform.nickName.focus();
      } else {
        nickCheckSw = 1;

        $.ajax({
          url: "${ctp}/MemberNickCheck.mem",
          type: "get",
          data: { nickName: nickName },
          success: function (res) {
            if (res !== '0') {
              alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
              myform.nickName.focus();
            } else alert("사용 가능한 닉네임 입니다.");
          },
          error: function () {
            alert("전송 오류!");
          }
        });
      }
    }

    $(function () {
      $("#mid").on("blur", function () {
        idCheckSw = 0;
      });

      $("#nickName").on("blur", function () {
        nickCheckSw = 0;
      });
    });

    function imgCheck(e) {
      if (e.files && e.files[0]) {
        let reader = new FileReader();
        reader.onload = function (e) {
          document.getElementById("photoDemo").src = e.target.result;
        }
        reader.readAsDataURL(e.files[0]);
      }
    }
  </script>
  <style>
    body {
      background: #f8f9fa;
      padding-top: 56px;
    }

    .container {
      max-width: 700px;
      padding: 15px;
      border-radius: 10px;
      box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
      background: white;
    }

    .form-group label {
      font-weight: bold;
    }

    .form-group input,
    .form-group textarea,
    .form-group select {
      border-radius: 5px;
    }

    #photoDemo {
      margin-top: 10px;
      max-width: 100px;
      max-height: 100px;
      border-radius: 50%;
      object-fit: cover;
    }

    .btn {
      border-radius: 5px;
    }

    .input-group-text {
      background: #6c757d;
      color: white;
      border-radius: 0 5px 5px 0;
    }

    .input-group .form-control {
      border-radius: 5px 0 0 5px;
    }

    .input-group-append select {
      border-radius: 0 5px 5px 0;
    }
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/MemberJoinOk.mem" class="was-validated" enctype="multipart/form-data">
    <h2 class="text-center mb-4">회원가입</h2>
    <div class="form-group">
      <label for="mid">아이디</label>
      <div class="input-group">
        <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
        <div class="input-group-append">
          <button type="button" class="btn btn-secondary" id="midBtn" onclick="idCheck()">중복체크</button>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
      <label for="nickName">닉네임</label>
      <div class="input-group">
        <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
        <div class="input-group-append">
          <button type="button" class="btn btn-secondary" id="nickNameBtn" onclick="nickCheck()">중복체크</button>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email1">이메일</label>
      <div class="input-group">
        <input type="text" class="form-control" id="email1" placeholder="Email을 입력하세요." name="email1" required />
        <div class="input-group-append">
          <select name="email2" class="custom-select">
            <option value="naver.com" selected>naver.com</option>
            <option value="hanmail.net">hanmail.net</option>
            <option value="hotmail.com">hotmail.com</option>
            <option value="gmail.com">gmail.com</option>
            <option value="nate.com">nate.com</option>
            <option value="yahoo.com">yahoo.com</option>
          </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label>성별</label>
      <div class="form-check form-check-inline">
        <input type="radio" class="form-check-input" name="gender" value="남자" checked>
        <label class="form-check-label" for="genderMale">남자</label>
      </div>
      <div class="form-check form-check-inline">
        <input type="radio" class="form-check-input" name="gender" value="여자">
        <label class="form-check-label" for="genderFemale">여자</label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
    </div>
    <div class="form-group">
      <label for="tel1">전화번호</label>
      <div class="input-group">
        <select name="tel1" class="custom-select">
          <option value="010" selected>010</option>
          <option value="02">서울</option>
          <option value="031">경기</option>
          <option value="032">인천</option>
          <option value="041">충남</option>
          <option value="042">대전</option>
          <option value="043">충북</option>
          <option value="051">부산</option>
          <option value="052">울산</option>
          <option value="061">전북</option>
          <option value="062">광주</option>
        </select>
        <input type="text" name="tel2" class="form-control"/>-
        <input type="text" name="tel3" class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <button type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control">
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
    </div>
    <div class="form-group">
      <label>정보공개</label>
      <div class="form-check form-check-inline">
        <input type="radio" class="form-check-input" name="userInfor" value="공개" checked>
        <label class="form-check-label" for="public">공개</label>
      </div>
      <div class="form-check form-check-inline">
        <input type="radio" class="form-check-input" name="userInfor" value="비공개">
        <label class="form-check-label" for="private">비공개</label>
      </div>
    </div>
    <div class="form-group">
      <label for="file">회원 사진 (파일용량: 2MByte이내)</label>
      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file">
      <img id="photoDemo" alt="사진 미리보기"/>
    </div>
    <div class="form-group text-center">
      <button type="button" class="btn btn-primary" onclick="fCheck()">회원가입</button>
      <button type="reset" class="btn btn-secondary">다시작성</button>
      <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/MemberLogin.mem';">돌아가기</button>
    </div>

    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
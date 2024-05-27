<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
  int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
  pageContext.setAttribute("level", level);
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <%-- <a class="navbar-brand" href="<%=request.getContextPath()%>/">Home</a> --%>
  <!-- <a class="navbar-brand" href="http://192.168.50.68:9090/javaclass5">Home</a> -->
  <a class="navbar-brand" href="http://192.168.50.68:9090/javaclassJ5/Main">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="${ctp}/GuestList">중고거래 게시판</a>
      </li>
			<c:if test="${level <= 4}">
	      <li class="nav-item">
	        <a class="nav-link" href="BoardList.bo">중고거래 게시판</a>
	      </li>
	    </c:if>  
      <c:if test="${level <= 4 && (level > 1 || level == 0)}">
	      <li class="nav-item">
	        <a class="nav-link" href="#">PDS</a>
	      </li>    
	     </c:if>
	     <c:if test="${level <= 4}">
		      <li class="nav-item mr-2">
					  <div class="dropdown">
					    <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">MyPage</button>
					    <div class="dropdown-menu">
					      <a class="dropdown-item" href="MemberMain.mem">회원메인창</a>
					      <c:if test="${level <= 4 && (level > 1 || level == 0)}">
						      <a class="dropdown-item" href="#">일정관리</a>
						      <a class="dropdown-item" href="#">메세지관리</a>
						      <a class="dropdown-item" href="MemberList.mem">회원리스트</a>
					      </c:if>
					       <a class="dropdown-item" href="MemberPwdCheck.mem">회원정보수정</a>
				    		 <a class="dropdown-item" href="MemberDelete.mem">회원탈퇴</a>
					      <c:if test="${sLevel == 0}"><a class="dropdown-item" href="AdminMain.ad">관리자메뉴</a></c:if>
					    </div>
					  </div>
		      </li>
	      </c:if>
      <li class="nav-item">
				<c:if test="${level <= 4}"><a class="nav-link" href="${ctp}/MemberLogout.mem">Logout</a></c:if>
        <c:if test="${level > 4}"><a class="nav-link" href="${ctp}/MemberLogin.mem">로그인</a></c:if>
      </li>    
      <li class="nav-item">
        <c:if test="${level > 4}"><a class="nav-link" href="${ctp}/MemberJoin.mem">Join</a></c:if>
      </li>    
    </ul>
  </div>  
</nav>
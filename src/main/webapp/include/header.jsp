<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<div id="header" class="jumbotron text-center" style="margin-bottom:0; background-image:url('${ctp}/images/member/junggotitle.png'); background-size:100% 100%; background-position:center; height:300px; padding:100px 0;">
  <h1><b><font color="#EFAA52" size=15>커넥션 중고마켓</font><b></h1>
  
  <p></p>
</div>
<script>
	$(function(){
		$("#header").on("click", function(){
			location.href = "http://192.168.50.68:9090/javaclassJ5/Main";
		});
	});
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<div id="header" class="jumbotron text-center" style="margin-bottom:0; background-image:url('${pageContext.request.contextPath}/images/member/pool.png');">
  <h1>없는게 영서</h1>
  <h1>!</h1>
  <h1>!</h1>
  
  <p></p>
</div>
<script>
	$(function(){
		$("#header").on("click", function(){
			location.href = "http://192.168.50.68:9090/javaclassJ5/Main";
		});
	});
</script>
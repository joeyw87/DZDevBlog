<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	puddready(function() {
		$("#btn_Login").click(function () { fncMoveLoginPage(); });
	});
	
	/****************************************************
 	 로그인 버튼 클릭
  	****************************************************/
	function fncMoveLoginPage() {
		location.href = "/user/login.do";
	}
</script>

<div>
	<h2>고객지원센터 회원가입 완료.</h2>
	<h3>고객지원센터 회원가입이 완료되었습니다.</h3>
	<h3>로그인 후 서비스를 사용하실 수 있습니다.</h3>
	<input type="button" id="btn_Login" value="로그인">
</div>


<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">


	var userLoginId = "${showLoginId}";
	
	puddready(function() {
		
		$("#btn_Login").click(function () { fncMoveLoginPage(); });
		$("#btn_SearchPasswd").click(function () { fncSearchPasswd(); });
		
		fncControlInit();
	});
	
	// 비밀번호 찾기
	function fncSearchPasswd() {
		location.href = "/user/login/searchPasswd.do";
	}
	
	// 로그인 화면 가기
	function fncMoveLoginPage() {
		location.href = "/user/login.do";
	}
	
	function fncControlInit() {
		// 엔터 검색
		$("input[type=text], input[type=password]").keydown(function(event) {
			if (event.keyCode == 13) {
				event.returnValue = false;
				event.cancelBubble = true;
				fncActionLogin();
			}
		});	
		
		
		console.log("userLoginId="+userLoginId);
		$("#span_ShowUserId").text(userLoginId);	
	}
	
</script>

<div>
	<form id="login-form" method="post">
		<div>아이디찾기</div>
		<div>고객님의 정보와 일치하는 아이디입니다.</div>
		<table>
			<tr>
				<td>
					<label class="legend">회원님의 아이디는 </label>
					<span id="span_ShowUserId"></span>
					<label class="legend">입니다. </label>
				</td>
			<tr>
			<tr>
				<td><input type="button" id="btn_Login" value="로그인"></td>
			<tr>
			<tr>
				<td><input type="button" id="btn_SearchPasswd" value="비밀번호찾기"></td>
			<tr>
		</table>
	</form>
</div>


<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	puddready(function() {
		$("#btn_Login").click(function () { fncActionLogin(); });
		$("#btn_SearchId").click(function () { fncSearchId(); });
		$("#btn_SearchPasswd").click(function () { fncSearchPasswd(); });
		
		fncControlInit();
	});
	
	// 아이디 찾기
	function fncSearchId() {
		location.href = "/user/login/searchId.do";
	}
	
	// 비밀번호 찾기
	function fncSearchPasswd() {
		location.href = "/user/login/searchPasswd.do";
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
	}
	
	/****************************************************
 	 로그인 Event
  	****************************************************/
	function fncActionLogin() {
		var param = {};
		
		param.loginId = $("#txt_UserId").val();
		param.loginPsswd = $("#txt_PassWord").val();
		
		$.ajax({
			type : "post",
			contentType: "application/json; charset=utf-8",
			url : '<c:url value="/user/login/actionLogin.do" />',
			datatype : 'json',
			async : false,
			data : JSON.stringify(param),
			success : function(res) {
				
				console.log(res.status);
				console.log(res.role);
				
				if (res.status == "fail") {
					alert('아이디나 비밀번호가 맞지 않습니다.');
				} else {
					// 관리자, 사용자에 따라 노출되는 화면 변경이 필요할 것으로 판단 됨. 
					// 현재는 사용자 전용임.
					location.href = "/user/dashboard.do";
				}
			},
			error : function(error) {
				alert("오류 발생" + error);
			}
		});
	}
</script>

<div>
	<form id="login-form" method="post">
		<table>
			<tr>
				<td><label class="legend">아이디</label></td>
				<td colspan="2"><input type="text" id="txt_UserId"></td>
			<tr>
			<tr>
				<td><label class="legend">패스워드</label></td>
				<td><input type="password" id="txt_PassWord"></td>
				<td><input type="button" id="btn_Login" value="로그인"></td>
			<tr>
			<tr>
				<td><input type="button" id="btn_SearchId" value="아이디찾기"></td>
				<td><input type="button" id="btn_SearchPasswd" value="비밀번호찾기"></td>
			<tr>
		</table>
	</form>
</div>


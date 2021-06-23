<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	puddready(function() {
		$("#btn_Login").click(function () { fncCheckAuthCode(); });
		$("#btn_CheckAuthCode").click(function () { fncCheckAuthCode(); });
		$("#btn_SendAuthCode").click(function () { fncSendAuthCode(); });
		$("#btn_SearchId").click(function () { fncSearchId(); });
		
		fncControlInit();
	});
	
	// 아이디 찾기
	function fncSearchId() {
		location.href = "/user/login/searchId.do";
	}
	
	// 초기화 
	function fncControlInit() {
		// 엔터 검색
		$("input[type=text], input[type=password]").keydown(function(event) {
			if (event.keyCode == 13) {
				event.returnValue = false;
				event.cancelBubble = true;
				fncCheckAuthCode();
			}
		});	
	}
	
	/****************************************************
	 인증번호 전송
 	****************************************************/
	function fncSendAuthCode() {
		
		var param = {};
		
		param.userName = $("#txt_UserName").val();
		param.loginId = $("#txt_LoginId").val();
		param.emailAddr = $("#txt_Email").val();
		console.log(param);
		
		$.ajax({
			type : "post",
			contentType: "application/json; charset=utf-8",
			url : '<c:url value="/user/login/checkUserInfo.do" />',
			datatype : 'json',
			async : false,
			data : JSON.stringify(param),
			success : function(res) {

				if (res == "fail") {
					alert('이름/이메일을 확인 하세요.')
				} else {
					alert('작성한 이메일로 인증번호를 전송하였습니다.');
				}
			},
			error : function(error) {
				alert("오류 발생" + error);
			}
		});
		
	}
	
	
	/****************************************************
 	 인증번호 확인 
  	****************************************************/
	function fncCheckAuthCode() {
		var param = {};
		
		param.userName = $("#txt_UserName").val();
		param.loginId = $("#txt_LoginId").val();
		param.emailAddr = $("#txt_Email").val();
		param.authCode = $("#txt_AuthCode").val();
		param.type = "pass";
		
		$.ajax({
			type : "post",
			contentType: "application/json; charset=utf-8",
			url : '<c:url value="/user/login/checkAuthInfo.do" />',
			datatype : 'json',
			async : true,
			data : JSON.stringify(param),
			success : function(res) {
				
				if (res.returnValue == "1") {
					alert('인증번호를 확인 하세요.')
				}

				if (res.returnValue == "2") {
					alert('이름/이메일을 확인 하세요.')
				}
				
				if (res.returnValue == "ok") {
					alert('인증에 성공하였습니다.');
					location.href = "/user/login/setNewPasswordView.do?userSeq=" + res.userSeq;
				}
				
				if (res.returnValue == "expired") {
					alert("인증번호가 만료되었습니다. 다시 인증하여 주십시오.")
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
		<h2>아이디찾기</h2>
		<h3>회원님의 소중한 개인정보 보호를 위하여 본인확인이 필요합니다. 본인확인 방법을 선택해주세요.</h3>
		<table>
			<tr>
				<td><label class="">이름</label></td>
				<td colspan="2"><input type="text" id="txt_UserName"></td>
			<tr>
			<tr>
				<td><label class="">아이디</label></td>
				<td><input type="text" id="txt_LoginId"></td>
			<tr>
			<tr>
				<td><label class="">이메일</label></td>
				<td><input type="text" id="txt_Email"></td>
				<td><input type="button" id="btn_SendAuthCode" value="인증번호 전송"></td>
			<tr>
			<tr>
				<td><label class="">인증번호</label></td>
				<td><input type="text" id="txt_AuthCode"></td>
			<tr>
			<tr>
				<td><input type="button" id="btn_CheckAuthCode" value="인증번호 확인"></td>
			<tr>
		</table>
		<input type="button" id="btn_SearchId" value="아이디 찾기">
	</form>
</div>

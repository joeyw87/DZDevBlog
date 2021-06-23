<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">

	var isCheckIdValid = false;
	var userSeq = "${userSeq}";
	
	puddready(function() {
		$("#btn_SetNewPassword").click(function () { fncSetNewPassword(); });
		
		fncControlInit();
	});
	
	// 아이디 찾기
	function fncSearchId() {
		location.href = "/user/login/searchId.do";
	}
	
	// 아이디 찾기
	function fncMoveLoginPage() {
		location.href = "/user/login.do";
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
		
		// 비밀번호 일치 여부
		$('#txt_Password').keyup(function() {
			if ($("#txt_Password").val() == "" && $("#txt_RePassword").val() == "") {
				$('font[name=check]').text('');
			}
			if ($('#txt_Password').val() != $('#txt_RePassword').val()) {
				$('font[name=check]').text('');
				$('font[name=check]').html("비밀번호 불일치");
				isCheckIdValid = false;
			} else {
				$('font[name=check]').text('');
				$('font[name=check]').html("비밀번호 일치");
				isCheckIdValid = true;
			}
		});

		$('#txt_RePassword').keyup(function() {
			
			if ($("#txt_Password").val() == "" && $("#txt_RePassword").val() == "") {
				$('font[name=check]').text('');
			}
			
			if ($('#txt_Password').val() != $('#txt_RePassword').val()) {
				$('font[name=check]').text('');
				$('font[name=check]').html("비밀번호 불일치");
				isCheckIdValid = false;
			} else {
				$('font[name=check]').text('');
				$('font[name=check]').html("비밀번호 일치");
				isCheckIdValid = true;
			}
			
		
		});
	
		
	}
	
	/****************************************************
	 비밀번호 변경
 	****************************************************/
	function fncSetNewPassword() {
		
		var param = {};
		param.loginPsswd = $("#txt_Password").val();
		param.userSeq = userSeq;
		
		console.log("isCheckIdValid=" + isCheckIdValid);
		
		if (!isCheckIdValid) {
			alert('비밀번호가 일치하지 않습니다. 확인해 주세요.');
			return;
		}
		
		$.ajax({
			type : "post",
			contentType : "application/json; charset=utf-8",
			url : '<c:url value="/user/login/setNewPassword.do" />',
			dataType : 'json',
			async : false,
			data : JSON.stringify(param),
			success : function(res) {
					
				if (res.resultCode == "ok") {
					alert("비밀번호가 변경되었습니다. 다시 로그인 해주세요.");
					location.href = "/user/login.do";
				} else {
					alert("오류가 발생하였습니다.");
				}
				
			},
			error : function(error) {
				alert('오류발생:' + error);				
			}
			
		});
		
	}
	

</script>

<div>
	<form id="login-form" method="post">
		<h2>비밀번호 찾기</h2>
		<h3>변경하실 번호를 입력해 주시기 바랍니다.</h3>
		<table>

			<tr>
				<td><label class="">비밀번호</label></td>
				<td><input type="text" id="txt_Password"></td>
				<td><label class="">*특수문자 영문, 숫자를 포함하여 8자 이상(허용특문:!@#$%^&*)</label></td>
			<tr>
			<tr>
				<td><label class="">비밀번호 확인</label></td>
				<td><input type="text" id="txt_RePassword"></td>
				<td><font name="check" size="2" color="red"></font></td>
			<tr>
		</table>
		<input type="button" id="btn_SetNewPassword" value="비밀번호 변경">
	</form>
</div>

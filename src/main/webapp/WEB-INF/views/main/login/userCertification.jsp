<!-- /**
 * 헬프데스크 사용자 패스워드 인증 페이지
 * jsp명: userCertification.jsp  
 * 작성자: 황윤상
 * 수정일자: 2019.08.28 
 */
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonJquery.js"></script>
<script type="text/javascript">
	// 페이지 로드 
	puddready(function() {
		// 사용자 기본정보 초기 바인딩
		fncInitBinding();
		// 버튼이벤트
		$("#btnCheck").click(function () {	fncCheckPwd(); });
		// 포커스
		$("#txt_pwd").focus();
		// 엔터키
		$("#txt_pwd").keydown(function(event) {
			if (event.keyCode == 13) {
				fncCheckPwd();
			}
		});
		
	});
	// 초기바인딩
	function fncInitBinding() {
		$("#lab_userId").text("${id}");
	}
	
	// 사용자 패스워드 인증
	function fncCheckPwd() {
		var param = {};
		var targetUrl = "${target}";
		
		param.loginId = "${id}";
		param.loginPsswd = $("#txt_pwd").val();
		
		$.ajax({
			type : "post",
			contentType: "application/json; charset=utf-8",
			url : '<c:url value="/user/login/actionLogin.do" />',
			datatype : 'json',
			async : false,
			data : JSON.stringify(param),
			success : function(res) {
				console.log(res.status);
				if (res.status == "fail") {
					alert('비밀번호를 확인해주세요');
					$("#txt_pwd").focus();
				} else {
					alert('확인되었습니다.\r\n회원정보 수정페이지로 이동합니다.');
					location.href = targetUrl;
				}
			},
			error : function(error) {
				alert("오류 발생" + error);
			}
		});
	}
</script>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id="certificationForm" method="post" onsubmit="return false;">
<div>* 아이디 : <label id="lab_userId"></label></div>
<p>
<div>* 비밀번호 :<input type="password"  id="txt_pwd" name="txt_pwd"></input></div>
 <p>
 <div><input type="button" id="btnCheck" name="btnCheck" value="확인"></div>
 </form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags" %>
<%
/**
 * @title 커뮤니티 게시판 글쓰기 페이지
 * @author 조영욱
 * @since 2020.09.10
 * @version 1.0
 * @dscription 
 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- include summernote css -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/summernote/summernote.min.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.css">

<!-- include summernote js -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/summernote/summernote.min.js"></script> --%>
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
	
	
<script type="text/javascript">
	$(document).ready(function() {
		
		$('#summernote').summernote({
			height : 300,		//에디터 높이
			minHeight : null,	//최소 높이
			maxHeight : null,	//최대 높이
			lang : 'ko-KR',
			onImageUpload : function(files, editor, welEditable) {
				sendFile(files[0], editor, welEditable);
			}
		});
		
		//$('.summernote').summernote('insertText', "내용 입력");
		
	});
	

	//**************************
	// 글쓰기
	//**************************
	function fncConfirm() {
		
		//입력 체크
		var sub = $("#subject").val();
		var con = $('#summernote').summernote('code');
		if(sub == ""){
			alert('제목을 입력해주세요.');
			return;
		}
		if(con == "" || con == "<p><br></p>"){
			alert('내용을 입력해주세요.');
			return;
		}
		
		//파라미터 정의
		var boardParam = {};
		boardParam.subject = sub;
		boardParam.content = con;
		boardParam.type = "A";
		
		$.ajax({
			type : 'post',
			contentType : "application/json; charset=utf-8",
			url : '<c:url value="/board/community/insertCommunityData.do" />',
			datatype : 'json',
			async : false,
			data : JSON.stringify(boardParam),
			success : function(data) {
				if(data.resultCode != "SUCCESS"){
					alert('저장에 실패하였습니다.');
					return;
				}
				alert('저장하였습니다.');
				fncMoveList();
			},
			error : function(data) {
				alert('서버 저장 실패.');
				console.log("error:::" + data);
			}
		});
	}

	function fncMoveList() {
		location.href = '<c:url value="/board/community/communityListView.do"/>';
	}
	
</script>
</head>

<h1 class="h3 mb-2 text-gray-800 sub-title">커뮤니티 글쓰기</h1>
<p class="mb-4"></p>

<div class="card shadow mb-4">
	<!-- <div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary"></h6>
	</div> -->
	<div class="card-body">
		<div class="table-responsive">
			<div class="card-body">
				<div class="form-group">
					<label for="subject">제목</label> 
					<input type="text" name="subject" id="subject" class="form-control bg-light border-0 small" placeholder="제목을 입력하세요"><br />
				</div>
				<div class="form-group">
					<label for="content">내용 </label>
					<!-- 에디터 영역 -->
					<div id="summernote"></div>
				</div>
			</div>
		</div>
		<div align="center">
			<input type="button" class="btn btn-primary" value="등록"	onclick="javascript:fncConfirm()" /> 
			<input type="button" class="btn btn-primary" value="취소" onclick="javascript:fncMoveList()" />
		</div>
	</div>
</div>
<!-- /.container-fluid -->
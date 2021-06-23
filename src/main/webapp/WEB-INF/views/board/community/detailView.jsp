<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script type="text/javascript">

	$(document).ready(function() {
		
		//getDetailInfo();
	});
	
	
	function getDetailInfo(){
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
	
	
	function fncList() {
		location.href = '<c:url value="/board/community/communityListView.do"/>';
	}

	function fncModify() {
		location.href = '<c:url value="/board/community/boardModify.do"/>';
	}
	
	
</script>

<h1 class="h3 mb-2 text-gray-800 sub-title">커뮤니티 게시판</h1>
<p class="mb-4"></p>

<div class="card shadow mb-4">
	<!-- <div class="card-header py-3">
       	<h6 class="m-0 font-weight-bold text-primary">제목1</h6>
       </div> -->
	<div class="card-body">
		<p class="mb-4">상세 내용입니다 상세내용입니다 상세내용입니다 </p>
		<div class="small mb-3">첨부파일 : 업로드1.jpg</div>
		<div align="center">
			<input type="button" class="btn btn-primary" value="목록" onclick="javascript:fncList()" /> 
			<input type="button" class="btn btn-primary" value="수정" onclick="javascript:fncModify()" />
		</div>
	</div>
</div>
<!-- /.container-fluid -->
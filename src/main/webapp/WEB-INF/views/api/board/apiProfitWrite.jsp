<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('.summernote').summernote({
			height : 300,
			minHeight : null,
			maxHeight : null,
			lang : 'ko-KR',
			onImageUpload : function(files, editor, welEditable) {
				sendFile(files[0], editor, welEditable);
			}
		});
	});
	

	//**************************
	// 글쓰기
	//**************************
	function fncConfirm() {
		var tblParam = {};
		tblParam.subject = $("#subject").val();
		tblParam.content = $('textarea#content').val();    
		tblParam.profit = 'p';
		
		$.ajax({
			type : 'post',
			contentType : "application/json; charset=utf-8",
			url : '<c:url value="/api/board/insertApiProfit.do" />',
			datatype : 'json',
			async : false,
			data : JSON.stringify(tblParam),
			success : function(data) {
				fncList();
			},
			error : function(data) {
				console.log("error:::" + data);
			}
		});
	}

	function fncList() {
		location.href = '<c:url value="/api/board/apiProfitList.do"/>';
	}
</script>

<h1 class="h3 mb-2 text-gray-800">영리 커뮤니티 글쓰기</h1>
<p class="mb-4"></p>

<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary"></h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<div class="card-body">
				<form id="gwForm" name="gwForm" method="post" class="">
					<div class="form-group">
						<label for="subject">제목</label> 
						<input type="text" name="subject" id="subject" class="form-control bg-light border-0 small" placeholder="제목을 입력하세요"><br />
					</div>
					<div class="form-group">
						<label for="content">내용 </label>
						<textarea name="content" id="content" class="summernote" placeholder="내용을 입력하세요"></textarea>
					</div>
				</form>
			</div>
		</div>
		<div align="center">
			<input type="button" class="btn btn-primary" value="등록"
				onclick="javascript:fncConfirm()" /> <input type="button"
				class="btn btn-primary" value="취소" onclick="javascript:fncList()" />
		</div>
	</div>
</div>
<!-- /.container-fluid -->
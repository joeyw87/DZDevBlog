<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script type="text/javascript">
	function fncList() {
		location.href = '<c:url value="/api/board/apiProfitList.do"/>';
	}

	function fncUpdate() {
		location.href = '<c:url value="/api/board/apiProfitWrite.do"/>';
	}
</script>

<h1 class="h3 mb-2 text-gray-800">영리 커뮤니티 상세</h1>
<p class="mb-4"></p>

<div class="card shadow mb-4">
	<div class="card-header py-3">
       	<h6 class="m-0 font-weight-bold text-primary">제목1</h6>
       </div>
	<div class="card-body">
		<p class="mb-4">상세 내용입니다 상세내용입니다 상세내용입니다 </p>
		<div class="small mb-3">첨부파일 : 업로드1.jpg</div>
		<div align="center">
			<input type="button" class="btn btn-primary" value="목록" onclick="javascript:fncList()" /> 
			<input type="button" class="btn btn-primary" value="수정" onclick="javascript:fncUpdate()" />
		</div>
	</div>
</div>
<!-- /.container-fluid -->
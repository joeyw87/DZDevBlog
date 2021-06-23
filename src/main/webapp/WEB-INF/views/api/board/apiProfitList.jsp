<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script type="text/javascript">
	$(document).ready(function() {
		retrieveApiProfitList();
	});
	
	//**************************
	// 목록 조회 
	//**************************
	function retrieveApiProfitList() 
	{
 		 var searchParam  = ""
 		 $('#grid').DataTable({
			"serverSide":  true,  //서버사이드 false 시 js
		    "processing" : true,
		    "pageLength" : 5,
		    "lengthMenu" : [ [ 5, 10, 20, 30, 40, 50], [ 5, 10, 20, 30, 40, 50] ],
		    "searching": false,
		    "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                	fncView(); // 개별 상세페이지 이동
                }));
            },
		    "columns": [
			   	           { data: "seq" },
		                   { data: "subject"},
		                   { data: "content"}
			       	],
	        "ajax" : {
		    	type : 'post',
		        url : '<c:url value="/api/board/retrieveApiProfitList.do" />',
		        datatype : 'json',
		        async : true,
		        data : searchParam,
		        dataSrc : function(data) {
		        	return data.result;
		        }
		    }       	
	     });
	}
	
	
	//**************************
	// 등록 페이지 이동 
	//**************************
	function fncWrite() {
		location.href = '<c:url value="/api/board/apiProfitWrite.do"/>';
	}
	
	
	//**************************
	// 상세페이지 이동 
	//**************************
	function fncView() {
		location.href = '<c:url value="/api/board/apiProfitView.do"/>';
	}
	
</script>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">영리 커뮤니티</h1>
<p class="mb-4">커뮤니티 게시판입니다 </p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
  <div class="card-header py-3">
    	<!-- <h6 class="m-0 font-weight-bold text-primary">DataTables</h6> -->
  </div>
  <div class="card-body">
    <div class="table-responsive">
      	<table class="table table-bordered" id="grid" style="width:100%" >
      		  <colgroup>
						<col width="10%">
						<col width="30%">
						<col width="60%">
			  </colgroup>
	      	  <thead>
	             <tr>
	                 <th>순서</th>
	                 <th>제목</th>
	                 <th>내용</th>
	             </tr>
	          </thead>
    	</table>
    </div>
    <input type="button" class="btn btn-primary" value="글쓰기" onclick="javascript:fncWrite()" />
  </div>
</div>
<!-- /.container-fluid -->
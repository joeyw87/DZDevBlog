<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- 게시판 datatable CSS 리뉴얼 적용 tiles적용 -->
<!-- <link href="/resources/css/renew/renew.css" rel="stylesheet"> -->

<script type="text/javascript">
	$(document).ready(function() {
		getCommunityDataList();
	});
	
	//**************************
	// 목록 조회 
	//**************************
	function getCommunityDataList() {
		var searchParam = {};
		searchParam.ywyw = "";
 		 $('#grid').DataTable({
			"serverSide":  true,  //서버사이드 false 시 js
		    "processing" : true,
		    "pageLength" : 10,
		    "lengthMenu" : [ 5, 10, 20, 30, 40, 50], //표시 건수 
		    "displayLength" : 10, //기본 표시 건수 
		    "searching": false,
		    "ajax" : {
		    	type : 'post',
		        url : '<c:url value="/board/community/getCommunityDataList.do" />',
		        datatype : 'json',
		        async : true,
		        //data : JSON.stringify(searchParam),
		        data : searchParam,
		        dataSrc : function(data) {
		        	if(data.resultCode !="SUCCESS"){
		        		alert("조회 중 에러가 발생하였습니다.");
		        		return;
		        	}
		        	return data.result;
		        }
		    },
		    "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                	fncDetailView(); // 개별 상세페이지 이동
                }));
            },
		    "columns": [
			   	           { data: "seq" },
		                   { data: "subject",
				   	            "render": function(data, type, row){
				   	            	data = data;
				   	                return data;
				   	            }
			   	           },
		                   { data: "createSeq",
				   	            "render": function(data, type, row){
				   	            	if(data == "1"){
				   	            		data = "관리자";
				   	            	}
				   	                return data;
				   	            }},
		                   { data: "viewCnt"},
		                   { data: "createDate"}
			],
		    "language" : { //한글UI 변경
		        "emptyTable": "데이터가 없어요.",
		        "lengthMenu": "페이지당 _MENU_ 개씩 보기",
		        "info": "현재 _START_ - _END_ / _TOTAL_건",
		        "infoEmpty": "데이터 없음",
		        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
		        "search": "에서 검색: ",
		        "zeroRecords": "일치하는 데이터가 없습니다.",
		        "loadingRecords": "로딩중...",
		        "processing": "잠시만 기다려 주세요...",
		        "paginate": {
		            "next": "다음",
		            "previous": "이전"
		        }
		    }
	     });
	}
	
	
	//**************************
	// 등록 페이지 이동 
	//**************************
	function fncWrite() {
		location.href = '<c:url value="/board/community/boardWrite.do"/>';
	}
	
	
	//**************************
	// 상세페이지 이동 
	//**************************
	function fncDetailView() {
		location.href = '<c:url value="/board/community/detailView.do"/>';
	}
	
</script>
</head>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 sub-title">커뮤니티 게시판</h1>
<p class="mb-4">정보 공유 커뮤니티 게시판입니다.</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
  <!-- <div class="card-header py-3">
    	<h6 class="m-0 font-weight-bold text-primary">Community Board</h6>
  </div> -->
  <div class="card-body">
    <div class="table-responsive">
      	<table class="table table-bordered" id="grid" style="width:100%" >
      		  <colgroup>
						<col width="10%">
						<col width="50%">
						<col width="15%">
						<col width="10%">
						<col width="15%">
			  </colgroup>
	      	  <thead>
	             <tr>
	                 <th>번호</th>
	                 <th>제목</th>
	                 <th>작성자</th>
	                 <th>조회</th>
	                 <th>등록일</th>
	             </tr>
	          </thead>
    	</table>
    	
    	<div style="text-align: right;">
    		<input type="button" class="btn btn-primary" value="글쓰기" onclick="javascript:fncWrite()" />
    	</div>
    	
    </div>
    
  </div>
</div>
<!-- /.container-fluid -->
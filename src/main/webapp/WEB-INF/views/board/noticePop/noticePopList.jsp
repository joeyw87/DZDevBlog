<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="now"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMddKKmmss" /></c:set>

<script type="text/javascript">
	puddready(function() {
		$("#btn_Add").click(function () { fncAddNotice(); });
		$("#btn_Delete").click(function () { fncDeleteNotice(); });
		
		fncSearchList();
	});

	/****************************************************
	 공지사항 조회
	****************************************************/
	function fncSearchList(){
		var dataSource = new Pudd.Data.DataSource({
			pageSize : 10, // grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
			serverPaging : false,
			request : {
				url : '<c:url value="/notice/retrieveNoticeList.do" />',
				type : 'post',
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				jsonStringify : true,
				parameterMapping : function(data) {
				}
			},
			result : {
				data : function(response) {
					return response.result.list;
				},
				totalCount : function(response) {
					return response.result.totalCnt;
				},
				error : function(response) {
					alert("error - Pudd.Data.DataSource.read, status code - " + response.status);
				}
			}
		});
		
		var colums  = fnGetColums();
		
		/****************************************************
		 pudding data bindding
		****************************************************/
	   	Pudd("#tGrid").off();
		Pudd("#tGrid").puddGrid({
			dataSource : dataSource,
			scrollable : true,
			height : 450,
			autoScroll : true, // scrollable 값이 true 이고 height 값이 설정된 경우 pager 사용하지 않는 경우 autoScroll - true 설정 권장, 아니면 false 기본값 권장
			pageable : {
    			buttonCount : 10
    			, pageList : [ 10, 20, 30, 40, 50, 100 ]
				//,	showAlways : true	// 기본값 true - data totalCount가 0 이라도 pager 표시함
				// false 설정한 경우는 data totalCount가 0 이면 pager가 표시되지 않음
			},
			columns : colums,
			noDataMessage : {
				message : "데이터가 존재하지 않습니다."
			}
			, progressBar : {
				progressType : "loading",
				attributes : {
					style : "width:70px; height:70px;"
				},
				strokeColor : "#84c9ff", // progress 색상
				strokeWidth : "3px", // progress 두께
				percentText : "loading", // loading 표시 문자열 설정 - progressType loading 인 경우만
				percentTextSize : "12px", // 배경 layer 설정 - progressType loading 인 경우만
				backgroundLayerAttributes : {
					style : "background-color:#fff;filter:alpha(opacity=0); opacity:0; width:100%; height:100%; position:fixed; top:0px; left:0px;"
					}
				}
		});
		
	   /****************************************************
		pudding double click event
		****************************************************/
		/* Pudd("#tGrid").on("gridRowDblClick", function(e) {
			// e.detail 항목으로 customEvent param 전달됨
			var evntVal = e.detail;

			if (!evntVal)
				return;
			if (!evntVal.trObj)
				return;

			// dataSource에서 전달된 row data
			var rowData = evntVal.trObj.rowData;

			// grid 이벤트 관련된 처리부분
			fncDocViewer(rowData.form_id, rowData.doc_id);
		}); */
	}
	
	/****************************************************
	colums 가져오기
	****************************************************/
	var fnGetColums = function(){
		var colums;
		
		colums = [
					{ field : "BOARD_NO", title : "양식key", width : 15, widthUnit : "%", hidden : true },
					{ field : "SJ", title : "제목", width : 15, widthUnit : "%", hidden : true },
		            { field : "CN", title : "내용", width : 15, widthUnit : "%" }, 
		            { field : "DELETE_AT", title : "삭제여부", width : 8, widthUnit : "%" }, 
		            { field : "PRIOR_AT", title : "우선순위", width : 9, widthUnit : "%" } 
    	]
		
		return colums;
	}
	
	/****************************************************
	 공지사항 등록
 	****************************************************/
	function fncAddNotice(){
		
	}
	
	/****************************************************
	 공지사항 삭제
 	****************************************************/
	function fncDeleteNotice(){
	}
	
</script>

<input type="hidden" id="hidIndex"/>

<div id="loadingProgressBar"></div>
	<div class="sub_contents_wrap" style="">
		<!-- 버튼/타이틀 -->
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mb5 mt5">공지사항</p>
			</div>

			<div class="right_div">
				<input type="button" class="puddSetup" id="btn_Add" value="등록" />
				<input type="button" class="puddSetup" id="btn_Delete" value="삭제" />
			</div>
		</div>

		<div id="tGrid"></div>
	</div>
	<!-- / 템플릿 종료 / -->
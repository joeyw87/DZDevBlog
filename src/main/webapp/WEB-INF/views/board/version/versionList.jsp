<!-- 업무관리 > 컨텐츠 관리 > 업데이트 내역 등록 페이지 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="now"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMddKKmmss" /></c:set>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paging.js"></script>

<script type="text/javascript">

	var listTotalCount = "";
	
	puddready(function() {
		
		$("#btn_ExcelUpload").click(function () { fncUploadPopUp(); });
		$("#btn_Delete").click(function () { fncDelete(); });
		
		fncSearchList();
		
	});

	function fncDelete() {
		
		var param = {};
   		param.cnsltSeq = cnsltSeq;
   		param.actionStatusCode = "7";
   		param.deleteYn = "Y";
   		console.log("cnsltSeq="+cnsltSeq + ", action=" + param.action);
   		
   		$.ajax({
   			type : 'post',
   			contentType: "application/json; charset=utf-8",
   			url : '<c:url value="/consult/updateConsultInfo.do" />',
   			datatype : 'text',
   			async : false,
   			data : JSON.stringify(param),
   			success : function(res) {
   				if (res == "ok") {
	   				fncReloadList();
   				} else {
   					console.log('문의 삭제 Error!');
   				}
   			},
   			error : function(data) {
   				console.log('문의 삭제 Error! >>>> ' + JSON.stringify(data));
   			}
   		});
   		
	}
	
	/****************************************************
	 게시물 삭제
	****************************************************/
	function fncDelete(){
		
		if (!confirm('삭제 하시겠습니까?')) {
           return;
        }
		
		var puddGrid = Pudd( "#tGrid" ).getPuddObject();
		if( ! puddGrid ) return;

		var dataCheckedRowObj = puddGrid.getGridCheckedRowObj( "gridCheckBox" );
		
		if( dataCheckedRowObj.length > 0 ) {
			var deleteArray = new Array();
			
			for( var i in dataCheckedRowObj ) {
				var versionInfo = {};
				versionInfo.PROD_VER_SEQ = dataCheckedRowObj[ i ].rowData.PROD_VER_SEQ;
				deleteArray.push(versionInfo);
			}
			
			var param = {};
			param.deleteArray = deleteArray;
			
			console.log(deleteArray);
			
			$.ajax({
				type : 'post',
				contentType: "application/json; charset=utf-8",
				url : '<c:url value="/board/version/deleteVersionInfo.do" />',
				datatype : 'json',
				async : false,
				data : JSON.stringify(param),
				success : function(res) {
					
					alert(res.rstNm);

					if (Number(res.rstCd) > 0) {
						fncSearchList();
					}
					
				},
				error : function(data) {
					console.log('공지사항 삭제 Error ! >>>> ' + JSON.stringify(data));
				}
			});
		} else {
			alert( "삭제 할 데이터를 선택하세요.");
		}
	}
	
	/****************************************************
	 버전 업데이트 리스트 조회
	****************************************************/
	function fncSearchList(){
		$("#lab_total").text("");
		
		var dataSource = new Pudd.Data.DataSource({
			pageSize : 10, // grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함 //노출되는 개수
			serverPaging : true,
			request : {
				url : '<c:url value="/board/version/retrieveVersionList.do" />',
				type : 'post',
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				jsonStringify : true,
				parameterMapping : function(data) {
					data.startRow = fncGetStartIndex(data.page, data.pageSize);
				}
			},
			result : {
				data : function(response) {
					return response.list;
				},
				totalCount : function(response) {
					listTotalCount = response.totalCnt;
					return response.totalCnt;
				},
				error : function(response) {
					alert("error - Pudd.Data.DataSource.read, status code - " + response.status);
				}
			}
		});
		
		var colums  = fncGetColums();
		
		/****************************************************
		 pudding data bindding
		****************************************************/
	   	Pudd("#tGrid").off(); // 필수
		Pudd("#tGrid").puddGrid({
			dataSource : dataSource,
			scrollable : true,
			height : 450,
			autoScroll : true, // scrollable 값이 true 이고 height 값이 설정된 경우 pager 사용하지 않는 경우 autoScroll - true 설정 권장, 아니면 false 기본값 권장
			pageable : {
   			buttonCount : 10 // 화면에 표현 될 최대 count 개수 
   			, pageList : [ 10, 20, 30, 40, 50 ]
				//,	showAlways : true	// 기본값 true - data totalCount가 0 이라도 pager 표시함
				// false 설정한 경우는 data totalCount가 0 이면 pager가 표시되지 않음
			},
			columns : colums,
			noDataMessage : {
				message : "데이터가 존재하지 않습니다."
			},
			progressBar : {
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
			},
			loadCallback : function( headerTable, contentTable, footerTable, gridObj ) {
				$('#lab_total').text('(총 ' + listTotalCount + ' 건)');
			}
		});
	   	/*
		// 목록 행 클릭 이벤트
		Pudd("#tGrid").on("gridRowClick", function(e) {
			// e.detail 항목으로 customEvent param 전달됨
			var evntVal = e.detail;

			if (!evntVal)
				return;
			if (!evntVal.trObj)
				return;

			// dataSource에서 전달된 row data
			var rowData = evntVal.trObj.rowData;
			// grid 이벤트 관련된 처리부분
			// 다른 페이지에서 사용 할 수 있을 것으로 판단 됨.(파라미터로 구분, 공통코드 사용 가능 할 듯)
			fncModifyPopUp(rowData.PROD_VER_SEQ);
		});
	   	*/
	}
	
	/****************************************************
	colums 가져오기
	****************************************************/
	function fncGetColums(){
		var colums = [
					{
						field : "gridCheckBox"		// grid 내포 checkbox 사용할 경우 고유값 전달
						, width : 20
						, widthUnit : "px"
						, editControl : {
							type : "checkbox"
							, dataValueField : "PROD_VER_SEQ"		// value값을 datasource와 매핑하는 경우 설정
							, basicUse : true
						}
					},
		            { field : "PROD_NAME", title : "제품", width : 80, widthUnit : "px"},
					{ field : "PROD_VER_ID", title : "버전", width : 40, widthUnit : "px", 
						content : {
							template : function( rowData ) {
								
								var html = "<label>" 
										 + "	<a href=\"javascript:fncModifyPopUp('" + rowData.PROD_VER_SEQ + "');\">"
										 + 		rowData.PROD_VER_ID + "</a> "
										 + "</label>";
								
								return html;  
							}
							, attributes : { style : "text-align:left; padding-right:5px;" }
						}
		            },
		            { field : "SAVE_FILE_NAME", title : "엑셀 파일", width : 50, widthUnit : "px",
		            	content : {
							template : function( rowData ) {
								
								//<a href="/fileDownloadProc.do?mType=board&amp;attachSeq=54">엑셀 미리보기 테스트 (2).xlsx</a>
								
								var html = "<label>" 
										 + "	<a href=\"/fileDownloadProc.do?mType=board&boardType=V&deleteYn=N&boardSeq="+rowData.PROD_VER_SEQ+"\">"
										 + 		rowData.PROD_VER_ID + "</a> "
										 + "</label>";
								
								return html;  
							}
							, attributes : { style : "text-align:left; padding-right:5px;" }
						}	
		            
		            },
		            { field : "CREATE_DT", title : "등록일", width : 50, widthUnit : "px"
		            	, content : {
							template : function(rowData) {
								var html = '' + formatDate(rowData.CREATE_DT) + '';
		    					return html;
							}
						}},
		            { field : "DELETE_YN", title : "상태", width :50, widthUnit : "px" }
   					]
		
		return colums;
	}
	
	// 상세 보기 팝업 오픈 
	function fncModifyPopUp(prodVerSeq) {
		var pUrl = "/board/version/versionModify.do?prodVerSeq=" + prodVerSeq
				 + "&boardType=V";
		window.open(pUrl, "VERSION_MODIFY", "width=1120,height=700,toolba=no");
	}
	
	// 엑셀 업로드 등록 팝업 오픈
	function fncUploadPopUp() {
		var pop_title = "VERSION_WRITE" ;
		
		window.open("", pop_title , "width=1120,height=700,toolba=no");
		
		document.getElementById("listForm").target = pop_title;
		document.getElementById("listForm").action = "/board/version/versionWrite.do";
		document.getElementById("listForm").submit();
	}
	
	// 엑셀 파일 다운로드
	function fncFileDownload(prodVerSeq) {
		var pUrl = "/board/version/versionModify.do?prodVerSeq=" + prodVerSeq
				 + "&boardType=V";
		window.open(pUrl, "VERSION_MODIFY", "width=1120,height=700,toolba=no");
	}
</script>

<div id="loadingProgressBar"></div>
	
<form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="prodVerSeq" id="prodVerSeq" />
</form>

<!-- 템플릿 -->
<div class="sub_contents_wrap" style="">

	<p class="tit_p">컨텐츠 관리 > 업데이트 내역 등록</p>
	<div class="com_ta puddSetup">
		<table>
			<colgroup>
				<col width="160"/>
				<col width=""/>
				<col width="160"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>제품구분</th>
				<td>
					<select id="area_Product" class="puddSetup" pudd-style="min-width:180px;" onchange="">
						<option value="0">전체</option>
						<c:forEach var="pdata" items="${productList}" varStatus="status">
							<option value="${pdata.code_seq}">${pdata.code_name}</option>
						</c:forEach>
					</select>
				</td>
				
				</td>
			</tr>
		</table>
	</div>

	<!-- 버튼/타이틀 -->
	<div class="btn_div">
		<div class="left_div">
			<p class="tit_p mb5 mt5">업데이트 내역
				<label class="" id="lab_total"></label>
			</p>
		</div>
		<div class="right_div">
			<input type="button" class="puddSetup" id="btn_ExcelUpload" value="엑셀업로드" />
			<input type="button" class="puddSetup" id="btn_Delete" value="삭제" />
		</div>
	</div>
	
	<div id="tGrid"></div>
	
</div>
<!-- / 템플릿 종료 / -->
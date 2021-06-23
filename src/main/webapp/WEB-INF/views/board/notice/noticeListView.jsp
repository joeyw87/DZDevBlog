<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="now"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMddKKmmss" /></c:set>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paging.js"></script>

<script type="text/javascript">
	puddready(function() {
		$("#btn_Search").click(function () { fncSearchList(); });
		$("#btn_Add").click(function () { fncAddNotice(); });
		$("#btn_Delete").click(function () { fncDeleteNotice(); });
		$("#btn_Mail").click(function () { fncSendMail(); });
		
		fncSearchList();
		fncGetCntInfo(); //카운트 조회
	});

	/****************************************************
	 공지사항 조회
	****************************************************/
	function fncSearchList(){
		$("#lab_total").text("");
		
		var dataSource = new Pudd.Data.DataSource({
			pageSize : 10, // grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함 //노출되는 개수
			serverPaging : true,
			request : {
				url : '<c:url value="/board/notice/retrieveNoticeList.do" />',
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
					//$("#lab_total").text("Total  : " + response.totalCnt + "개");
					return response.list;
				},
				totalCount : function(response) {
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
		/* 그리드 행 더블클릭 이벤트 주석처리
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
			fncViewer(rowData.BOARD_SEQ);
		});
	   */
	}
	
	/****************************************************
	colums 가져오기
	****************************************************/
	function fncGetColums(){
		var colums;
		
		// 조건절에서 로그인 사용자 상태를 구분하여 조회 할 필드만 필터 해서 사용 가능함.
		/* if(){
		}
		else {
		} */
		colums = [
					{
						field : "gridCheckBox"		// grid 내포 checkbox 사용할 경우 고유값 전달
						, width : 20
						, widthUnit : "px"
						, editControl : {
							type : "checkbox"
							, dataValueField : "BOARD_SEQ"		// value값을 datasource와 매핑하는 경우 설정
							, basicUse : true
						}
					},
					{ field : "BOARD_SEQ", title : "번호", width : 40, widthUnit : "px" },
					{ title : "제목", width : 200, widthUnit : "px",
						content : {
							template : function( rowData ) {
								var color = "black";
								var fontWeight = "normal ";
								var html = "";
								
								if(rowData.PRIOR_NO != "4"){
									fontWeight = "bold ";
									
									if(rowData.PRIOR_NO != "2"){
										if(rowData.PRIOR_NO == "1")
											color = "red";
										else if(rowData.PRIOR_NO == "3")
											color = "blue";
										html = "<label style=\"color:" + color + "; font-weight:" + fontWeight + ";\">" + "[" + rowData.PRIOR_NM + "]" +  "</label>&nbsp;";
									}
								}
								
								html += "<label style=\"font-weight:" + fontWeight + ";\">" + "<a href=\"javascript:fncViewer('" + rowData.BOARD_SEQ + "');\">"+ rowData.SUBJECT + "</a> </label>";
								
								return html;  
							}
							, attributes : { style : "text-align:left; padding-right:5px;" }
						}
					},
		            { field : "PRODUCT_NAME", title : "제품구분", width : 80, widthUnit : "px"},
		            { field : "CREATE_DT", title : "등록일", width : 50, widthUnit : "px" },
		            { field : "VIEW_CNT", title : "조회수", width :50, widthUnit : "px" },
		            { field : "PRIOR_NM", title : "공지구분", width : 30, widthUnit : "px",
						content : {
							template : function( rowData ) {
								var color = "black"
								if(rowData.PRIOR_NO == "1")
									color = "red";
								else if(rowData.PRIOR_NO == "3")
									color = "blue";
								
								html = "<label style=\"color:" + color + ";\">" + rowData.PRIOR_NM + "</label>";
								return html;  
							}
						}
					},
		            { field : "BOARD_NO", title : "E-mail 발송이력", width : 50, widthUnit : "px" },
		            { field : "BOARD_NO", title : "SMS 발송이력", width : 50, widthUnit : "px" },
		            { field : "STATUS", title : "상태", width : 50, widthUnit : "px", 
						content : {
							template : function( rowData ) {
								var html = "";
								if(rowData.STATUS == "T"){
									html = "임시저장";
								}else if(rowData.STATUS == "D"){
									html = "삭제";
								}
								return html;  
							}
						}
					}
    	]
		
		return colums;
	}
	
	/* 공지사항 카운트 정보 가져오기 */
	function fncGetCntInfo(){
		var param = {};
		param.text = "fncGetCntInfo";
		
		$.ajax({
			type : 'post',
			contentType: "application/json; charset=utf-8",
			url : '<c:url value="/board/notice/getNoticeCntInfo.do" />',
			datatype : 'json',
			async : false,
			data : JSON.stringify(param),
			success : function(data) {
				//alert(data);
				var result = data.resultMap;
				$("#lab_total").text("총 " + result.TOTAL + "건 / 긴급 " +result.PRIOR1+" / 중요 "+result.PRIOR2+" / 최신 "+result.PRIOR3+" / 일반 "+result.PRIOR4);
			},
			error : function(data) {
				console.log('카운트 가져오기 Error ! >>>> ' + JSON.stringify(data));
			}
		});
	}
	
	/****************************************************
	 공지사항 등록
 	****************************************************/
	function fncAddNotice(){
		location.href = "/board/notice/noticeWrite.do";
	}
	
	/****************************************************
	 공지사항 삭제
 	****************************************************/
	function fncDeleteNotice(){
		
		if (!confirm('삭제 하시겠습니까?')) {
            return;
        }
		
		var puddGrid = Pudd( "#tGrid" ).getPuddObject();
		if( ! puddGrid ) return;
 
		var dataCheckedRowObj = puddGrid.getGridCheckedRowObj( "gridCheckBox" );
		
		if( dataCheckedRowObj.length > 0 ) {
			var deleteArray = new Array();
			
			for( var i in dataCheckedRowObj ) {
				var noticeInfo = {};
				noticeInfo.BOARD_SEQ = dataCheckedRowObj[ i ].rowData.BOARD_SEQ;
				deleteArray.push(noticeInfo);
			}
			
			var param = {};
			param.deleteArray = deleteArray;
			
			$.ajax({
				type : 'post',
				contentType: "application/json; charset=utf-8",
				url : '<c:url value="/board/notice/deleteNoticeList.do" />',
				datatype : 'json',
				async : false,
				data : JSON.stringify(param),
				success : function(data) {
					alert(data.rstNm);
					fncSearchList();
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
	 공지사항 상세 조회
	****************************************************/
	function fncViewer(BOARD_SEQ){
		document.getElementById("listForm").action = "/board/notice/noticeDetail.do";
		document.getElementById("BOARD_SEQ").value = BOARD_SEQ;
		document.getElementById("listForm").submit();
	}
	
	function fncSendMail(){
		var param = {};
		param.text = "testMail";
		
		$.ajax({
			type : 'post',
			contentType: "application/json; charset=utf-8",
			url : '<c:url value="/board/notice/sendMailYW.do" />',
			datatype : 'json',
			async : false,
			data : JSON.stringify(param),
			success : function(data) {
				alert(data.resultCode);
			},
			error : function(data) {
				console.log('메일발송 Error ! >>>> ' + JSON.stringify(data));
			}
		});
	}
</script>

<input type="hidden" id="hidIndex"/>

<form id="listForm" name="listForm" method="post">
	<input type="hidden" name="BOARD_SEQ" id="BOARD_SEQ" />
</form>


<div id="loadingProgressBar"></div>
	<div class="sub_contents_wrap" style="">
		<!-- 버튼/타이틀 -->
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mb5 mt5">공지사항
				<label class="tit_p" id = "lab_total"></label>
				</p>
			</div>

			<div class="right_div">
				<input type="button" class="puddSetup" id="btn_Search" value="조회" />
				<input type="button" class="puddSetup" id="btn_Add" value="등록" />
				<input type="button" class="puddSetup" id="btn_Delete" value="삭제" />
				<input type="button" class="puddSetup" id="btn_Mail" value="메일발송테스트" />
			</div>
		</div>

		<div id="tGrid"></div>
	</div>
	<!-- / 템플릿 종료 / -->
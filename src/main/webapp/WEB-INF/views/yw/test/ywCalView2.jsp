<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"  %>
<%
/**
 * 
 * @title 테스트 캘린더 페이지
 * @author 조영욱
 * @since 2020.10.06
 * @version 
 * @dscription 부민병원 테스트 캘린더 페이지 (carReqView.jsp 참고)
 */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
   
<!--css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">

<!-- pudding -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/animate.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/pudd.css" />
    
<!--js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pudd/pudd-1.1.189.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.min.js"></script>

<!--full calendar css -->
<link href="<c:url value='/resources/fullCal/css/fullcalendar.css'/>" rel='stylesheet' />
<link href="<c:url value='/resources/fullCal/css/fullcalendar.print.css'/>" rel='stylesheet' media='print' />

<!-- full calendar js -->
<script type="text/javascript" src="<c:url value='/resources/fullCal/Script/moment.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/fullCal/Script/fullcalendar.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/fullCal/Script/locale-all.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/fullCal/Script/keea.common.js'/>"></script>
<script type="text/javascript">
	var puddDlgObj = null;
	puddready( function() {
		$("#btnDelete").click(function () { fncDelete(); });

		fncControlInit();

	});

	/************************************
  	// 컨트롤 바인딩
    *************************************/
    function fncControlInit() {
    	// fullCalendar
		fncFullCalendarEvent();

		$('.fc-prev-button').click(function() { fncDataList(); });
		$('.fc-next-button').click(function() { fncDataList(); });
		$('.fc-today-button').click(function() { fncDataList(); });
// 		$('.fc-month-button').off("click").on("click", (function (e) { fncTabClick("month"); }));
// 		$('.fc-listMonth-button').off("click").on("click", (function (e) { fncTabClick("listMonth"); }));

		// 차종선택
		var carMList = (function(){

   			return new Pudd.Data.DataSource({
   	    		request : {
   	   				url : '<c:url value="/common/retrieveCommonCodeList.do" />'
   	    			, type : 'post'
   	    			, dataType : "json"
   	    			, contentType : "application/json; charset=utf-8"
   	    			, jsonStringify : true
   	    			, async: false
   	    			, parameterMapping : function( data ) {
   	    				data.div = "carMList";
   	    			}
   	    		}
   	    		, result : {
   	    			data : function( response ) {
   	    				response.result.unshift({nm: "전체", cd: ""});
   	    				return response.result;
   	    			}
   	    		}
   	    	 });
   		})();

		Pudd("#ddlCarMList").puddComboBox(
		    {
		    	attributes : { style : "width:250px;" }// control 부모 객체 속성 설정
			,	controlAttributes : { id : "selCarMList" }// control 자체 객체 속성 설정
			,	dataSource : carMList
			,	dataValueField : "cd"
			,	dataTextField : "nm"
			,	selectedIndex : 0
			,	disabled : false
			,	scrollListHide : false
			,   eventCallback : {
				"change" : function(e){
					fncDataList();
				}
			}
	    });

		// 데이터 조회
		fncDataList();
	}

//     function fncTabClick(div) {
//     	if (div == 'month') {
//     		$('.fc-month-button').addClass('fc-state-active');
//     		$('.fc-listMonth-button').removeClass('fc-state-active');

//     		$('.fc-view-container').show();
//     		$('#tGrid').hide();

//     		calendarResize();

//     	} else if (div == 'listMonth') {
//     		$('.fc-month-button').removeClass('fc-state-active');
//     		$('.fc-listMonth-button').addClass('fc-state-active');

//     		$('.fc-view-container').hide();
//     		$('#tGrid').show();

//     	}
//     }

    /************************************
  	// fullCalendar
    *************************************/
    function fncFullCalendarEvent() {
    	// 리버트 펑크
    	var revertFuncTemp = "";

    	var weekFirstDay = '0';	//캘린더 주시작일 옵션값 초기값으로 0:일요일

    	$('#calendar').fullCalendar({
// 			schedulerLicenseKey : '0878669264-fcs-1487643195',
            buttonText:{
                 month:    '달력',
//                  week:     '주',
                 listMonth:'내 신청리스트'
              },
			header : {
				left : 'prev, next today',
				center : 'title',
				right : ''
// 				right : 'agendaDay, agendaWeek, month, listMonth'
			},
			firstDay: weekFirstDay,		//Sunday=0, Monday=1, Tuesday=2, etc.
			views : {
				month : {
					eventLimit : 0	//화면상 더보기 갯수 0이면 리스트보기, 1이상이면 더보기로 변경됨
				}
			},
	        viewRender: function(view, element) {
	            element.find(".fc-col0.fc-widget-header").html('');
	        },
			defaultDate : '${nowDate}',
			defaultView : 'month',
			displayEventTime : true,    //캘린더 시간 노출여부
			durationEditable : false,
			locale : 'ko',
			navLinks : false,
			selectable : true,
			selectHelper : true,
			select : function(start, end, event, jsEvent, view, resource) {
				sDate = start.toISOString();
				eDate = fncDateCal(end.toISOString(), -1);

				var nowDate = '${nowDate}'.replace(/-/gi, "");

				if (sDate.replace(/-/g, '') < nowDate) {
					alert('오늘 이전 날짜는 신청이 불가능 합니다.');
					return;
				}

				fncCarReqPop("", "n", sDate, eDate);

			},
			resources : [],
			editable : true,
			eventLimit : false,
			aspectRatio : '2.5',
			events : [],
			eventTextColor : '#303030',
			eventClick : function(calEvent, jsEvent, view) {
				fncCarReqPop(calEvent.carReqSeq, "v");

			},
			eventResize : function(event, delta, revertFunc) {
				alert('eventResize')
			},
			eventDrop : function(event, delta, revertFunc) {
				alert('eventDrop')
			},
			eventAfterRender : function(event, element, view) {
// 				alert('eventAfterRender')
// 				addImage(event, element, view);
			},
			activate : function(event, ui) {
				alert('activate')
			},
			eventAfterAllRender: function (view) {
// 				alert('eventAfterAllRender')

			}
		});
    }

    /****************************************************
  	// 차량신청 등록 팝업
   	****************************************************/
   	function fncCarReqPop (carReqSeq, popDiv, sDate, eDate){
		var title = "차량신청";
		var dlgHeight;
		var btnVal;

		if (popDiv == "v") {
			dlgHeight = 220;
			btnVal = "수정";
		} else if (popDiv == "n" || popDiv == "m") {
			dlgHeight = 350;
			btnVal = "저장";
		}

		// puddDialog 함수
   		puddDlgObj = Pudd.puddDialog({
	   			width : 600
	   		,	height : dlgHeight

	   		,	modal : true		// 기본값 true
	   		,	draggable : true	// 기본값 true
	   		,	resize : false		// 기본값 false

	   		,	header : {

	   				title : title
	   			,	align : "left"	// left, center, right

	   			,	minimizeButton : false	// 기본값 false
	   			,	maximizeButton : false	// 기본값 false

	   			,	closeButton : true	// 기본값 true
	   			,	closeCallback : function( puddDlg ) {

	   					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
	   					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
	   				}
	   			}

	   		,	body : {

					iframe : true
  				,	iframeAttribute : {
  					id : "dlgFrame"
  				}
	   			,	url : '<c:url value="/car/application/iframeCarReqView.do" />'	// iframe true인 경우
   				,	type : "get"		// iframe true인 경우 - get 또는 post
				,	params : {		// iframe true인 경우 - name /value 형식
						"popDiv" : popDiv
						, "carReqSeq" : carReqSeq
						, "sDate" : sDate
						, "eDate" : eDate

				}
   			}

	   		,	footer : {

   				buttons : [
   					{
   						attributes : {}// control 부모 객체 속성 설정
   					,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
   					,	value : btnVal
   					,	clickCallback : function( puddDlg ) {
	   						if (popDiv == "v") {
	   							fncCarReqPop (carReqSeq, 'm');
	   							puddDlg.showDialog( false );

	   						} else {
	   							var iframeTag = document.getElementById( "dlgFrame" );
	   							iframeTag.contentWindow.fncSave();
	   						}

   						}
   					}
   				,	{
   						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
   					,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
   					,	value : "취소"
   					,	clickCallback : function( puddDlg ) {

   							puddDlg.showDialog( false );
   							// 추가적인 작업 내용이 있는 경우 이곳에서 처리
   						}
   					}
   				]
   			}
   		});

	}

    /************************************
  	// 데이터 조회
    *************************************/
	function fncDataList() {
    	var title = $('#calendar').find('h2').text();

    	var yyyy = '';
		var mm = '';
		var yyyymm = '';

		try {
			title = $.trim(title.replace('년', '').replace('월', ''));
			yyyy = title.substr(0, 4);
			mm = title.substring(5);

			if(mm < 10) {
				mm = "0" + mm;
			}

			yyyymm = yyyy + mm;

	    }
	    catch (e) {
	    	yyyymm = '${nowDate}'.replace(/-/gi, "").substr(0, 6);
	    }

		// 휴일데이터 조회
		fncHolidayList(yyyymm);

		// 차량일정 데이터 및 내신청리스트 조회
		fncGridList(yyyymm);

    }

	// 캘린더 리사이즈
	$.fn.hasScrollBar = function() {
	    return (this.prop("scrollHeight") == 0 && this.prop("clientHeight") == 0)
	            || (this.prop("scrollHeight") > this.prop("clientHeight"));
	};
	function calendarResize(){
		$('#calendar').fullCalendar('option', 'height', null);

		// 스크롤바 생기면 auto로 바꾸고 안생기면 계속 null
		if($(".fc-widget-content div").hasScrollBar() == true){
			$('#calendar').fullCalendar('option', 'height', "auto");
		}
	}

	/************************************
  	// 차량일정 데이터 및 내신청리스트 조회
    *************************************/
	function fncGridList(yyyymm) {
		// 차량일정 데이터 조회
    	var dataSource = new Pudd.Data.DataSource({
    		request : {
   				url : '<c:url value="/car/application/retrieveCarReqList.do" />'
    			, type : 'post'
    			, dataType : "json"
    			, contentType : "application/json; charset=utf-8"
    			, jsonStringify : true
    			, parameterMapping : function( data ) {
    				data.fromDt = yyyymm + "01";
    				data.toDt = yyyymm + "31";
    				data.carMCd = Pudd( "#ddlCarMList" ).getPuddObject().val();
    			}
    		}
    		, result : {
    			data : function( response ) {

    				$('#calendar').fullCalendar('removeEvents');
   		 			$('#calendar').fullCalendar('addEventSource', response.result.carReqList);
   		 			calendarResize();

    				return response.result.carReqMngList;
    			}
    			, error : function( response ) {
    				alert("작업에 실패 하였습니다.");
    			}
    		}
    	 });

    	fncGridListBind(dataSource);

	}

	/************************************
   	// 리스트 바인딩
    *************************************/
    function fncGridListBind(dataSource) {
    	Pudd( "#tGrid" ).puddGrid({

    		dataSource : dataSource
    		, scrollable : true
    		, height : fncGridHeight(600, 220)
    		, resizable : true
    		, columns : [
				{
					field:"gridCheckBox"
					, width : "5"
					, widthUnit : "%"
					, editControl : {
						type : "checkbox"
						, dataValueField : "carReqSeq"		// value값을 datasource와 매핑하는 경우 설정
						, basicUse : true
					}
				}
		        , {
		        	title : "신청일"
					,	columns : [
						{
							title : "일수"
							, width : "20"
							, widthUnit : "%"
							,	content : {
								template : function( rowData ) {
									var html = rowData.reqDt;
									html += '<br />';
									html += rowData.reqDays;
									return html;
								}
							}
					 	}
	    			]
	    		}
		        , {
		        	title : "부서"
					,	columns : [
						{
							title : "운전자"
							, width : "23"
							, widthUnit : "%"
							,	content : {
								template : function( rowData ) {
									var html = rowData.deptName;
									html += '<br />';
									html += rowData.empName;
									return html;
								}
							}
					 	}
	    			]
	    		}
		        , {
		        	title : "시작일시"
					,	columns : [
						{
							title : "종료일시"
							, width : "26"
							, widthUnit : "%"
							,	content : {
								template : function( rowData ) {
									var html = rowData.startDt;
									html += '<br />';
									html += rowData.endDt;
									return html;
								}
							}
					 	}
	    			]
	    		}
		        , {
		        	title : "승인"
					,	columns : [
						{
							title : "차량"
							, width : "26"
							, widthUnit : "%"
							,	content : {
								template : function( rowData ) {
									var html = rowData.reqConfirmYnNm;
									html += '<br />';
									html += rowData.carType;
									return html;
								}
							}
					 	}
	    			]
	    		}
		        , {
					field : "reqDt"
					,	hidden : true
				}
    		]
	    	, noDataMessage : {
	    		message : "데이터가 존재하지 않습니다"
	    	}
	    	,	progressBar : {
				progressType : "loading"
				,	attributes : { style:"width:70px; height:70px;" }
				,	strokeColor : "#84c9ff"	// progress 색상
				,	strokeWidth : "3px"	// progress 두께
				,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
				,	percentTextColor : "#84c9ff"
				,	percentTextSize : "12px"
			}
    		,	loadCallback : function( headerTable, contentTable, footerTable, gridObj ) {
			}
    	});
	}

    /************************************
  	// 휴일데이터 조회
    *************************************/
	function fncHolidayList(yyyymm) {
 		// 일반휴가는 년도를 넘어갈 수 없음.
		var tblParam = {};
    	tblParam.fromDt = yyyymm + "01";
    	tblParam.toDt = yyyymm + "31";

		$.ajax({
            type: 'POST',
			url: '<c:url value="/common/application/retrieveHolidayDayList.do" />',
    		dataType:'json',
    		async: false,
    		data:JSON.stringify(tblParam),
    		contentType:'application/json; charset=utf-8',
    		success: function(res){
    			fncHolidayListBind(res.result);
    		}

        });
 	}

	/************************************
  	// 리스트 바인딩
    *************************************/
    function fncHolidayListBind (holidayList) {
		var monthHeader = $('.fc-content-skeleton').find("thead tr .fc-day-top");

		var solar = "";
		var holidaySpan = "";
		var lunarDay = "";
		var spanTag = "";
		var holidayNumTf = false;

		$(monthHeader).each(function() {
			solar = $(this).attr('data-date');
			solar = solar.replace(/-/g, '');
			holidaySpan = "";
			lunarDay = "";
			spanTag = "";

			//공휴일 연동
			holidayNumTf = false;
			$(holidayList).each(function(index, value) {
				if (solar == value.holiday) {
					holidaySpan = '<span style="font-size:8pt; color:red;" id="holidaySpn">';
					lunarDay =  value.title;
					holiDayColor = 'Y';
					spanTag = holidaySpan;
					holidayNumTf = true;
				} else {
					holiDayColor = 'N';
				}
			});

			if(holidayNumTf){// 공휴일 날짜 빨간색 스타일추가_jake.19.04.09
				$(this).find("span").css('color', 'red');
			}

			//이후 처리
			$(this).find('#holidaySpn').remove();
			$(this).append(spanTag + lunarDay + '</span>');

		});
	}

    /****************************************************
  	// 차량신청내역 삭제
   	****************************************************/
   	function fncDelete (){
   		if (!confirm("삭제하시겠습니까?")) {
            return;
        }

    	var puddGrid = Pudd( "#tGrid" ).getPuddObject();
   		if( ! puddGrid ) return;

   		var carReqSeqs = [];
   		var result = true;
   		var nowDt = '${nowDate}'.replace(/-/gi, "");
   		var reqDt = '';
   		var dataCheckedRow = puddGrid.getGridCheckedRowData( "gridCheckBox" );
   		if( dataCheckedRow.length > 0 ) {

   			for( var i in dataCheckedRow ) {
   				reqDt = dataCheckedRow[ i ].reqDt.replace(/-/gi, "");

   				// 신청일이 지난경우 삭제 불가.
   				if (reqDt >= nowDt) {
   					carReqSeqs.push(dataCheckedRow[ i ].carReqSeq);
   				} else {
					alert("신청일이 지난경우 삭제가 불가 합니다.");
					result = false;
					return false;
   				}

   			}

   		} else {
   			alert( "선택항목이 없습니다." );
   			return;
   		}

   		if (result) {
   			var cUrl = '<c:url value="/car/application/deleteCarReq.do" />';

   			var tblParam = {};
   	        tblParam.carReqSeqs = carReqSeqs;

			$.ajax
	 	    ({
	 	        type: "POST"
	 		    , contentType: "application/json; charset=utf-8"
	 		    , dataType: "json"
	 		    , url: cUrl
	             , async: false
	             , data: JSON.stringify(tblParam)
	 		    , success: function (res) {
	 		    	if(res.result > 0){
	 		    		alert("삭제되었습니다.");
	 		    		fncDataList();

	 		        } else {
	 		        	alert("작업 도중 실패하였습니다. 다시 시도해 주세요.");

	 		        }
	 		    }
	 		    , error: function (data) {
	 		    	alert("작업에 실패 하였습니다.");
	 		    }
	 	    });
   		}

    }

   	/****************************************************
  	// save callback
   	****************************************************/
   	function fncSaveCallback(){
   		puddDlgObj.showDialog( false );

   		// 데이터 조회
    	fncDataList();
    }

</script>
<div id="loadingProgressBar"></div>
<div class="sub_wrap">
	<div class="sub_contents">
		<!-- iframe wrap -->
		<div class="iframe_wrap">
			<div class="location_info">
				 <ul id="menuHistory">
				 </ul>
			</div>
			<!-- 화면타이틀 -->
			<div class="title_div">
			</div>

			<!-- 컨텐츠내용영역 -->
			<div class="sub_contents_wrap">
				<table width="100%" style="table-layout: fixed;">
					<colgroup>
						<col style="width:67%;">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<td class="twinbox_td p0" style="vertical-align:top;">
								<div id="" class="controll_btn fr" style="margin-left: 10px;padding: 0px;">
									<span id="ddlCarMList"></span>
								</div>
								<!-- full Calendar 개발 영역 START-->
								<div id='calendar'></div>
							</td>
							<td class="twinbox_td p0" style="vertical-align:top;">
								<div class="tb_borderB pl15 pr15 clear bg_lightgray">
									<p class="tit_p fl mt14">내 신청리스트
									</p>
									<div class="controll_btn p0" style="padding-top:5px;">
										<button id="btnDelete" style="margin-top:10px;">삭제</button>
									</div>
								</div>
								<div class="p15">
									<div id='tGrid'></div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

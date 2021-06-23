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
 * @dscription 부민병원 테스트 캘린더 페이지
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

<style type="text/css" >
	.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
	    position: fixed;
	    left:0;
	    right:0;
	    top:0;
	    bottom:0;
	}
    .wrap-loading div{ /*로딩 이미지*/
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -21px;
        margin-top: -21px;
        z-index:9999;
    }
    .display-none{ /*감추기*/
        display:none;
    }
    
    /* 근무일정표 가로 고정 */
    #workCalendarTable tr:first-child th {position: sticky;top: 0px;}
	#workCalendarTable tr:nth-child(2) th {position: sticky;top: 37px;}
	.com_ta4 table { table-layout: fixed;}
	/* .scroll_x_on{overflow-y: auto !important;height:500px;} */ /*높이 고정 조절*/
	
</style>

<script type="text/javascript">

var userSe = ""; //로그인 사용자 권한
var startDt = "2020-09-12"; //시작일
var endDt = "2020-10-12"; //종료일
var g_dayCnt = ""; //일수 차이
var weekNmArr = new Array("일", "월", "화", "수", "목", "금", "토");

$(document).ready(function() {	
	//기간 디폴트 세팅
	fnInitBasicDate();
	
	//날자 일수 계산
	fnSetDayCnt();
	
	setCalendarTable();
	
	/* $(".dayData").click(function() {
		var td = $(this);
		var tdText = td[0].outerText;
		var ywId = td[0].dataset.id;
		alert(tdText + "//" + ywId);
	}); */
	
	/* $(".dayData").on("click",function(e){
		alert('오호이');
	}); */
	
	//동적 클릭 이벤트 바인딩
	$(document).on("click", ".dayData", function () {
		var td = $(this);
		var tdText = td[0].outerText;
		var ywId = td[0].dataset.id;
		var ywDate = td[0].dataset.date;
		alert(tdText + "//" + ywId + "//" + ywDate);
    });
	
	$("#btnSearch").click(function() {
		fnSearch();
	});
});

function fnInitBasicDate(){
	//검색일자 디폴트 설정
    var puddObj1 = Pudd( "#startDate" ).getPuddObject();
    if( ! puddObj1 ) return;
    puddObj1.setDate("${beforeDate}");

    var puddObj2 = Pudd( "#endDate" ).getPuddObject();
    if( ! puddObj2 ) return;
    puddObj2.setDate("${nowDate}");
}

function fnSetDayCnt(){
	//날짜 일수 차이 계산
	//var sdt = new Date(startDt);
	//var edt = new Date(endDt);
	var sdt =  new Date( $("#startDate").val() );
	var edt =  new Date( $("#endDate").val() );	
	g_dayCnt = Math.ceil((edt.getTime()-sdt.getTime())/(1000*3600*24));
	g_dayCnt = g_dayCnt + 1; //일수+1
}

function setCalendarTable(){
	//로딩 이미지
	$('.wrap-loading').removeClass('display-none');
	
	$("#workCalendarTable").html("");
	var innerHtml = "";
	
	var userT = ["근무","OFF","휴가","교육","근무시간","OT"];
	//콜그룹
	innerHtml += "<colgroup>";
	innerHtml += "<col width='50px' />";
	innerHtml += "<col width='130px' />";
	innerHtml += "<col width='130px' />";
	innerHtml += "<col width='130px' />";
	for(var i=0;i<g_dayCnt;i++){
		innerHtml += "<col width='50px' />";
	}
	//사원별 통계
	for(var i=0;i<userT.length;i++){
		innerHtml += "<col width='50px' />";
	}
	innerHtml += "</colgroup>";
	
	//헤더
	innerHtml += "<tr>";
	innerHtml += "<th rowspan='2'><b>순번</b></th>";
	innerHtml += "<th rowspan='2'><b>부서</b></th>";
	innerHtml += "<th rowspan='2'><b>직급</b></th>";
	innerHtml += "<th rowspan='2'><b>이름</b></th>";
	for(var i=0;i<g_dayCnt;i++){
		var cnt = i+1; //카운트
		innerHtml += "<th><b>"+cnt+"</b></th>";
	}
	//사원별 통계
	for(var i=0;i<userT.length;i++){
		innerHtml += "<th rowspan='2'><b>"+userT[i]+"</b></th>";
	}
	innerHtml += "</tr>";
	
	innerHtml += "<tr>";
	for(var i=0;i<g_dayCnt;i++){
		var cnt = i+1; //카운트
		innerHtml += "<th><b>월</b></th>";
	}
	innerHtml += "</tr>";
	
	//row
	for(var k=0;k<15;k++){
		innerHtml += "<tr>";
		innerHtml += "<td>"+(k+1)+"</td>";
		innerHtml += "<td>관리팀</td>";
		innerHtml += "<td>사원</td>";
		innerHtml += "<td>관리자</td>";
		for(var i=0;i<g_dayCnt;i++){
			innerHtml += "<td class='dayData' data-id='ywyw"+(k+1)+"' data-date='ywdate"+(i+1)+"'>OF</td>";
		}
		//사원별 통계
		for(var i=0;i<userT.length;i++){
			innerHtml += "<td>50</td>";
		}
		innerHtml += "</tr>";
	}
	
	//일별통계
	var codeT = ["D","E","N","H","B","C","OF"];
	for(var j=0;j<codeT.length;j++){
		innerHtml += "<tr>";
		innerHtml += "<td></td>";
		innerHtml += "<td></td>";
		innerHtml += "<td></td>";
		innerHtml += "<td>"+codeT[j]+"</td>";
		for(var i=0;i<g_dayCnt;i++){
			innerHtml += "<td>"+g_dayCnt+"</td>";
		}
		//나머지 사원별 통계 공백 생성
		for(var i=0;i<userT.length;i++){
			innerHtml += "<td></td>";
		}
		innerHtml += "</tr>";
	}
	
	if(g_dayCnt == 0)
		innerHtml += "<tr><td colspan='5'>데이터가 없습니다.</td></tr>";
		
	$("#workCalendarTable").html(innerHtml);
	
	//로딩 해제
	$('.wrap-loading').addClass('display-none');
}

function fnSearch(){
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	
	//일수 계산 세팅
	fnSetDayCnt();
	
	//테이블 바인딩
	setCalendarTable();
}
		
</script>
</head>
<div class="wrap-loading display-none">
    <div><img src="${pageContext.request.contextPath}/resources/Images/ico/loading.gif" /></div>
</div>  
<div class="sub_wrap">
	<div class="sub_contents">	             
        <!-- 여기서부터 컨텐츠 아이프레임 영역 -->
		<!-- iframe wrap -->
		<div class="iframe_wrap" style="min-width:1100px;">
		
			<!-- 컨텐츠타이틀영역 -->
			<div class="sub_title_wrap">
				<div class="location_info">
					 <ul>
						<li><a href="#n"><img src="${pageContext.request.contextPath}/resources/Images/ico/ico_home01.png" alt="홈"></a></li>
						<li><a href="#n">시스템설정</a></li>
						<li><a href="#n">조직도연동정보</a></li>
						<li class="on"><a href="#n">IM연동정보내역</a></li>
					 </ul>
				</div>
				<div class="title_div">
					<h4>연동정보내역</h4>
				</div>
			</div>
			
			<!-- 검색 -->
			<div class="top_box">										
				<dl class="dl1">
					<dt>근무기간</dt>
					<dd><input type="text" value="" class="puddSetup" pudd-type="datepicker" id="startDate"/>
					~ <input type="text" value="" class="puddSetup" pudd-type="datepicker" id="endDate"/></dd>
										
					<dt>동기화구분</dt>
					<dd>
						<select id="syncGbn" class="puddSetup" pudd-style="width:110px;">
							<option value="">전체</option>
							<option value="M">수동</option>
							<option value="S">자동(스케줄)</option>
						</select>
					</dd>
					
					<dd><input type="button" id="btnSearch" class="puddSetup" value="검색" style="background:#03a9f4;color:#fff" /></dd>
				</dl>								
			</div>
			
			<!-- 컨텐츠내용영역 -->
			<div class="sub_contents_wrap">	
				<div class="btn_div">
					<div class="left_div">
                        <h5 class="fl">
                           	 근태단위현황
                            <img src="${pageContext.request.contextPath}/resources/Images/ico/ico_explain.png" alt="안내" class="mtImg" style="cursor: help;"
                                title="괄호 안 수치는 사원의 부서/근무조/그룹 중복을 제외한 수치입니다.">
                        </h5>
                        <div class="fl mt5 ml10">
                            <span><span style="color: #3badde;">■</span> 휴가</span> <span class="ml5"><span style="color: #6eb980;">
                                ■</span> 반차</span> <span class="ml5"><span style="color: #f6b331;">■</span> 교육</span>
                        </div>
                    </div>
					<div class="right_div">
						<div class="controll_btn p0">
							<input type="button" id="btnCreate" class="puddSetup" value="엑셀 등록">
							<input type="button" id="btnCommit" class="puddSetup" value="확정">
							<input type="button" id="btnExcel" class="puddSetup" value="엑셀 저장">
						</div>
					</div>
				</div>
				
				<div id="ywcalWarpper">
					<div class="com_ta4 scroll_x_on cursor_p bgtable2">
						<table id="workCalendarTable" style="width: 1800px;">
							<colgroup>
								<col width="60px" />
								<col width="150px" />
								<col width="150px" />
								<col width="150px" />
							</colgroup>
							<tr>
								<th><b>순번</b></th>
								<th><b>부서</b></th>
								<th><b>직위</b></th>
								<th><b>이름</b></th>
							</tr>
							<tr>
								<td>1</td>
								<td>관리자</td>
								<td>관리자</td>
								<td>관리자</td>
							</tr>
							<tr>
								<td>1</td>
								<td>관리자</td>
								<td>관리자</td>
								<td>관리자</td>
							</tr>
							<tr>
								<td>1</td>
								<td>관리자</td>
								<td>관리자</td>
								<td>관리자</td>
							</tr>
							
						</table>
					</div>
				</div>
				
			</div>				
		</div><!-- iframe wrap -->
		<!-- //여기까지 컨텐츠 아이프레임 영역 -->
	</div>
</div>

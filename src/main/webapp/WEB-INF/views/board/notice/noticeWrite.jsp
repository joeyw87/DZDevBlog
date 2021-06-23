<!-- /**
 * 헬프데스크 공지사항
 * jsp명: noticeWrite.jsp  
 * 작성자: 조영욱
 * 수정일자: 2019.07.24 
 */
 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonJquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/dzeditor_v1.1.5.3/js/dze_iframe_function.js"></script>

<style type="text/css">
/* .uploadFile {background: url("${pageContext.request.contextPath}/resources/Images/ico/ico_clip02.png") no-repeat center center;margin-right: 2px; height:22px;   margin-left: 9px;float:left;} */
</style>

<script type="text/javascript" language="javascript">
	var attachSeqList = ""; //첨부파일 업로드 콜백 시퀀스키

	puddready(function() {
		$("#btn_Save").click(function () { fncSave("S"); });
		$("#btn_SaveTmp").click(function () { fncSave("T"); });
		
		$("#btn_Cancel").click(function () { fncCancel(); });
		
		fncControlInit();
		
		//$("#fileupload").on("change", addFiles);
		
	});
	
	//******************************************************
	//초기화
	//******************************************************
	var fncControlInit = function() {
		/**************************
		pudding selectbox
	   ***************************/
	   /* 푸딩 select 박스 */
		/* $("#area_Product").fncPuddSelectDDL(
			{ 'url' : '<c:url value="/common/retrieveCommonCodeList.do" />', 'async' : false }, 
			{ 'div' : 'common', 'CD_M_NM' : 'product' }, 
			{ controlAttributes : { id : "sel_Product" }, // control 자체 객체 속성 설정
				attributes : { style : "width:150px;" }, // control 부모 객체 속성 설정
				dataValueField : "CD_NO",
				dataTextField : "CD_NM",
				selectedIndex : 0,
				disabled : false,
				scrollListHide : false
		}); */
		/* selectbox로 변경
		$("#area_Product").fncSetCheckDDL(
				{ 'url' : '<c:url value="/common/retrieveCommonCodeList.do" />', 'async' : false }, 
				{ 'div' : 'etc', 'CD_M_NM' : 'product' }
		); 
		*/
		$("#area_NoticeType").fncSetRadioDDL(
			{ 'url' : '<c:url value="/common/retrieveCommonCodeList.do" />', 'async' : false, 'click' : "fncRadioClick();" }, 
			{ 'div' : 'common', 'CD_M_NM' : 'notice_type' }
		);
		$("#area_Alarm").fncSetCheckDDL(
			{ 'url' : '<c:url value="/common/retrieveCommonCodeList.do" />', 'async' : false }, 
			{ 'div' : 'common', 'CD_M_NM' : 'alarm' }
		);
		
		/**************************
		pudding datepicker
	   ***************************/
		Pudd("#area_Date").puddDatePicker({
			typeDisplay : "period",
			periodType : "double",
			startDate : "${nowDate}",
			endDate : "${afterDate}",
			disabled : false
		});
	}
	
	function fncRadioClick(){
		//일반 외 기간 노출
		if($("input:radio[name=area_NoticeType]:checked").val() == "4"){
			$("#hid_DateDiv").hide();
		}
		else {
			$("#hid_DateDiv").show();
		}
	}
	
	//******************************************************
	//저장 프로세스 시작
	// sts - S : 저장, T : 임시저장
	//******************************************************
	function fncSave(sts) {	
		var bool = false ;
		bool = fncValidNotice();
		
		if(bool == true){
			
			if (!confirm('공지사항을 등록/발송 하시겠습니까?')) {
	            return;
	        }
			
			fncUploadFile(); //첨부파일 업로드
			fncSaveNotice(sts); //게시물 컨텐츠 업로드
		}
	}
	
	//******************************************************
	//공지사항 유효성 체크
	//******************************************************
	function fncValidNotice (){
		//기본 master 정보 유효성 체크
		if($("#txt_title").val() == ""){
			alert("제목이 입력되지 않았습니다.");
			return false;
		}
		
		/* if($("input:checkbox[name='area_Product']").is(":checked") == false){
			alert("제품구분이 선택되지 않았습니다.");
			return false;
		} */
		
		//제품선택 대신 전체 체크로 처리
		/* if($("#area_Product").val() == "0"){
			alert("제품구분이 선택되지 않았습니다.");
			return false;
		} */
		
		return true;
	}
	
	//******************************************************
	//공지사항 저장
	//******************************************************
	function fncSaveNotice (sts) {
		var editorNo = 0; // 페이지당 하나의 에디터만 사용 할 경우 0으로 해도 무관함
   		var tblParam = {};
		
   		tblParam.masterArray = funcGetMaterData();
   		tblParam.editorArray = funcGetEditorHtml(editorNo);
   		tblParam.productArray = funcGetProductData();
   		tblParam.alarmArray = funcGetAlarmData();
   		tblParam.status = sts;
   		tblParam.attachSeqList = attachSeqList; //첨부파일 키
   		console.log(tblParam);
   		
   		$.ajax({
   			type : 'post',
   			contentType: "application/json; charset=utf-8",
   			url : '<c:url value="/board/notice/createNotice.do" />',
   			datatype : 'json',
   			async : false,
   			data : JSON.stringify(tblParam),
   			success : function(data) {
   				if(data.rstCd == "SUCCESS"){
   					alert(data.rstNm);
   					location.href = "/board/notice/noticeListView.do";
   				}
   				else {
   					alert(data.result.rstNm);
   				}
   			},
   			error : function(data) {
   				console.log('공지사항 저장 Error ! >>>> ' + JSON.stringify(data));
   			}
   		});
	}
	
	//******************************************************
	//Master 정보 바인딩
	//******************************************************
	function funcGetMaterData (){
		var masterData = {}; 
		
		var noticeType = "G"; //게시판 코드 값인데.. 일단 임의로 G로 함.
		
		masterData.boardType = noticeType;
		masterData.priorYn = $("input:radio[name=area_NoticeType]:checked").val(); //공지유형
		
		//일반 외 유형일때 노출기간 세팅
		if($("input:radio[name=area_NoticeType]:checked").val() != "4"){
			masterData.fromDt = Pudd("#area_Date").getPuddObject().getDate().startDate.replace(/-/gi, ""); // 시작일자
			masterData.toDt = Pudd("#area_Date").getPuddObject().getDate().endDate.replace(/-/gi, ""); // 종료일자
		}
		masterData.subject = $("#txt_title").val();
		
		return masterData;
	}
	
	//******************************************************
	//제품 정보 바인딩
	//******************************************************
	function funcGetProductData (){
		/* var prodcuctArray = new Array();
		var chkProduct = $("input:checkbox[name='area_Product']:checked").map(function() { return this.value; }).get();
		
		if(chkProduct.length == 0){
			return prodcuctArray;
		}
		
		else {			
			$.each(chkProduct, function(i, value){
				var prodcuctData = {}
				prodcuctData.PRODUCT_CODE = value;
				
				prodcuctArray.push(prodcuctData);
			});
        }
		
		return prodcuctArray; */
		
		//check -> selectbox 값으로 변경. 단일.
		var prodcuctArray = new Array();
		var prodcuctData = {}
		prodcuctData.productCode = $("#area_Product").val();
		prodcuctArray.push(prodcuctData);
		
		return prodcuctArray;
		;
	}
	
	//******************************************************
	//알림 발송 바인딩
	//******************************************************
	function funcGetAlarmData () {
		var alarmArray = new Array();
		var chkAlarm = $("input:checkbox[name='area_Alarm']:checked").map(function() { return this.value; }).get();
		
		if(chkAlarm.length == 0){
			return alarmArray;
		}
		
		else {			
			$.each(chkAlarm, function(i, value){
				var alarmData = {}
				alarmData.alarmCode = value;
				
				alarmArray.push(alarmData);
			});
        }
		
		return alarmArray;
	}
	
	//취소 리스트로 돌아가기
	function fncCancel() {
		location.href = "/board/notice/noticeListView.do";
	}
	
	// 더존웹에디터 로딩 완료 시점에 호출되는 함수	
	function dzLoadComplete(){
		//$("#editorView")[0].contentWindow.fnEditorHtmlLoad("이야이야이야 테스트");
	}
	
	function fncUploadFile(){
		/* 첨부파일 파라미터 정의 */
		$("#uploaderView")[0].contentWindow.BoardType = "G"; // 게시판타입코드(필수)
		$("#uploaderView")[0].contentWindow.BoardSeq = "0"; // 게시판시퀀스(수정시)
		//$("#uploaderView")[0].contentWindow.UploadCallback = "uploadCallBackFnc()"; //부모창 콜백함수 정의(선택)
        $("#uploaderView")[0].contentWindow.fnAttFileUpload(); //첨부파일 업로드 실행
	}
	
	//업로드 성공 후 콜백 함수(필수)
	function uploadCallBackFnc(fData){
		alert("부모창 성공"+fData);
		//fData.attachFileSeq //파일시퀀스
		attachSeqList = fData.attachFileSeq;
	}
	
</script>	
<!-- 1280*1024 기준 해상도에 최적화되어 있음. -->
<div class="iframe_wrap" style="min-width:969px;">
<!-- / 템플릿 시작 / -->		
	<div class="sub_contents_wrap">
		<p class="tit_p">공지사항 등록</p>
		
		<div class="com_ta puddSetup">
			<table>
				<colgroup>
					<col width="120"/>
					<col width=""/>
					<col width="120"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="td_ri">제목</th>
					<td colspan="3"><input type="text" id="txt_title" class="puddSetup" style="text-align:left;" pudd-style="width:45%;" /></td>
				</tr>
				<tr>
					<th class="td_ri">제품구분</th>
					<td colspan="3"><!-- <div id="area_Product"> -->
					<select id="area_Product" class="puddSetup" pudd-style="min-width:180px;" onchange="">
						<option value="0">전체</option>
						<c:forEach var="pdata" items="${productList}" varStatus="status">
							<option value="${pdata.code_seq}">${pdata.code_name}</option>
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<th class="td_ri" >공지유형</th>
					<td>
						<div id="area_NoticeType"></div>
					</td>
					<th class="td_ri">알림발송</th>
					<td><div id="area_Alarm"></div></td>
				</tr>
				<tr id="hid_DateDiv" style="display: none">
					<th class="td_ri" >노출기간 설정</th>
					<td colspan="3"><div id="area_Date"></td>
				</tr>
				<tr>
					<%-- <th class="td_ri">내용</th>
					<td style="height: 600px" colspan="3">
						<!-- dzeditor_no 속성을 추가 (기본은 0, 동일 웹페이지에서 멀티 에디터를 생성하는 경우는 순번) -->
						<iframe id="editorView" dzeditor_no="0" frameborder="0" scrolling="no" width="100%" height="100%"
						src="${pageContext.request.contextPath}/resources/dzeditor/dz_editor_wirte.html" style="width:100%;height:100%;" title="에디터영역"></iframe> 
					</td> --%>
					<!-- yw테스트 시작-->
					<th class="td_ri">내용</th>
					<td style="height: 600px" colspan="3">
						<iframe name="editorView" id="editorView" src="/editorView.do" dzeditor_no="0" style="min-width:100%;height: 100%;"></iframe>
					</td>
					<!-- yw테스트 종료-->
				</tr>
				<%-- 
				<tr>
					<th class="td_ri">첨부파일</th>
					<td colspan="3">
						<form id="form" name="form" method="post" enctype="multipart/form-data" action="/common/fileUploadProc.do">
						<input type="file" name="file0" class="puddSetup" pudd-style="width:45%;" multiple="multiple" />
						</form>
					</td>
				</tr>
				--%>
				<tr>
					<th class="td_ri">첨부파일</th>
					<td colspan="3">
						<div id="uploaderViewDiv">
							<iframe name="uploaderView" id="uploaderView" src="/uploaderView.do" style="min-width:100%;height: 100%;"></iframe>
						</div>						
					</td>
				</tr>
				<%-- 
				<tr>
					<th class="td_ri">첨부파일Test</th>
					<td colspan="3">
						<iframe id="uploaderView" src="/common/fileUploadView.do?uploadMode=U&displayMode=L&allowFileCnt=2" width="650px" height="170px"></iframe>
					</td>
				</tr>
				--%>
			</table>
		</div>
		
		<!-- 하단버튼 -->
		<div class="ac pt10">
			<input type="button" id="btn_Save" class="puddSetup submit" value="저장" />
			<input type="button" id="btn_SaveTmp" value="임시저장" />
			<input type="button" id="btn_Cancel" value="취소" />
		</div>
	</div>
	
<!-- / 템플릿 종료 / -->
</div>
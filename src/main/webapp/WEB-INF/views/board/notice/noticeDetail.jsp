<!-- /**
 * 헬프데스크 공지사항 - 상세뷰
 * jsp명: noticeDetail.jsp  
 * 작성자: 조영욱
 * 수정일자: 2019.08.06 
 */
 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonJquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/dzeditor/js/dze_iframe_function.js"></script>

<script type="text/javascript">
	var BOARD_SEQ = "${BOARD_SEQ}"; 
	
	puddready(function() {
		$("#btn_Modify").click(function () { fncModify(); });
		$("#btn_Cancel").click(function () { fncCancel(); });
		fncControlInit();
	});
	
	function fncControlInit() {
		if(BOARD_SEQ == ""){
			alert("에러");
			return;
		}
		else {
			/* $("#area_Product").fncSetCheckDDL(
					{ 'url' : '<c:url value="/common/retrieveCommonCodeList.do" />', 'async' : false }, 
					{ 'div' : 'etc', 'CD_M_NM' : 'product' }
			); */
			$("#area_NoticeType").fncSetRadioDDL(
				{ 'url' : '<c:url value="/common/retrieveCommonCodeList.do" />', 'async' : false, 'click' : "fncRadioClick();" }, 
				{ 'div' : 'common', 'CD_M_NM' : 'notice_type' }
			);
			$("#area_Alarm").fncSetCheckDDL(
				{ 'url' : '<c:url value="/common/retrieveCommonCodeList.do" />', 'async' : false }, 
				{ 'div' : 'common', 'CD_M_NM' : 'alarm' }
			);
			
			//데이터 가져오기
			fncGetNotice();
		}
	}
	
	//******************************************************
	//데이터 가져오기
	//******************************************************
	function fncGetNotice() {	
		var tblParam = {};
		
   		tblParam.boardSeq = BOARD_SEQ;
   		
   		$.ajax({
   			type : 'post',
   			contentType: "application/json; charset=utf-8",
   			url : '<c:url value="/board/notice/getNotice.do" />',
   			datatype : 'json',
   			async : false,
   			data : JSON.stringify(tblParam),
   			success : function(data) {
   				fncBind(data);
   			},
   			error : function(data) {
   				console.log('데이터 가져오기 Error ! >>>> ' + JSON.stringify(data));
   			}
   		});
	}
	
	//******************************************************
	//데이터 바인딩
	//******************************************************
	function fncBind(data) {	
		$("#lab_Title").text(data.subject);
		//var productSize = $("input:checkbox[name='area_Product']").map(function() { return this.value; }).get();
		var alarmSize = $("input:checkbox[name='area_Alarm']").map(function() { return this.value; }).get();
		
		/* $.each(productSize, function(i, value){
			$.each(data.noticeProductList, function(j, code){
				$("input:checkbox[id=area_Product_" + value +"]").prop("disabled", true);
				if(code.productcode == value){
					$("input:checkbox[id=area_Product_" + value +"]").prop("checked", true);
				}
			});
		}); */
		$.each(alarmSize, function(i, value){
			$("input:checkbox[id=area_Alarm_" + value +"]").prop("disabled", true);
			$.each(data.noticeAlarmList, function(j, code){
				if(code.alarmCode == value){
					$("input:checkbox[id=area_Alarm_" + value +"]").prop("checked", true);
				}
			});
		});
		
		$('input:radio[name=area_NoticeType]:input[value=' + data.priorYn + ']').prop("checked", true);
		$("input:radio[name=area_NoticeType]").prop("disabled", true);
		
		//일반 외 기간 노출
		if(data.priorYn == "4"){
			$("#hid_DateDiv").hide();
		}else {
			$("#hid_DateDiv").show();
			
			Pudd("#area_Date").puddDatePicker({
				typeDisplay : "period",
				periodType : "double",
				startDate : data.fromDt,
				endDate : data.toDt,
				disabled : true
			});
		}
		
		//푸딩 SelectBox 제품구분
		var pList = data.noticeProductList[0];
		var puddObj = Pudd( "#area_Product" ).getPuddObject();
		puddObj.addOption( pList.productCode, pList.productName );
		puddObj.setSelectedIndex( pList.productCode );
		puddObj.setDisabled( true );
		
		//본문 내용
		$("#txta_Content").val(data.content);
		fnLoadContent();
		
		//삭제 게시물은 수정버튼 미노출
		if(data.status == "D"){
			$("#btn_Modify").hide();
		}		
		
		//첨부파일
		var fdata = data.noticeAttachFileList;
		var html = "";
		if (fdata.length > 0){
			for(var k=0; k<fdata.length; k++){
				if(fdata[k].deleteYn == "Y"){
					//파일 삭제 여부에 따라 다운로드링크 제거
					html = "<img src=\"${pageContext.request.contextPath}/resources/Images/ico/ico_clip02.png\"> " + fdata[k].originFileName +"."+ fdata[k].fileExt;
				}else{
					html = "<img src=\"${pageContext.request.contextPath}/resources/Images/ico/ico_clip02.png\"> " + "<a href=\"/fileDownloadProc.do?mType=board&boardType=G&attachSeq="+fdata[k].attachSeq+"\">" + fdata[k].originFileName +"."+ fdata[k].fileExt + "</a>";
				}
				$("#fileList").append("<div class=\"uploadFile\">" + html + "</div>");	
			}
		}
	}
	
	//******************************************************
	//에디터에 넣기
	//******************************************************
	function fnLoadContent() {
		// 더존웹에디터에서 작성된 내용을 전달
		var strContent = document.frmView["txtaContent"].value;

		var objView = document.getElementById("divView");
		objView.innerHTML = strContent;
	}
	
	//******************************************************
	//데이터 수정하기
	//******************************************************
	function fncModify() {   		
   		document.getElementById("listForm").action = "/board/notice/noticeModify.do";
		document.getElementById("BOARD_SEQ").value = BOARD_SEQ;
		document.getElementById("listForm").submit();
	}
	
	//******************************************************
	//취소 리스트로 돌아가기
	//******************************************************
	function fncCancel() {
		location.href = "/board/notice/noticeListView.do";
	}
</script>

<form id="listForm" name="listForm" method="post">
	<input type="hidden" name="BOARD_SEQ" id="BOARD_SEQ" />
</form>

<!-- 더존웹에디터에서 작성된 내용을 읽어온 후 내용을 가지고 있는 Form Start -->
<form name="frmView" method="post" action="설정안함" onsubmit="return false;">
	<textarea name="txtaContent" id="txta_Content" rows="0" cols="0" style="display:none"></textarea>
</form>
<!-- 더존웹에디터에서 작성된 내용을 읽어온 후 내용을 가지고 있는 Form End -->
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
					<td colspan="3"><label id="lab_Title"></label></td>
				</tr>
				<tr>
					<th class="td_ri">제품구분</th>
					<td colspan="3">
					<select id="area_Product" class="puddSetup" pudd-style="min-width:180px;">
					
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
					<td colspan="3"><div id="area_Date"></div></td>
				</tr>
					<tr>
						<th>내용</th>
						<td style="height: 600px" colspan="3">
							<!-- 더존웹에디터에서 작성된 내용을 보여주는 div Start -->
							<div id="divView" style="width:98%; height: 98%;"></div>
							<!-- 더존웹에디터에서 작성된 내용을 보여주는 div End -->
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
							<!-- 파일링크 -->
							<div id="fileList">
								
							</div>
							<!-- <input type="file" name="file_01" class="puddSetup" pudd-style="width:45%;" /> -->
						</td>
					</tr>		
				</table>
			</div>
			
			<!-- 하단버튼 -->
			<div class="ac pt10">
				<input type="button" id="btn_Modify" class="puddSetup submit" value="수정" />
				<input type="button" id="btn_Cancel" class="btn_Cancel" value="취소" />
			</div>
		</div>
		
	<!-- / 템플릿 종료 / -->
	</div>
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

<script type="text/javascript" language="javascript">
	var attachSeqList = ""; //첨부파일 업로드 콜백 시퀀스키
	var isMultiFile = false;
	var isChange = false;
	var filename = "";
	var fileDeleteFlag = false;
	var setContent = "";
	var prodVerSeq = "";
	
	puddready(function() {
		$("#btn_Save").click(function(){ fncSave(); });
		$("#btn_Cancel").click(function () { fncCancel(); });
		$("#btn_DownloadExcelForm").click(function(){ fncDownloadExcelForm(); });
		$("#btn_UploadExcelFile").click(function(){ fncUploadExcelFile(); });
		
		// input, select에 change event가 일어날 경우
		$("input, select").change(function() {
			console.log('변경있음확인');
			isChange = true;
		});

		// 페이지 이동이 있을경우
		$(window).on("beforeunload", function() {
			// 데이터 변경이 있을경우
			if (isChange) {
				return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
			}

		});
	});
	
	
	function fncCheckUploadFileSize() {
		
	    if ($("#fileList").size() > 0) {
	    	if (confirm("기존 등록된 파일은 삭제 됩니다. 새 파일을 업로드 하시겠습니까?")) {
	    		$("#fileList").remove();
	    		return true;
	    	} else {
				return false;
	    	}
		} else {
			return true;
		}
	   
	}
	
	/* 파일 미리보기 start */
	function fncUploadExcelFile() {
		return $("#uploaderView")[0].contentWindow.fnAttFileViewUpload();
	}

	 // 미리보기 데이터 바인드 
	function fncLoadContentExcelView(list) {
		console.log("fncLoadContent started.");
		var subject = "업데이트 내역";
		var startTag = '<p style="font-family:돋움;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;">';
		var endTag = "</p>";
		var brTag = "<br />";
		
		var codeType_0 = "추가/변경/개선"; 
		var codeType_1 = "오류"; 
		
		var codeType_0_subject = ""; 
		var codeType_0_content = ""; 
		
		var codeType_1_subject = ""; 
		var codeType_1_content = ""; 
		
		
		codeType_0_subject += startTag + '<br />' + endTag;
		codeType_0_subject += startTag + '<b>'+codeType_0+'</b>' + endTag + '\n';
		
		codeType_1_subject += startTag + '<br />' + endTag;
		codeType_1_subject += startTag + '<b>'+codeType_1+'</b>' + endTag + '\n';
		
		for (var key in list) {
			
			var value = list[key];
			
			//console.log(Object.keys(value).length);
			
			var type = value[0];
			
			if (type == "0") {
				codeType_0_content += startTag + "- " + value[1] + " : " + value[2] + endTag + '\n';
			} else {
				codeType_1_content += startTag + "- " + value[1] + " : " + value[2] + endTag + '\n';
			}
		
		}
				
		console.log(codeType_0_content);
		console.log(codeType_1_content);
		
		var strContent = "";
		
		strContent += codeType_0_subject + brTag + codeType_0_content + '\n' + brTag ;
		strContent += codeType_1_subject + brTag + codeType_1_content;
		
		setContent = strContent;
		
		return "ok";
	}
	
	function printView(){
		
		if (setContent != "") {
			$("#txta_Content").val(setContent);
			
			var objView = document.getElementById("divView");
			objView.innerHTML = setContent;
		}
	}
	/* 파일 미리보기 ended */
	
	function fncSave(sts) {	
		var bool = fncValid();
		
		if (bool == true) {
			fncSaveVersionInfo(sts); //게시물 컨텐츠 업로드
		}
	}
	
	function fncDownloadExcelForm() {
		
		var $form = $("<form></form>");
		$form.attr('action', "/board/version/downloadExcelForm.do");
		$form.attr('method', "POST");
		$form.attr('name', "excelForm");
		$form.appendTo('body');
		$form.submit();
	}
	
	function fncCancel() {
		if (isChange) {
			// 수정 이력이 있는 경우 알럿 
			if (confirm("저장되지 않은 이력은 삭제됩니다. 취소하시겠습니까?")) {
				self.opener = self;
				opener.parent.location.reload();
				window.close();
			}	
		} else {
			opener.parent.location.reload();
			window.close();
		}
	}
	
	function fncValid() {
		
		// 버전 확인
		if ($("#txt_ProdVer").val() == "") {
			alert("버전을 입력해 주세요.");
			return false;
		}
		
		var filelen = $("#uploaderView")[0].contentWindow.pfileslen;
		$("#uploaderView")[0].contentWindow.isMultiFile = false;
		alert("file update length=" + filelen);
		
		// 업로드할 파일 유무 확인
		if (filelen == 0) {
			alert("파일을 업로드해 주세요.");
			return false;
		}
		
		if (confirm("저장하시겠습니까?")) {
			fncUploadExcelFile();
			console.log("여기 여기 저장할때 업로드?????");
			return true;
		}
		
		return false;
	}
	
	// 첨부파일 삭제
	function deleteLoadUploadFile1(e, aSeq) {
		fileDeleteFlag = true;
		$("#uploaderView")[0].contentWindow.deleteLoadUploadFile(e, aSeq); 
		$("#uploadLoadFile_" + aSeq).remove(); //요소 삭제
	}
	
	function fncSaveVersionInfo() {
		var tblParam = {};
		
		if (setContent != "") {
			$("#txta_Content").val(setContent);
			
			var objView = document.getElementById("divView");
			objView.innerHTML = setContent;
		} else {
			alert('내용 빔');
			return false;
		}
		
		tblParam.prodSeq = $("#area_Product").val(); // 제품 구분
		tblParam.prodVerId = $("#txt_ProdVer").val(); // 버전
		tblParam.deleteYn = "N"; // 삭제 여부
		tblParam.content = setContent;
		tblParam.saveFileName = filename;
		console.log(tblParam);
		
		$.ajax({
			
			type : "POST",
			url : "/board/version/createVersionInfo.do", 
			dataType : "json",
			data : JSON.stringify(tblParam),
			contentType : 'application/json; charset=utf-8',
			success : function(res) {
				if (res.returnValue == "ok") {
					prodVerSeq = res.prodVerSeq;
					fncUploadFile(res.prodVerSeq);
				} else {
					alert('처리에 실패하였습니다.');
					console.log('버전 업데이트 등록 실패');
				}
			}, 
			error : function(e) {
				console.log('버전 업데이트 등록  Error ! >>>> ' + JSON.stringify(e));
			}
		});

	}
	
	// 답변 CA 첨부파일 파라메터 정의
	function fncUploadFile(boardSeq) {
		/* 첨부파일 파라미터 정의 */
		$("#uploaderView")[0].contentWindow.BoardType = "V"; // 게시판타입코드(필수)
		$("#uploaderView")[0].contentWindow.BoardSeq = boardSeq; // 게시판시퀀스(수정시)
        $("#uploaderView")[0].contentWindow.fnAttFileUpload(); // 첨부파일 업로드 실행
	}
	
	//업로드 성공 후 콜백 함수(필수)
	function uploadCallBackFnc(fData){
		alert(fData.attachFileSeq + ", " + prodVerSeq);
		var attachSeq = fData.attachFileSeq;
		var tblParam = {};
		
		tblParam.prodVerSeq = prodVerSeq;
		tblParam.attachSeq = attachSeq;
		
		// { "prodVerSeq" : prodVerSeq , "attachSeq" : attachSeq},
		
		$.ajax({
			
			type : "POST",
			url : "/board/version/updateVersionInfo.do", 
			dataType : "json",
			data : JSON.stringify(tblParam), 
			contentType : 'application/json; charset=utf-8',
			success : function(res) {
				if (res.returnValue == "ok") {
					alert('파일 seq 저장 성공!');
					
					// 첨부파일 업로드, 삭제 후 리로드
					console.log("fileDeleteFlag=" + fileDeleteFlag);
					opener.parent.location.reload();
					window.close();
				} else {
					alert('처리에 실패하였습니다.');
					
				}
			}, 
			error : function(e) {
				console.log('파일 seq 저장  Error ! >>>> ' + JSON.stringify(e));
			}
		});
		

	}
	
	// 제품정보 바인딩 
	function fncGetProductData() {
		var prodcuctData = {};
		prodcuctData.productCode = $("#area_Product").val();
		prodcuctArray.push(prodcuctData);
		
		return prodcuctArray;
	}
	
</script>

<!-- 더존웹에디터에서 작성된 내용을 읽어온 후 내용을 가지고 있는 Form Start -->
<form name="frmView" method="post" action="설정안함" onsubmit="return false;">
	<textarea name="txtaContent" id="txta_Content" rows="0" cols="0" style="display:none"></textarea>
</form>
<!-- 더존웹에디터에서 작성된 내용을 읽어온 후 내용을 가지고 있는 Form End -->

<!-- 1280*1024 기준 해상도에 최적화되어 있음. -->
<div class="iframe_wrap" style="min-width:969px;">
<!-- / 템플릿 시작 / -->
	<div class="sub_contents_wrap">
		<p class="tit_p">업데이트 내역 등록</p>	
		<p class="tit_p">최신버전 등록</p>	
		<div class="com_ta puddSetup">
			<table>
				<colgroup>
					<col width="160"/>
					<col width=""/>
					<col width="160"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>*제품</th>
					<td>
						<select id="area_Product" class="puddSetup" pudd-style="min-width:180px;" onchange="">
							<c:forEach var="pdata" items="${productList}" varStatus="status">
								<option value="${pdata.code_seq}">${pdata.code_name}</option>
							</c:forEach>
						</select>
					</td>
					<th>*버전</th>
					<td>
						<input type="text" id="txt_ProdVer" class="puddSetup" style="text-align:left;" pudd-style="" />
					</td>
				</tr>
				<tr>
					<th>엑셀 양식 다운로드</th>
					<td>
						<input type="button" value="양식 다운" id="btn_DownloadExcelForm"/>
					</td>
					<th>*엑셀 업로드</th>
					<td>
						<div id="uploaderViewDiv" style="width:70%">
							<iframe name="uploaderView" id="uploaderView" src="/uploaderView.do" style="min-width:80%;height: 100%;"></iframe>
						</div>
						<div style="width:20%;">
							<input type="button" value="업로드" id="btn_UploadExcelFile" />
						</div>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mb5 mt5">미리보기	</p>
			</div>
			<br/>
			<div class="com_ta puddSetup">
				<table>
					<colgroup>
						<col width="160"/>
						<col width=""/>
					</colgroup>
					<tr>
						<td>
							<div id="divView" style="width:98%; height: 98%;"></div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 하단버튼 -->
		<div class="ac pt10">
			<input type="button" id="btn_Save" class="puddSetup submit" value="저장" />
			<input type="button" id="btn_Cancel" value="취소" />
		</div>
	</div>

<!-- / 템플릿 종료 / -->
</div>
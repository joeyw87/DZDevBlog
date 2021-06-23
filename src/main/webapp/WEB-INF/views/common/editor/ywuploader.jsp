<!-- /**
 * 헬프데스크 공통 업로더
 * jsp명: uploader.jsp  
 * 작성자: 조영욱
 * 수정일자: 2019.08.02 
 */
 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<style>
 html, body{
   margin: 0;
   overflow: hidden;
 }
 </style>
<!--css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/pudd.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/animate.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/re_pudd.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/attachments.css">
    
<!--js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pudd/pudd-1.1.189.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.min.js"></script>

<script type="text/javascript" language="javascript">

	/* var buildType = "${buildType}";  */
	var UploadCallback = "";
	var BoardType = "";
	var BoardSeq = "";
	
	var maxSize = "${params.maxSize}"; //5MB
	var maxAllSize = "${params.maxAllSize}"; //10MB
	var webPath = "${params.webPath}";
	var pfileslen = 0;
	var filesTempArr = [];
	var filesDelArr = [];
	var fileUploadArr = [];
	
	//dzUpDownloaderArea
	if(parent.document.getElementById("uploaderView") != null){
		parent.document.getElementById("uploaderView").setAttribute("scrolling", "no");
	}
	
	//리사이즈
	$(window).resize(function () {
		fnSetFileAreaHeight();
	});		
	
	$(document).ready(function () {
		fnSetFileAreaHeight();
		
		$("#fileupload").on("change", addFiles);
		
		/* 20190826 윤진추가 */
		if (parent.isMultiFile != null) {
			$("#fileupload").on("click", addFilesCheck);
		}
		
	});
	
	function fnSetFileAreaHeight(){
		var resizeHeight = $('#ywUpDownloader').height();
		$("#uploaderViewDiv", parent.document).height( resizeHeight + 1 );		
	}
	
	/* 기존 첨부파일 로드 */
	function fnLoadUploadFile(fdata, boardType){
		alert('boardType=' + boardType);
		BoardType = boardType;
		
		var html = "";
		for( var i=0; i<fdata.length; i++ ) {
			html = "<img src=\"${pageContext.request.contextPath}/resources/Images/ico/ico_clip02.png\"> " + "<a href=\"/fileDownloadProc.do?mType=board&boardType="+BoardType+"&attachSeq="+fdata[i].attachSeq+"\">" + fdata[i].originFileName +"."+ fdata[i].fileExt + "</a> <img src=\"${pageContext.request.contextPath}/resources/Images/btn/close_btn01.png\" style=\"cursor:pointer\" onclick=\"deleteLoadUploadFile(event, " + fdata[i].attachSeq + ");\">";
			$("#fileLoadList").append("<div id=\"uploadLoadFile_"+fdata[i].attachSeq+"\" >" + html + "</div>");
	    }
		
		fnSetFileAreaHeight();
	}
	
	/* 기존 첨부파일 삭제 */
	function deleteLoadUploadFile(e,aSeq){
		filesDelArr.push(aSeq); //삭제할 첨부시퀀스 추가
		//$("#uploadLoadFile_" + aSeq).remove(); //요소 삭제
		alert("filesDelArr 기존 첨부파일 삭제 ! 뷰에서 제거 > 배열에 저장 시퀀스 >> "+filesDelArr);
		
		fnSetFileAreaHeight();
	}
	
	
	// 파일 추가
	function addFiles(e) {
		pfileslen++;
		
	    var files = e.target.files;
	    var filesArr = Array.prototype.slice.call(files);
	    //파일용량 체크
	    if( !fileSizeChk(filesArr) ){
	    	alert('개별 파일업로드 허용용량 ' +(maxSize/1024/1000) +'MB 를 초과하였습니다.');
	    	$(this).val('');
	    	return;
	    }
	    var filesArrLen = filesArr.length;
	    var filesTempArrLen = filesTempArr.length;
	    for( var i=0; i<filesArrLen; i++ ) {
	        filesTempArr.push(filesArr[i]);
	        $("#fileList").append("<div class=\"uploadFile\">" + "<img src=\"${pageContext.request.contextPath}/resources/Images/ico/ico_clip02.png\"> " + filesArr[i].name + " <img src=\"${pageContext.request.contextPath}/resources/Images/btn/close_btn01.png\" style=\"cursor:pointer\" onclick=\"deleteFile(event, " + (filesTempArrLen+i)+ ");\"></div>");
		    parent.filename = filesTempArr[i].name;
	    }
	    $(this).val('');
	    fnSetFileAreaHeight();
	}
	
	// 파일 삭제
	function deleteFile (eventParam, orderParam) {
	    filesTempArr.splice(orderParam, 1);
	    var innerHtmlTemp = "";
	    var filesTempArrLen = filesTempArr.length;
	    for(var i=0; i<filesTempArrLen; i++) {
	        innerHtmlTemp += "<div class=\"uploadFile\">" + "<img src=\"${pageContext.request.contextPath}/resources/Images/ico/ico_clip02.png\"> " + filesTempArr[i].name + " <img src=\"${pageContext.request.contextPath}/resources/Images/btn/close_btn01.png\" style=\"cursor:pointer\" onclick=\"deleteFile(event, " + i + ");\"></div>"
	    }
	    $("#fileList").html(innerHtmlTemp);
	    
	    fnSetFileAreaHeight();
	}
	
	//파일 사이즈 체크
	function fileSizeChk(file){
		var result = true;
		var fcnt = 0;
		for(var i=0; i<file.length; i++){
			if(maxSize <= file[i].size){
				fcnt++;
			}
		}
		
		if(fcnt > 0){
			result = false;
		}		
		
		return result;
	}
	
	//파일 업로드
	function fnAttFileUpload(){
		
		if (filesTempArr.length > 0) {
		
			var formData = new FormData(); 
			// 파일 데이터
			for(var i=0; i<filesTempArr.length; i++) {
			   formData.append("files" + i, filesTempArr[i]);
			}
			
			formData.append("boardSeq", BoardSeq);
			formData.append("boardType", BoardType);
			
			$.ajax({
			    type : "POST",
			    url : "/fileUploadProcYW.do",
			    data : formData,
			    processData: false,
			    contentType : false,
			    async : false, //동기처리
			    success : function(data) {
			        if(data.resultCode == "SUCCESS"){
			            alert("Success");
			          	//콜백함수 호출
				        if (UploadCallback != "") {
				        	parent.eval(UploadCallback);
				        }else{
				        	parent.uploadCallBackFnc(data);
				        }
			        }else{
			            alert(data.resultCode +": "+data.resultMessage);
			        }
			        
			    },
			    err : function(err) {
			        alert(err.status);
			    }
			});
		} else {
			parent.uploadCallBackFnc();
		}
	}
	
	//파일 삭제 (deleteYn 업데이트, savePath 경로에 있는 파일 삭제)
	function fnAttFileDelete(){
		console.log("filesDelArr=" + filesDelArr);
		
		if (filesDelArr != null && filesDelArr.length > 0) {
			console.log("filesDelArr=" + filesDelArr);
			
			var formData = {};
			formData.attachSeq = filesDelArr;
			
			console.log(formData);
			
			$.ajax({
			    type : "POST",
			    url : "/deleteAttachFile.do",
			    dataType : 'json',
			    data : JSON.stringify(formData),
			    contentType: "application/json; charset=utf-8",
			    success : function(data) {
			    	
			        if (data.returnValue == "ok") {
			            alert("Success");
			          	//콜백함수 호출
				        if (UploadCallback != "") {
				        	parent.eval(UploadCallback);
				        } else {
				        	parent.uploadCallBackFncDel(data);
				        }
			        } else {
			            alert(data.resultCode +": "+data.resultMessage);
			        }
			        
			    },
			    err : function(err) {
			        alert(err.status);
			    }
			});
		} else {
			parent.uploadCallBackFnc();
		}
	}


	function fnAttachView() {
		var extsn = getExtensionOfFilename(selectedFileInfo.fileNm);

		if (extsn == ".pdf") {
			fnInlinePdfView(selectedFileInfo.fileUrl, selectedFileInfo.fileNm,
					selectedFileInfo.fileId);
			return;
		}

		var checkExtsn = ".hwp.doc.docx.ppt.pptx.xls.xlsx";
		var checkExtsnInline = ".jpeg.bmp.gif.jpg.png";
		if (checkExtsnInline.indexOf(extsn) != -1) {

			fnInlineView(selectedFileInfo.fileUrl, selectedFileInfo.fileNm,
					selectedFileInfo.fileId);

		} else if (checkExtsn.indexOf(extsn) != -1) {

			fnDocViewerPop(selectedFileInfo.fileUrl, selectedFileInfo.fileNm,
					selectedFileInfo.fileId);

		} else {
			alert("해당 파일은 지원되지 않는 형식입니다.\n[제공 확장자:pdf, hwp, doc, docx, ppt, pptx, xls, xlsx]");
			return;
		}
	}
	
	//파일 미리보기 업로드
	function fnAttFileViewUpload(){

		if (filesTempArr.length > 0) {
		
			var formData = new FormData(); 
			
			// 파일 데이터
			for (var i = 0; i < filesTempArr.length; i++) {
			   formData.append("files" + i, filesTempArr[i]);
			}
			
			formData.append("boardSeq", BoardSeq);
			formData.append("boardType", BoardType);
			
			$.ajax({
			    type : "POST",
			    url : "/board/version/ExcelToEditorContent.do",
			    data :  formData,
			    processData: false,
			    contentType : false,
			    async : false, 
			    success : function(res) {
			    	
			    	if (res.returnValue == "ok") {
						alert('ok');
						console.log(Object.keys(res.excelList).length);
						var returnValue = parent.fncLoadContentExcelView(res.excelList);
						
						if (returnValue == "ok") {
							parent.printView();	
						}
						
					} else {
						alert('엑셀 미리보기 처리에 실패하였습니다.');
					}
			    	
			    	/*
			        if(data.resultCode == "SUCCESS"){
			            alert("Success");
			          	//콜백함수 호출
				        if (UploadCallback != "") {
				        	parent.eval(UploadCallback);
				        }else{
				        	parent.uploadCallBackFnc(data);
				        }
			        }else{
			            alert(data.resultCode +": "+data.resultMessage);
			        }*/
			        
			    },
			    err : function(err) {
			        alert(err.status);
			    }
			});
		} else {
			alert('파일을 선택해 주세요.');
		}
	}
	
	/* 20190826 윤진추가 */
	function addFilesCheck(e) {

	    pfileslen = filesTempArr.length; 
	    console.log(pfileslen + ", " + parent.isMultiFile);
	   
	    if (!parent.fncCheckUploadFileSize()) {
	    	return false;
	    }
	    
	    if (parent.isMultiFile != null && parent.isMultiFile == false && pfileslen > 0) {
	    	deleteFile(e, 0); 
			$(".uploadFile").remove();
			pfileslen--;
	    }
	    
	    if (parent.uploadfilenum != null && parent.uploadfilenum > 0 && pfileslen > 0) {
	    	deleteFile(e, parent.uploadfilenum);
	    }
	    
		//addFiles(e);
	    console.log("len="+pfileslen);
	}
	
</script>

<body>
<div id="ywUpDownloader" style="">
	<input name="files" id="fileupload" type="file" class="puddSetup" pudd-style="width:100%" multiple />
	<div id="fileLoadList"></div>
	<div id="fileList"></div>
</div>

</body>
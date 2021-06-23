<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<style>
 html, body{
   margin: 0;
   overflow: hidden;
 }
 </style>
 
 
<script>
var EditorLoadYN = "0";
var EditorContents = "";

var g_dzEditorBasePath = "${pageContext.request.contextPath}/resources/dzeditor_v1.1.5.3/";
var g_dzServerBasePath = "${pageContext.request.contextPath}";
var WebPath = "${params.webPath}"; // /upload
var ServerPath = "${params.absolPath}"; // /home/upload
var contentEditor = "${params.contentEditor}"
var op_font = "${params.op_font}";
var op_size = "${params.op_size}";
var op_line = "${params.op_line}";

if(parent.document.getElementById("editorView") != null){
	parent.document.getElementById("editorView").setAttribute("frameborder", "0");
	parent.document.getElementById("editorView").setAttribute("scrolling", "no");
}

</script>
 
<script language="javascript" src="${pageContext.request.contextPath}/resources/dzeditor_v1.1.5.3/js/dze_env_config_bizboxA_doc_box.js"></script>
<!-- 일반 UI -->
<script language="javascript" src="${pageContext.request.contextPath}/resources/dzeditor_v1.1.5.3/js/dze_ui_config_bizboxA_board.js"></script>

<script>

	//lock_yn == 1
	//dzeUiConfig.nCustomFormEditMode = 2;
	
	dzeEnvConfig.strSaveAsPageURL = g_dzServerBasePath + "/common/DzEditorImageUpload.do?type=save_contents&tosavepathurl=" + WebPath + "$" + ServerPath;		//파일-저장하기(SaveAs) Page URL
	dzeEnvConfig.strSavePasteImageURL = g_dzServerBasePath + "/common/DzEditorImageUpload.do?type=paste_image&tosavepathurl=" + WebPath + "$" + ServerPath;	//클립보드 붙여넣기
	dzeEnvConfig.strUploadImageURL = g_dzServerBasePath + "/common/DzEditorImageUpload.do?type=form_upload_image&tosavepathurl=" + WebPath + "$" + ServerPath;//이미지 업로드
	dzeEnvConfig.strOpenFilePageURL = g_dzServerBasePath + "/common/DzEditorImageUpload.do?type=openfile";													//파일-불러오기
	//dzeEnvConfig.strOpenFilePageURL = g_dzServerBasePath + "/resources/dzeditor_v1.1.5.3/server/server_open.jsp";
	dzeEnvConfig.strUploadExtFileURL = g_dzServerBasePath + "/common/DzEditorImageUpload.do?type=form_upload_extfile&tosavepathurl=" + g_dzServerBasePath;	//삽입-개체-파일
	dzeEnvConfig.iFrameLayer = true;
	
	
	dzeUiConfig.strCustomBodyFontFamily = op_font;
	dzeUiConfig.strCustomBodyFontSize = op_size;
	dzeUiConfig.strCustomBodyLineHeight = (parseInt(op_line) / 100).toString();
	dzeUiConfig.bCustomContentPTagStyleApply = true;
	
	//양식HEAD 편집이고 결재라인이 통합통합/분리분리 일경우 에디터 사이즈 조정 불가
	//dzeUiConfig.bCustomTableResizingYN = false;
	
	dzeUiConfig.strLoadingDoneFunction = "loadComplete";
	dzeUiConfig.bCustomEditorWidthPercentageYN = true;
	dzeUiConfig.bCustomEditorHeightIFrameYN = true;
	
	dzeUiConfig.bUseImageToTableMenu = false;
	//dzeUiConfig.strImageToTableURL = "/gw/dzBoxImgConvertPop.do";
	dzeUiConfig.strImageToTableURL = "";
	
    //다국어 처리 X
	dzeUiConfig.strCustomLanguageSetAndLoad = "ko";
		
</script>

<script language="javascript" src="${pageContext.request.contextPath}/resources/dzeditor_v1.1.5.3/js/loadlayer.js"></script>

<script>

function fnEditorHtmlLoad(Content) {
	EditorContents = Content;

	if (EditorLoadYN != "1") {
        setTimeout('fnEditorHtmlLoad(EditorContents)', 500);
        return;
    }
    else {
    	dzeEnvConfig.fnSetEditorHTMLCode(Content, false, 0);	
    }
}

function fnInsertHtml(Content) {
	fnAddHTMLContent(Content, null, 0,0)
}

function fnEditorContents() {
    return dzeEnvConfig.fnGetEditorHTMLCode(false,0);
}

function fnEditorImage(){
	var ImgList = new Array();
	
	DZE_UPLOAD_EVENT.getUploadedFileList(0).forEach(function(value){
    	var ImgInfo = {};
    	ImgInfo.webPath = value.url;
    	ImgInfo.fileName = value.filename;
    	ImgInfo.serverPath = value.url.replace(WebPath, ServerPath);
    	ImgList.push(ImgInfo);		
		});

    return ImgList;
}

function fnTestChangeFormCode(dzeditor_no, type_no)
{
	parent.dzeditorChangeFormCode(dzeditor_no, type_no);
}

window.onload = function() {
	
	LATimeReset();
    EditorLoadYN = "1";
    
    if(parent.fnEditorLoadCallback != null){
    	parent.fnEditorLoadCallback();
    }

}

function loadComplete(dzeditor_no)
{
	try	{
		// 부모창에 해당 함수 구현이 있어야 함
		parent.dzLoadComplete(dzeditor_no);
	} catch(e) {
	}
}

function LATimeReset()
{
	localStorage.setItem("LATime", (+new Date()));	
	setTimeout(function() {LATimeReset();}, 60000);
}

</script>

</head>
	<body>
		<div dzeditor="true"></div>
	</body>
</html>












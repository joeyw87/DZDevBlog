/**************************************************
   common.js
   [수정내역]
   20190708 추가
**************************************************/

/**************************
 * 로그인 계정에 따른 메뉴 노출 
 * 로직은 차츰 생각해야 할 듯
**************************/
function fncAuthCheck() {
}

/**************************
 * 에디터 데이터 가져오기
**************************/
function funcGetEditorHtml(dzeditor_no) {
	var objWin = getEditorIframeWindow(dzeditor_no);
	if(null == objWin) return;

	var editorData = {}; 
	
	editorData.content = objWin.dzeEnvConfig.fnGetEditorHTMLCode(false, dzeditor_no);
		
	return editorData;
}

/**************************
 * 에디터 데이터 가져오기 (답변처리)
**************************/
function funcGetEditorHtmlAnswer(dzeditor_no) {
	var objWin = getEditorIframeWindow(dzeditor_no);
	if(null == objWin) return;

	var editorData = {}; 
	
	editorData.answer = objWin.dzeEnvConfig.fnGetEditorHTMLCode(false, dzeditor_no);
		
	return editorData;
}

/*************************
 * [DATE] yyyymmdd 형태로 포매팅된 오늘 날짜 반환
 * params.createDispDt = (new Date()).yyyymmdd(); 
 * => 20190810 
**************************/
Date.prototype.yyyymmdd = function() {

    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();

    return yyyy + (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);
}

/*************************
 * [DATE] yyyymmdd 를 yyyy-MM-dd로 변환
 * => 2019-08-10 
**************************/
function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

/*************************
 * [DATE] yyyymmdd hh:mm:ss.S 를 yyyy-MM-dd hh:mm:ss로 변환
 * => 2019-08-10 
**************************/
function formatDateFullTime(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear(),
	    hour = '' + d.getHours(),
	    min = '' + d.getMinutes(),
	    sec = '' + d.getSeconds();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    if (hour.length < 2) hour = '0' + hour;
    if (min.length < 2) min = '0' + min;
    if (sec.length < 2)	sec = '0' + sec;

    var frontDate = [year, month, day].join('-');
    var backDate = [hour, min, sec].join(':');
    var dateArr = [frontDate, backDate];
    
    return dateArr.join(" ");
}

/*************************
 * 유저 패스워드 인증 페이지
 * targetUrl 파라미터를 받아 패스워드 인증 후 targetUrl 페이지로 이동
**************************/
function fncPageMoveCertification(targetUrl){
	var param = {};
	
	param.target = targetUrl;	
	
	$.ajax({
		type : "post",
		contentType: "application/json; charset=utf-8",
		url : '/user/login/userCertificationCall.do',
		datatype : 'json',
		async : false,
		data : JSON.stringify(param),
		success : function(res) {
			alert('성공');
		},
		error : function(error) {
			alert("오류 발생" + error);
		}
	});
}

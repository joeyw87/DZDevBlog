<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

//	String strContent = request.getParameter("txtaContent").trim();
//	out.println(strContent);

	String strCR = "\r\n";

	String strHTML = "";
	strHTML += "<html>";
	strHTML += strCR;
	strHTML += "<head>";
	strHTML += strCR;
	strHTML += "<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />";
	strHTML += strCR;
	strHTML += "<title></title>";
	strHTML += strCR;
	strHTML += "</head>";
	strHTML += strCR;
	strHTML += "<body>";
	strHTML += strCR;
	strHTML += request.getParameter("content").trim();
	strHTML += strCR;
	strHTML += "</body>";
	strHTML += strCR;
	strHTML += "</html>";
	strHTML += strCR;


	String strFileName = "duzon_content.html";

	response.setHeader("Pragma","public");
	response.setHeader("Expires","0");
	response.setHeader("Content-Type","application/octet-stream");
	response.setHeader("Content-disposition","attachment; filename=" + strFileName);
	response.setHeader("Content-Transfer-Encoding","binary");

//	response.setContentLength(strContent.length());// 글이 짤리는 현상으로 생략.설정 안하니깐 정상

	out.print(strHTML);
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String strHTML = request.getParameter("contents").trim();
	String strImgList = request.getParameter("imgList").trim().replace("|","<br/>");;

%>

<html>
<head>
<style>
	body {
	font-size:12px;
</style>
</head>
<body>


contents : <br/>
<hr/>
<div style='background-color:#ffffff;padding:5px;font-size:12px'>
<xmp><%=strHTML%></xmp>
</div>
<br>
uploaded file list : <br/>
<hr/>
<div style='background-color:#ffffff;padding:5px;font-size:12px'>
<%=strImgList%>
</div>


</body>
</html>
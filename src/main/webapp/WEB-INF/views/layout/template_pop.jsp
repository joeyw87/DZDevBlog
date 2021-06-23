<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!-- pudding -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/animate.css' />">
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/layout.css' />">
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css' />">
		<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/pudd.css' />">
		<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/re_pudd.css' />">
		    
		<!--js-->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pudd/pudd-1.1.189.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.min.js"></script>
		
		<!-- common -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonJquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paging.js"></script>
    </head>
    
	<script type="text/javascript">
        
    </script>
    
    <body>    

        <div class="contents_wrap">
           	<div class="sub_contents"> 
           		<tiles:insertAttribute name="body" />
           	</div>
        </div>
        
    </body>
</html>
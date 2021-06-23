<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"  %>
<%
/**
 * 
 * @title 테스트 캘린더 페이지 (타임라인)
 * @author 조영욱
 * @since 2020.10.12
 * @version 
 * @dscription 부민병원 테스트 캘린더 페이지
 */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
 <%--   
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.min.js"></script> --%>

<!--full calendar css -->
<link href="<c:url value='/resources/timeline/core/main.css'/>" rel='stylesheet' />
<link href="<c:url value='/resources/timeline/main.css'/>" rel='stylesheet' />
<link href="<c:url value='/resources/timeline/resource-timeline/main.css'/>" rel='stylesheet' />

<!-- full calendar js -->
<script type="text/javascript" src="<c:url value='/resources/timeline/core/main.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/timeline/moment/main.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/timeline/interaction/main.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/timeline/main.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/timeline/common/main.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/timeline/resource-timeline/main.js'/>"></script>

<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');

	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'resourceTimelineFourDays',
		  views: {
		    resourceTimelineFourDays: {
		      type: 'resourceTimeline',
		      duration: { days: 4 }
		    }
		  }
	});

	calendar.render();
	 
});

</script>
<div id="loadingProgressBar"></div>
<div class="sub_wrap">
	<div class="sub_contents">
		<!-- iframe wrap -->
		<div class="iframe_wrap">
			<div class="location_info">
				 <ul id="menuHistory">
				 </ul>
			</div>
			<!-- 화면타이틀 -->
			<div class="title_div">
			</div>

			<!-- 컨텐츠내용영역 -->
			<div class="sub_contents_wrap">
				<div id='calendar'></div>
			</div>
		</div>
	</div>
</div>

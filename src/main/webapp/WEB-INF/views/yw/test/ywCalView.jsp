<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"  %>
<%
/**
 * 
 * @title 테스트 캘린더 페이지
 * @author 조영욱
 * @since 2020.10.06
 * @version 
 * @dscription 부민병원 테스트 캘린더 페이지
 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
   
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.min.js"></script>

<style type="text/css" >
	.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
	    position: fixed;
	    left:0;
	    right:0;
	    top:0;
	    bottom:0;
	}
    .wrap-loading div{ /*로딩 이미지*/
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -21px;
        margin-top: -21px;
        z-index:9999;
    }
    .display-none{ /*감추기*/
        display:none;
    }
    /* #syncType-button{display:none;} */
</style>

<script type="text/javascript">

var userSe = ""; //로그인 사용자 권한

	$(document).ready(function() {
        		
	});
		
</script>
</head>
<div class="wrap-loading display-none">
    <div><img src="${pageContext.request.contextPath}/resources/Images/ico/loading.gif" /></div>
</div>  
<div class="sub_wrap">
	<div class="sub_contents">	             
        <!-- 여기서부터 컨텐츠 아이프레임 영역 -->
		<!-- iframe wrap -->
		<div class="iframe_wrap" style="min-width:1100px;">
		
			<!-- 컨텐츠타이틀영역 -->
			<div class="sub_title_wrap">
				<div class="location_info">
					 <ul>
						<li><a href="#n"><img src="${pageContext.request.contextPath}/resources/Images/ico/ico_home01.png" alt="홈"></a></li>
						<li><a href="#n">시스템설정</a></li>
						<li><a href="#n">조직도연동정보</a></li>
						<li class="on"><a href="#n">IM연동정보내역</a></li>
					 </ul>
				</div>
				<div class="title_div">
					<h4>연동정보내역</h4>
				</div>
			</div>
			
			<!-- 검색 -->
			<div class="top_box">										
				<dl class="dl1">
					<dt>동기화기간</dt>
					<dd><input type="text" value="" class="puddSetup" pudd-type="datepicker" id="startDate"/>
					~ <input type="text" value="" class="puddSetup" pudd-type="datepicker" id="endDate"/></dd>
										
					<dt>동기화구분</dt>
					<dd>
						<select id="syncGbn" class="puddSetup" pudd-style="width:110px;">
							<option value="">전체</option>
							<option value="M">수동</option>
							<option value="S">자동(스케줄)</option>
						</select>
					</dd>
					
					<dd><input type="button" id="btnSearch" class="puddSetup" value="검색" style="background:#03a9f4;color:#fff" /></dd>
				</dl>								
			</div>
			
			<!-- 컨텐츠내용영역 -->
			<div class="sub_contents_wrap">	
				<div class="btn_div">			
					<div class="right_div">
						<div class="controll_btn p0">
							<input type="button" id="btnSync" class="puddSetup" value="수동 동기화">
						</div>
					</div>
				</div>
				<div id="grid"></div>
				
				하이하이	
			</div>				
		</div><!-- iframe wrap -->
		<!-- //여기까지 컨텐츠 아이프레임 영역 -->
	</div>
</div>

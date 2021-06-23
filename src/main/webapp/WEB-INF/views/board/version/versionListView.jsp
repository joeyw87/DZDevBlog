<!-- 공지사항 - 업데이트 내역 페이지 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="now"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMddKKmmss" /></c:set>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paging.js"></script>

<script type="text/javascript">
	puddready(function() {
		
	});

</script>

<div id="loadingProgressBar"></div>
	
<!-- 템플릿 -->
<div class="sub_contents_wrap" style="">

	<p class="tit_p">업데이트 내역</p>
	<p class="tit_p">업데이트 상세내역</p>
	
	<div id="tGrid"></div>
	
	<div class="puddSetup" pudd-type="textfolding" pudd-init-status="on" 
		pudd-box-type="button" pudd-open-name="더보기" pudd-fold-name="접기" 	style="">
			<label>v 1.2.85 업데이트 내역</label>
			<label>추가/변경/개선</label>
			<p>
			</p>
	</div>
		
	<br/>
	<div class="puddSetup" pudd-type="textfolding" pudd-init-status="on" 
			pudd-box-type="button" pudd-open-name="더보기" pudd-fold-name="접기" >
			- 결재(영리)	: 결재리스트 열람 전/후 스크롤위치 고정
			- 결재(영리)	: 결재리스트 열람 전/후 스크롤위치 고정
			- 결재(영리)	: 결재리스트 열람 전/후 스크롤위치 고정

		<div>
			- 결재(영리)	: 결재리스트 열람 전/후 스크롤위치 고정
			- 결재(영리)	: 결재리스트 열람 전/후 스크롤위치 고정
			- 결재(영리)	: 결재리스트 열람 전/후 스크롤위치 고정
		</div>
	</div>
</div>
<!-- / 템플릿 종료 / -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>


<script type="text/javascript">
	puddready(function() {
	
		$("#btn_Notice").click(function () { fucMoveNoticeListPage(); });
		$("#btn_VersionUpdate").click(function () { fucMoveVersionUpdateListPage(); });
		$("#btn_CreateVersionUpdate").click(function () { fucMoveVersionManageListPage(); });
		$("#btn_BlueMembership").click(function () { fucMoveBlueMembershipPage(); });
		$("#btn_RemoteService").click(function () {	fucMoveRemoteServicePage(); });
	
	});

	// 공지사항
	function fucMoveNoticeListPage() {
		location.href = "/board/notice/noticeListView.do";
	}
	
	// 업데이트 내역
	function fucMoveVersionUpdateListPage() {
		location.href = "/board/version/versionListView.do";
	}
	
	// 업데이트 내역 등록 
	function fucMoveVersionManageListPage() {
		location.href = "/board/version/versionManageList.do";
	}
	
	// 블루멤버십
	function fucMoveBlueMembershipPage() {
		location.href = "/consult/consultWriteView.do";
	}

	// 원격지원
	function fucMoveRemoteServicePage() {
		location.href = "/consult/consultWriteView.do";
	}
	
</script>

<h1> 나의 상담 </h1>

<div> 
	<input type="button" id="btn_Notice" value="공지사항">
</div>
<div>
	<input type="button" id="btn_VersionUpdate" value="업데이트 내역">
</div>
<div>
	<input type="button" id="btn_CreateVersionUpdate" value="(임시) 업데이트 내역 등록">
</div>
<div>
	<input type="button" id="btn_BlueMembership" value="블루멤버십">
</div>
<div>
	<input type="button" id="btn_RemoteService" value="원격지원">
</div>
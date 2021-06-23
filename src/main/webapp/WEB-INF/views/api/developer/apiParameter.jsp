<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".oneDiv").hide();
			$(".twoDiv").hide();
			$("#one").click(function() {
				$(".oneDiv").show();
				$(".twoDiv").hide();
			});
			
			$("#two").click(function() {
				$(".oneDiv").hide();
				$(".twoDiv").show();
			});
		});
	</script>

    <!-- Page Heading -->
    <h1 class="h3 mb-1 text-gray-800">영리 API Parameter</h1>
    <p class="mb-4">외부시스템 전자결재 연동 Web API(API 파라미터) 페이지입니다</p>

	<div class="row">
    	<div class="col-lg-6">
			<div class="card mb-4 border-left-success">
	          	<div class="card-body">
	              <div class="mb-2">
	               	찾을려고 하는  <code>API 파라미터</code>를 선택하세요
	              </div>
	              <div class="dropdown no-arrow">
	           		<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                  	선택
	                </button>
	                <div class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton">
	                  <a class="dropdown-item" id="one">첨부파일 전송 API (Other System -> Bizbox Alpha)</a>
	                  <a class="dropdown-item" id="two">전자결재 문서작성(SSO 호출) API (Other System -> Bizbox Alpha) </a>
	                  <a class="dropdown-item" id="three">연동 본문 정보 조회 API (Other System -> Bizbox Alpha)</a>
	                </div>
	              </div>
	            </div>
	         </div>
         </div>
    </div>

	<div class="oneDiv">
		<div class="row">
			<div class="col-lg-6">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">Request</h6>
					</div>
					<div class="card-body">
						<pre>URL 정보 : /gw/outProcessUpload.do </pre>
						<pre>HTTP Method : POST, Multipart </pre> 
						<pre>파일정보 : MultipartFile</pre>
						<pre>삭제가능여부 : deleteYn</pre>
						<pre>그룹웨어 회사코드 : compSeq</pre>
						<pre>그룹웨어 로그인 id: loginId</pre>
						<pre>그룹웨어 사번 : empSeq</pre>
						<pre>ERP 사번 : empSeq</pre>
					</div>
				</div>
			</div>
	        
			<div class="col-lg-6">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">response</h6>
					</div>
					<div class="card-body">
						<pre>결재코드 : resultCode</pre>
						<pre>결과 메시지 : resultMessage</pre>
						<pre>파일 인터페이스 키  : fileKey</pre>
					</div>
				</div>
			</div>
		</div>
	
		<div class="row">
			<div class="col-lg-6">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">example</h6>
					</div>
					<div class="card-body">
						<pre><code class="json">성공  : {"resultCode":"1", "resultMessage":"성공", "fileKey":"fbeb1761dd3811e6a9679c8e994bf9a c",} </code></pre>
						<pre><code class="json">실패  : {"resultCode":"-1", "resultMessage":"실패", "fileKey":"", } </code></pre>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	<div class="twoDiv">
		<div class="row">
			<div class="col-lg-6">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">Request</h6>
					</div>
					<div class="card-body">
						<pre>URL 정보 : http(s)//도메인/gw/outProcessLogOn.do </pre>
						<pre>HTTP Method : GET </pre> 
						<pre>그룹웨어 회사코드 : empSeq 로 호출인 경우 compSeq (필수)</pre>
						<pre>외부시스템 연동키 : approKey</pre>
						<pre>외부시스템 연동코드: outProcessCode</pre>
						<pre>그룹웨어 로그인 id: loginId</pre>
						<pre>그룹웨어 사번 : empSeq( compSeq 필수 )</pre>
						<pre>ERP 사번 : empSeq</pre>
						<pre>부서코드 : deptCd</pre>
						<pre>부서시퀀스 : deptSeq</pre>
						<pre>파일인터페이스 키 : fileKey</pre>
					</div>
				</div>
				
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">sample</h6>
					</div>
					<div class="card-body">
						<pre><code class="json">gw/outProcessLogOn.do?compSeq=1000&approKey=ERPAPP00001&outProcessCode=ATTTest002&formId=53&loginId=park123&fileKey=fbeb1761d d3811e6a9679c8e994bf9ac&mod=W</code></pre>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

	<script type="text/javascript">
		var g_oldVal = "";
		$(document).ready(function() {
	
			//로그인ID input 이벤트 처리	
			$("#btn_loginId").click(function() {
				getLoginIdEnc(); //암호화 처리
			});
			
			//암호화 로그인ID input 이벤트 처리	
			$("#btn_loginIdEnc").click(function() {
				getLoginIdEncRollBack(); //암호화 처리
			});
			
			//암호화 ssoKey input 이벤트 처리	
			$("#btn_ssoKey").click(function() {
				getSsoKeyEnc(); //암호화 처리
			});
	
		});
	
		//사용자 로그인 암호화키 가져오기
		function getLoginIdEnc() {
	
			var gwLoginId = $('#loginId').val();
			if (gwLoginId == "") {
				alert('그룹웨어 로그인ID를 입력해주세요.');
				return;
			}
	
			var sendParam = {};
			sendParam.gwLoginId = gwLoginId;
	
			$.ajax({
				type : "POST",
				dataType : "json",
				async : false,
				url : "${pageContext.request.contextPath}/api/test/getLoginIdEnc.do",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(sendParam),
				success : function(data) {
					if (data.resultCode == "SUCCESS") {
						$('#loginId').val(data.loginIdEnc);
						$('.inp_loginId').addClass('was-validated'); //로그인아이디 값 체크
					} else {
						alert(data.resultCode + ": " + data.resultMsg);
					}
				},
				error : function(data) {
					alert("로그인ID 암호화 실패.");
					console.log('Error ! >>>> ' + data.result);
				}

			});			
		}
		
		//사용자 로그인 암호화 복호화 가져오기
		function getLoginIdEncRollBack() {
	
			var gwLoginIdEnc = $('#loginIdEnc').val();
			if (gwLoginIdEnc == "") {
				alert('암호화된 loginId값을 입력해주세요.');
				return;
			}
	
			var sendParam = {};
			sendParam.gwLoginIdEnc = gwLoginIdEnc;
	
			$.ajax({
				type : "POST",
				dataType : "json",
				async : false,
				url : "${pageContext.request.contextPath}/api/test/getLoginIdEncRollBack.do",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(sendParam),
				success : function(data) {
					if (data.resultCode == "SUCCESS") {
						if(data.loginIdDec == ""){
							alert("인코딩값이 형식에 맞지 않습니다.");
							$('#loginIdEnc').val("");
						}else{
							$('#loginIdEnc').val(data.loginIdDec);
							$('.inp_loginIdEnc').addClass('was-validated'); //로그인아이디 값 체크
						}
						
					} else {
						alert(data.resultCode + ": " + data.resultMsg);
					}
				},
				error : function(data) {
					alert("로그인ID 디코딩 실패.");
					console.log('Error ! >>>> ' + data.result);
				}

			});
		}
		
		
		//ssoKey 암호화키 가져오기
		function getSsoKeyEnc() {
	
			var ssoKeyStr = $('#ssoKey').val();
			if (ssoKeyStr == "") {
				alert('인코딩할 아이디를 입력해주세요.');
				return;
			}
	
			var sendParam = {};
			sendParam.ssoKeyStr = ssoKeyStr;
	
			$.ajax({
				type : "POST",
				dataType : "json",
				async : false,
				url : "${pageContext.request.contextPath}/api/test/getSsoKeyEnc.do",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(sendParam),
				success : function(data) {
					if (data.resultCode == "SUCCESS") {
						$('#ssoKey').val(data.ssoKeyEnc);
						$('.inp_ssoKey').addClass('was-validated'); //로그인아이디 값 체크
					} else {
						alert(data.resultCode + ": " + data.resultMsg);
					}
				},
				error : function(data) {
					alert("ssoKey 암호화 실패.");
					console.log('Error ! >>>> ' + data.result);
				}

			});			
		}
		
		//API 삭제처리 JSON 리턴 테스트
		function deleteApiCall() {
	
			var gwLoginId = $('#loginId').val();
			if (gwLoginId == "") {
				alert('그룹웨어 로그인ID를 입력해주세요.');
				return;
			}
	
			var sendParam = {};
			sendParam.gwUrl = $('#inp_url').val();
			sendParam.gwLoginId = gwLoginId;
			sendParam.mod = "D";
			sendParam.approKey = $('#approKey').val();
			sendParam.outProcessCode = $('#outProcessCode').val();
	
			$.ajax({
				type : "POST",
				dataType : "json",
				async : false,
				url : "${pageContext.request.contextPath}/api/test/deleteApiCall.do",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(sendParam),
				success : function(data) {
					if (data.resultCode == "SUCCESS") {
						alert('삭제처리 성공.');
					} else {
						alert(data.resultCode + ": " + data.resultMsg);
					}
				},
				error : function(data) {
					alert("로그인ID 암호화 실패.");
					console.log('Error ! >>>> ' + data.result);
				}

			});
		}
		
		//API 삭제처리 JSON 리턴 테스트2
		function fnDirectDelTest(){
			//formApproval.loginId.value = $('#loginId').val();
			//formApproval.approKey.value = $('#approKey').val();
			//$("#formApproval").submit();
			//var params = $('#formApproval').serialize();
			
			var tblParam = {};
			tblParam.loginId = $('#loginId').val();
			tblParam.outProcessCode = $('#outProcessCode').val();
			tblParam.approKey = $('#approKey').val();
			tblParam.mod = 'D';
						
			$.ajax({
				type : "GET",
				dataType : "json",
	            crossDomain: true,
				async : false,
				url : "http://58.224.117.51/gw/outProcessEncLogOn.do",
				//contentType: "application/x-www-form-urlencoded; charset=utf-8",
				xhrFields: {
		              withCredentials: true
		            },
				data : tblParam,
				success : function(data) {
					if (data.resultCode == "SUCCESS") {
						$('#loginIdEnc').val(data.loginIdDec);
					} else {
						alert(data.resultCode + ": " + data.resultMsg);
					}
				},
				error : function(data) {
					alert("실패.");
					console.log('Error ! >>>> ' + data.result);
				}

			});
		}
		
		/* interlock 문서삭제 API 테스트 */
		function fnInterlockDelTest(){
			
			var tblParam = {};
			tblParam.loginId = $('#loginId').val();
			tblParam.outProcessCode = 'CUST_ERP01';
			tblParam.approKey = $('#approKey').val();
			tblParam.mod = 'D';
			
			$.ajax({
				type : "POST",
				dataType : "json",
				async : false,
				url : "${pageContext.request.contextPath}/api/test/eaDocDeleteApi.do",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(tblParam),
				success : function(data) {
					if (data.resultCode == "SUCCESS") {
						
					} else {
						alert(data.resultCode + ": " + data.resultMessage);
					}
				},
				error : function(data) {
					alert("실패.");
					console.log('Error ! >>>> ' + data.result);
				}

			});
		}
	
		/* API 호출 테스트 */
		function fncApiCall() {
			
			$('.form-group').addClass('was-validated'); //값 체크
			
			//전자결재 팝업 오픈
			var pop = window.open("", "apiEaPop",
					"width=799,height=769,scrollbars=no");
			setTimeout(function() {
				gwForm.target = "apiEaPop";
				gwForm.action = $('#inp_url').val();
				gwForm.submit();
				pop.focus();
			}, 1000);
	
		}
	</script>


<!-- Page Heading -->
<h1 class="h3 mb-4 text-gray-800">API TEST PAGE</h1>

<div class="row">

	<div class="col-lg-6">
		<!-- Brand Buttons -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">외부시스템 전자결재 API TEST</h6>
			</div>
			<div class="card-body">
				<form id="gwForm" name="gwForm" method="post" class="">
					<input type="text" id="inp_url"
						class="form-control bg-light border-0 small" placeholder="호출 URL"
						value="http://58.224.117.51/gw/outProcessEncLogOn.do"> <br />
					<!-- <div class="input-group">
                           	 	<label for="uname1">Username:</label><br>
                          <input type="text" name="loginId" id="loginId" class="form-control bg-light border-0 small" placeholder="loginId" aria-label="Search" aria-describedby="basic-addon2">
                          <div class="input-group-append">
                              <button id="btn_loginId" class="btn btn-primary" type="button">
							<i class="fas fas fa-arrow-right fa-sm"></i> 변환
                              </button>
                          </div>
                      </div> -->
					<!-- 로그인아이디 인풋 그룹S -->
					<div class="form-group">
						<label for="loginId">LoginId:</label>
						<div class="input-group inp_loginId">
							<input type="text" name="loginId" id="loginId"
								class="form-control bg-light border-0 small"
								placeholder="loginId" aria-label="Search"
								aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button id="btn_loginId" class="btn btn-primary" type="button">
									<i class="fas fas fa-arrow-right fa-sm"></i> 변환
								</button>
							</div>
							<div class="valid-feedback">인코딩 성공.</div>
							<div class="invalid-feedback">로그인ID를 입력해주세요.</div>
						</div>
					</div>
					<!-- 로그인아이디 인풋 그룹E -->
					<div class="form-group">
						<label for="outProcessCode">outProcessCode:</label> <input type="text"
							class="form-control" id="outProcessCode" placeholder="외부시스템연동코드"
							name="outProcessCode" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">외부시스템 연동코드를 입력해주세요.</div>
					</div>
					<div class="form-group">
						<label for="approKey">approKey:</label> <input type="text"
							class="form-control" id="approKey" placeholder="외부연동키"
							name="approKey" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">외부시스템 연동코드를 입력해주세요.</div>
					</div>
					<div class="form-group">
						<label for="mod">mod:</label> <input type="text"
							class="form-control" id="mod" placeholder="모드(W:작성, V:보기, D:삭제, R:회수)"
							name="mod" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">모드를 입력해주세요.</div>
					</div>
					<div class="form-group">
						<label for="formId">formId:</label> <input type="text"
							class="form-control" id="formId" placeholder="양식아이디"
							name="formId">
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">양식아이디를 입력해주세요.</div>
					</div>
					<div class="form-group">
						<label for="subjectStr">subjectStr:</label> <input type="text"
							class="form-control" id="subjectStr" placeholder="제목"
							name="subjectStr" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">제목을 입력해주세요.</div>
					</div>
					<div class="form-group">
						<label for="contentsStr">contentsStr:</label> 
						<textarea class="form-control" id="contentsStr" placeholder="본문(내용)" name="contentsStr" rows="3"></textarea>						
					</div>
					<div class="form-group">
						<label for="deptSeq">deptSeq:</label> <input type="text"
							class="form-control" id="deptSeq" placeholder="부서시퀀스"
							name="deptSeq">
						<!-- <div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">외부시스템 연동코드를 입력해주세요.</div> -->
					</div>
					<div class="form-group">
						<label for="receiveList">receiveList:</label> <input type="text"
							class="form-control" id="receiveList" placeholder="수신참조/시행자/수신처 리스트"
							name="receiveList">
						<!-- <div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">외부시스템 연동코드를 입력해주세요.</div> -->
					</div>
					
					<!-- <input type="text" name="outProcessCode"
						class="form-control bg-light border-0 small"
						placeholder="outProcessCode"> <br /> <input type="text"
						name="approKey" class="form-control bg-light border-0 small"
						placeholder="approKey"> <br /> <input type="text"
						name="mod" class="form-control bg-light border-0 small"
						placeholder="mod"> <br /> <input type="text"
						name="formId" class="form-control bg-light border-0 small"
						placeholder="formId"> <br /> <input type="text"
						name="subjectStr" class="form-control bg-light border-0 small"
						placeholder="subjectStr"> <br /> <input type="text"
						name="contentsStr" class="form-control bg-light border-0 small"
						placeholder="contentsStr"> <br /> <input type="text"
						name="deptSeq" class="form-control bg-light border-0 small"
						placeholder="deptSeq"> <br /> -->
					
					<input type="hidden" name="contentsEnc" value="U" />
				</form>
				<br /> 
				<input type="button" class="btn btn-primary" value="API호출(팝업)" onclick="javascript:fncApiCall()" />
				<!-- <input type="button" class="btn btn-primary" value="API삭제호출(json)" onclick="javascript:deleteApiCall()" /> -->
				<!-- <input type="button" class="btn btn-primary" value="API삭제직접호출" onclick="javascript:fnDirectDelTest()" /> -->
				<!-- <input type="button" class="btn btn-primary" value="API삭제호출(interlock)" onclick="javascript:fnInterlockDelTest()" /> -->				
			</div>
		</div>

	</div>



	<div class="col-lg-6">

		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Split Buttons
					with Icon</h6>
			</div>
			<div class="card-body">
				<p>
					Works with any button colors, just use the
					<code>.btn-icon-split</code>
					class and the markup in the examples below. The examples below also
					use the
					<code>.text-white-50</code>
					helper class on the icons for additional styling, but it is not
					required.
				</p>
				<a href="#" class="btn btn-primary btn-icon-split"> <span
					class="icon text-white-50"> <i class="fas fa-flag"></i>
				</span> <span class="text">Split Button Primary</span>
				</a>
				<div class="my-2"></div>
				<a href="#" class="btn btn-success btn-icon-split"> <span
					class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Split Button Success</span>
				</a>
				<div class="my-2"></div>
				<a href="#" class="btn btn-info btn-icon-split"> <span
					class="icon text-white-50"> <i class="fas fa-info-circle"></i>
				</span> <span class="text">Split Button Info</span>
				</a>
				<div class="my-2"></div>
				<a href="#" class="btn btn-warning btn-icon-split"> <span
					class="icon text-white-50"> <i
						class="fas fa-exclamation-triangle"></i>
				</span> <span class="text">Split Button Warning</span>
				</a>
				<div class="my-2"></div>
				<a href="#" class="btn btn-danger btn-icon-split"> <span
					class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Split Button Danger</span>
				</a>
				<div class="my-2"></div>
				<a href="#" class="btn btn-secondary btn-icon-split"> <span
					class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
				</span> <span class="text">Split Button Secondary</span>
				</a>
				<div class="my-2"></div>
				<a href="#" class="btn btn-light btn-icon-split"> <span
					class="icon text-gray-600"> <i class="fas fa-arrow-right"></i>
				</span> <span class="text">Split Button Light</span>
				</a>
				<div class="mb-4"></div>
				<p>Also works with small and large button classes!</p>
				<a href="#" class="btn btn-primary btn-icon-split btn-sm"> <span
					class="icon text-white-50"> <i class="fas fa-flag"></i>
				</span> <span class="text">Split Button Small</span>
				</a>
				<div class="my-2"></div>
				<a href="#" class="btn btn-primary btn-icon-split btn-lg"> <span
					class="icon text-white-50"> <i class="fas fa-flag"></i>
				</span> <span class="text">Split Button Large</span>
				</a>
			</div>
		</div>

	</div>
	
	
	<div class="col-lg-6">

		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">ETC</h6>
			</div>
			<div class="card-body">
				
				<div class="form-group">
					<label for="loginIdEnc">LoginId 디코딩:</label>
					<div class="input-group inp_loginIdEnc">
						<input type="text" name="loginIdEnc" id="loginIdEnc"
							class="form-control bg-light border-0 small"
							placeholder="loginIdEnc" aria-label="Search"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button id="btn_loginIdEnc" class="btn btn-primary" type="button">
								<i class="fas fas fa-arrow-right fa-sm"></i> 변환
							</button>
						</div>
						<div class="valid-feedback">디코딩 성공.</div>
						<div class="invalid-feedback">암호화된 로그인ID를 입력해주세요.</div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="ssoKey">ssoKey 인코딩:</label>
					<div class="input-group inp_ssoKey">
						<input type="text" name="ssoKey" id="ssoKey"
							class="form-control bg-light border-0 small"
							placeholder="ssoKey" aria-label="Search"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button id="btn_ssoKey" class="btn btn-primary" type="button">
								<i class="fas fas fa-arrow-right fa-sm"></i> 변환
							</button>
						</div>
						<div class="valid-feedback">디코딩 성공.</div>
						<div class="invalid-feedback">암호화된 로그인ID를 입력해주세요.</div>
					</div>
				</div>
			</div>
		</div>

	</div>

</div>


<form id="formApproval" method="post" action="http://58.224.117.51/gw/outProcessEncLogOn.do">
	<input type="hidden" name="loginId" value="" />
	<input type="hidden" name="outProcessCode" value="CUST_ERP01" />
	<input type="hidden" name="approKey" value="" />
	<input type="hidden" name="mod" value="D" />
</form>
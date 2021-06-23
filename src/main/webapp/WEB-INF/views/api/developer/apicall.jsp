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
	
			$
					.ajax({
						type : "POST",
						dataType : "json",
						async : false,
						url : "${pageContext.request.contextPath}/api/test/getLoginIdEnc.do",
						contentType : "application/json; charset=utf-8",
						data : JSON.stringify(sendParam),
						success : function(data) {
							if (data.resultCode == "SUCCESS") {
								$('#loginId').val(data.loginIdEnc);
							} else {
								alert(data.resultCode + ": " + data.resultMsg);
							}
						},
						error : function(data) {
							alert("로그인ID 암호화 실패.");
							console.log('Error ! >>>> ' + data.result);
						}
	
					});
	
			$('#gwForm').addClass('was-validated');
		}
	
		/* API 호출 테스트 */
		function fncApiCall() {
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
<h1 class="h3 mb-4 text-gray-800">API TEST</h1>

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
						value="http://58.224.117.52/gw/outProcessEncLogOn.do"> <br />
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
						<label for="ulogin">LoginId:</label>
						<div class="input-group">
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
						<label for="uname">Username:</label> <input type="text"
							class="form-control" id="uname" placeholder="Enter username"
							name="uname" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">외부시스템 연동코드를 입력해주세요.</div>
					</div>
					<input type="text" name="outProcessCode"
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
						placeholder="deptSeq"> <br />
					<textarea class="form-control" rows="3"></textarea>
					<input type="hidden" name="contentsEnc" value="U" />
				</form>
				<br /> <input type="button" class="btn btn-primary"
					value="API호출(팝업)" onclick="javascript:fncApiCall()" />
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

</div>
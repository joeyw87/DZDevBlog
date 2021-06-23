<!-- /**
 * 코드관리 조회페이지
 * jsp명: codeManageView.jsp  
 * 작성자: 조영욱
 * 수정일자: 2019.08.27 
 */
 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!--css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/pudd.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/animate.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/re_pudd.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/attachments.css">
    
<!--js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pudd/pudd-1.1.189.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.min.js"></script>

<script type="text/javascript" language="javascript">

	var gProduct = "1";
	var gUseYn = "";
	
	$(document).ready(function () {
		
		fnInit();
		
		bindTree();
		
		resetVal('D');
		
	});
	
	function fnInit(){
		//제품구분 이벤트
		$("#sel_product").change(function() {
			gProduct = this.value;
			bindTree();
			resetVal('D'); //분류상세 초기화
		});
		
		//사용여부 이벤트
		$("#sel_useYn").change(function() {
			if( this.value == "A"){
				gUseYn = ""; //전체
			}else{
				gUseYn = this.value;
			}			
			bindTree();
		});
		
		$("#btnNew").click( function() { //신규
			fnNew();
	    });
		$("#btnSave").click( function() { //저장
			fnSave();
	    });
		$("#btnDelete").click( function() {	//삭제
			fnDelete();
	    });
		$("#btnExistChk").click( function() { //코드중복체크
			fnCodeChk();
	    });
	}
	
	/* 트리 바인드 */
	function bindTree(){
		var url = '${pageContext.request.contextPath}/common/codeManageTreeData.do' + "?prodSeq="+gProduct+"&useYn="+gUseYn;
		var dataSource = new Pudd.Data.DataSource({
		    request: {
		        url: url,
		        type: 'post',
		        dataType: "json"
		    }
		    , result: {
		        model: {
		            id: "seq",
		            children: "items"
		        },
		        data: function(response) {
		            return response.treeList;
		        }
		    }
		});
		
		/* var dataSource = new Pudd.Data.DataSource({
			data : exData
			, pageSize : 9999
			, serverPaging : false
		}); */

		//상담분류트리
		Pudd("#treeview").puddTreeView({
		    dataSource: dataSource,
		    dblclickTreeToggle: true,
		    dataNameField: "text", // tree item name field
		    dataFolderField: "isFolder", // tree folder 여부
		    dataStateField: "state", // state { opened : boolean, selected : boolean, checked : boolean }
		    dataIconField: "icon", // tree item icon - 설정 없으면 folder 아이콘
		    dataNameAttributeField: "textAttribute",
		    dataChildrenField: "children" // tree sub folder & item
		});

		var puddObj = Pudd("#treeview").getPuddObject();
		puddObj.setTreeFolder(true);
		
		Pudd("#treeview").on("treeitemClick", function(e) {
		    var evntVal = e.detail;

		    if (!evntVal) return;
		    if (!evntVal.liObj) return;

		    var liObj = evntVal.liObj;
		    var rowData = liObj.rowData;
		    
		    if(rowData.id != "0"){
		    	var pdata = liObj.parent.rowData; //부모데이터
		    	setDetailVal(pdata,rowData);
		    }else{
		    	resetVal('D');
		    }
		});
		
		resetVal();
	}
	
	/* 분류 값 세팅 */
	function setDetailVal(pdata,data){
		$("#upperNm").val( pdata.text );
		$("#upperNm").attr("disabled", true);
		$("#upperSeq").val( pdata.id );
		$("#upperLevel").val( pdata.level );
		
		$("#codeNm").val( data.text );
		$("#codeNm").attr("disabled", false);
		$("#codeSeq").val( data.id );
		$("#codeSeq").attr("disabled", true);
		$("#codeDesc").val( data.code_desc );
		$("#codeDesc").attr("disabled", false);
		$("#defaultForm").val( data.form_seq );
		$("#defaultForm").attr("disabled", true);
		Pudd( 'input[type="radio"][name="rdoUseYn"][value="'+ data.use_yn + '"]' ).getPuddObject().setChecked(true); //사용여부
		$("#orderNum").val( data.order_num );
		$("#orderNum").attr("disabled", false);
		$("#btnExistChk").attr("disabled", true);
	}
	
	/* 분류 값 초기화 */
	function resetVal(type){		
		$("#upperNm").val("");
		$("#upperSeq").val("");
		$("#upperLevel").val("");
		$("#codeNm").val("");
		$("#codeSeq").val("");
		$("#codeDesc").val("");
		$("#defaultForm").val("");
		$("#orderNum").val("");
		Pudd( 'input[type="radio"][name="rdoUseYn"][value="Y"]' ).getPuddObject().setChecked(true); //사용여부
		$("#codeSeq").attr("disabled", false);
		
		if(type == "D"){
			//전체항목 선택시 비활성화 처리
			$("#upperNm").attr("disabled", true);
			$("#upperSeq").attr("disabled", true);
			$("#upperLevel").attr("disabled", true);
			$("#codeNm").attr("disabled", true);
			$("#codeSeq").attr("disabled", true);
			$("#codeDesc").attr("disabled", true);
			$("#defaultForm").attr("disabled", true);
			$("#orderNum").attr("disabled", true);
			$("#btnExistChk").attr("disabled", true);
		}
	}
	
	/* 코드 중복체크 */
	function fnCodeChk(){
		var codeSeq = $("#codeSeq").val();
		var tblParam = {};
		tblParam.prodSeq = gProduct;
		tblParam.codeSeq = codeSeq;
		
		$.ajax({
   			type : 'post',
   			contentType: "application/json; charset=utf-8",
   			url : '${pageContext.request.contextPath}/common/selectCnsltCode.do',
   			datatype : 'json',
   			async : false,
   			data : JSON.stringify(tblParam),
   			success : function(data) {
   				if(data.result.resultCode == "SUCCESS"){
   					alert("사용가능한 코드입니다.");
   				}else{
   					alert(data.result.resultMessage);
   				}
   			},
   			error : function(data) {
   				console.log('분류코드 저장 Error ! >>>> ' + JSON.stringify(data));
   			}
   		});
		
	}
	
	/* 신규버튼 */
	function fnNew(){
		var puddObj = Pudd( "#treeview" ).getPuddObject();
		var rowData = puddObj.getTreeSelectedItem();
		if( !rowData ) {
			alert('트리를 선택해주세요.');
			return;
		}
		
		var selData = rowData.rowData; //선택된 트리데이터
		if(selData.level == 3){ //최하위 3댑스를 선택하고 신규를 생성할때 
			var parentData = rowData.parent.rowData; //선택된 트리 부모데이터
			$("#upperNm").val(parentData.text);
			$("#upperSeq").val(parentData.id);
			$("#upperLevel").val(parentData.level);
		}else{
			$("#upperNm").val(selData.text);
			$("#upperSeq").val(selData.id);
			$("#upperLevel").val(selData.level);
		}
		
		if(selData.level == 0){
			//선택 트리가 최상위 '전체' 일때
			$("#codeNm").attr("disabled", false);
			$("#codeSeq").attr("disabled", false);
			$("#codeDesc").attr("disabled", false);
			$("#defaultForm").attr("disabled", false);
			$("#orderNum").attr("disabled", false);
		}
		
		$("#codeNm").val("");
		$("#codeSeq").val("");
		$("#codeDesc").val("");
		$("#defaultForm").val("");
		$("#orderNum").val("");
		Pudd( 'input[type="radio"][name="rdoUseYn"][value="Y"]' ).getPuddObject().setChecked(true); //사용여부
		$("#codeSeq").attr("disabled", false);
		$("#defaultForm").attr("disabled", false);
		$("#btnExistChk").attr("disabled", false);
	}
	
	/* 저장 */
	function fnSave(){
		if (!confirm('저장하시겠습니까?')) {
            return;
        }
		if (!chkVal()) {
            return;
        }
		var tblParam = {};
		var puddObj = Pudd( "#treeview" ).getPuddObject();
		var rowData = puddObj.getTreeSelectedItem();
		if( !rowData ) {
			alert('트리를 선택해주세요.');
			return;
		}
		
		var selData = rowData.rowData; //트리선택 데이터
		tblParam.prodSeq = selData.prod_seq;
		tblParam.codeSeq = $("#codeSeq").val();
		tblParam.codeNm = $("#codeNm").val();
		tblParam.codeDesc = $("#codeDesc").val();
		tblParam.parentCodeSeq = $("#upperSeq").val();
		var useYnVal = Pudd( 'input[type="radio"][name="rdoUseYn"][checked]' ).getPuddObject().val();
		tblParam.useYn = useYnVal;
		tblParam.ulevel = $("#upperLevel").val(); //선택한 트리 부모 레벨
		tblParam.orderNum = $("#orderNum").val();
		
   		$.ajax({
   			type : 'post',
   			contentType: "application/json; charset=utf-8",
   			url : '${pageContext.request.contextPath}/common/insertCnsltCode.do',
   			datatype : 'json',
   			async : false,
   			data : JSON.stringify(tblParam),
   			success : function(data) {
   				if(data.result.resultCode == "SUCCESS"){
   					alert("저장 되었습니다.");
   					bindTree();
   				}else{
   					alert("코드 저장 중 실패하였습니다.");
   				}
   			},
   			error : function(data) {
   				console.log('분류코드 저장 Error ! >>>> ' + JSON.stringify(data));
   			}
   		});
	}
	
	/* 삭제 */
	function fnDelete(){
		var puddObj = Pudd( "#treeview" ).getPuddObject();
		var rowData = puddObj.getTreeSelectedItem();
		if( !rowData ) {
			alert('삭제할 항목을 선택해주세요.');
			return;
		}
		
		var selData = rowData.rowData; //트리선택 데이터
		if(selData.id == 0){
			alert('전체는 삭제할수 없습니다.');
			return;
		}else if(selData.use_yn == "Y"){
			if (!confirm('사용중인 코드값입니다. 삭제 하시겠습니까?')) {
	            return;
	        }
		}else if(selData.form_seq != ""){
			if (!confirm('설정된 기본양식도 함께 삭제됩니다. 삭제 하시겠습니까?')) {
	            return;
	        }
		}else{
			if (!confirm('삭제하시겠습니까?')) {
	            return;
	        }
		}
		
		var tblParam = {};
		tblParam.prodSeq = selData.prod_seq;
		tblParam.codeSeq = $("#codeSeq").val();
		tblParam.ulevel = $("#upperLevel").val(); //선택한 트리 부모 레벨
		$.ajax({
   			type : 'post',
   			contentType: "application/json; charset=utf-8",
   			url : '${pageContext.request.contextPath}/common/deleteCnsltCode.do',
   			datatype : 'json',
   			async : false,
   			data : JSON.stringify(tblParam),
   			success : function(data) {
   				if(data.result.resultCode == "SUCCESS"){
   					alert("삭제 되었습니다.");
   					bindTree();
   				}else{
   					alert(data.result.resultMessage);
   				}
   			},
   			error : function(data) {
   				console.log('분류코드 삭제 Error ! >>>> ' + JSON.stringify(data));
   			}
   		});
		
	}
	
	function chkVal(){
		if($("#upperSeq").val() == ""){
			alert("상위분류 값이 없습니다.");
			return false;
		}
		if($("#codeNm").val() == ""){
			alert("코드명 값이  없습니다.");
			return false;
		}
		if($("#codeSeq").val() == ""){
			alert("코드 값이 없습니다.");
			return false;
		}		
		
		return true;
	}
	
</script>

<body>

<div class="sub_contents_wrap">
	<!-- 검색박스 -->
	<div class="top_box">
		<dl>
			<dt>제품구분</dt>
			<dd>
			<select id="sel_product" class="puddSetup" pudd-style="min-width:180px;" onchange="">
				<!-- <option value="0">전체</option> -->
				<c:forEach var="pdata" items="${productList}" varStatus="status">
					<option value="${pdata.code_seq}">${pdata.code_name}</option>
				</c:forEach>
			</select>
			</dd>
			
			<!-- <dt>사용여부</dt>
			<dd>
			<select id="sel_useYn" class="puddSetup" pudd-style="min-width:180px;" onchange="">
				<option value="A">전체</option>
				<option value="Y">사용</option>
				<option value="N">미사용</option>
			</select>
			</dd> -->
		</dl>
	</div>

	<div class="posi_re">
		<!-- 컨트롤버튼영역 -->
		<div id="" class="controll_btn" style="">
			<input type="button" id="btnNew" class="puddSetup" value="신규" />
			<input type="button" id="btnSave" class="puddSetup submit" value="저장" /></dd>
			<input type="button" id="btnDelete" class="puddSetup" value="삭제" />
		</div>

		<p class="tit_p posi_ab" style="top:15px; left:0px;">상담 분류</p>
		<p class="tit_p posi_ab" style="top:15px; left:30%;">분류값 설정</p>
	</div>

	<div class="twinbox">
		<table>
			<colgroup>
				<col style="width:30%;" />
				<col />
			</colgroup>
			<tr>
				<td class="twinbox_td">
					<!-- 상담분류 트리 -->
					<div id="treeview" class="tree_icon tree_auto" style="max-height:578px"></div>
				</td>
				<td class="twinbox_td">
					<input type="hidden" id="hidActID" />
					<input type="hidden" id="hidMode" value="I" />
					<input type="hidden" id="idChk" value="" />            
					<!-- 옵션설정 -->
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="120"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th><img src="<c:url value='/resources/Images/ico/ico_check01.png'/>" />상위분류</th>
								<td><input type="text" id="upperNm" name="upperNm" style="width:240px" value="" /></td>
								<input type="hidden" id="upperSeq" value=""/>
								<input type="hidden" id="upperLevel" value=""/>
							</tr>
							<tr>
								<th><img src="<c:url value='/resources/Images/ico/ico_check01.png'/>" />코드명</th>
								<td><input type="text" id="codeNm" name="codeNm" style="width:240px" value="" /></td>
								<!-- <input type="hidden" id="selLevel" value=""/> -->
							</tr>
							<tr>
								<th><img src="<c:url value='/resources/Images/ico/ico_check01.png'/>" />코드</th>
								<td><input type="text" id="codeSeq" name="codeSeq" style="width:240px; ime-mode:disabled;" value=""/>
								<input type="button" id="btnExistChk" class="puddSetup" value="중복체크" /></td>
							</tr>
							<tr>
								<th><img src="<c:url value='/resources/Images/ico/ico_check01.png'/>" />사용여부</th>
								<td><input type="radio" name="rdoUseYn" value="Y" class="puddSetup" pudd-label="사용" />
								<input type="radio" name="rdoUseYn" value="N" class="puddSetup" pudd-label="미사용" /></td>
							</tr>
							<tr>
								<th>비고</th>
								<td><input type="text" id="codeDesc" name="codeDesc" style="width:240px" value="" /></td>
							</tr>
							<tr>
								<th>순서</th>
								<td><input type="text" id="orderNum" name="orderNum" style="width:240px" value="" maxlength ="5" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/></td>
							</tr>
							<tr>
								<th>기본양식</th>
								<td><input type="text" id="defaultForm" name="defaultForm" style="width:240px" value="" /></td>
							</tr>
						</table>
						
						
					</div>
				</td>
			</tr>
		</table>
	</div>
</div><!-- //sub_contents_wrap -->


</body>
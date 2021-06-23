<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>Custom DevBlog - Main</title>
	
	<!-- Custom fonts for this template-->
	<link href="${pageContext.request.contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="${pageContext.request.contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
	
	<!-- Highlight JS -->
	<link href="${pageContext.request.contextPath}/resources/js/highlight/styles/default.css" rel="stylesheet">
	
	<!-- DataTable -->
	<link href="${pageContext.request.contextPath}/resources/js/dataTablesBootStrap/datatables.min.css" rel="stylesheet">  
	
	<!-- include summernote css -->
	<link href="${pageContext.request.contextPath}/resources/js/summernote/summernote.min.css" rel="stylesheet">
	
	<!-- 게시판 datatable CSS 리뉴얼 적용 -->
	<link href="${pageContext.request.contextPath}/resources/css/renew/renew.css" rel="stylesheet">
	 
	 
	 <!-- JS -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqueryui/jquery-ui.min.js"></script>	  
	  
	<!-- Highlight JS -->
	<%-- <script src="${pageContext.request.contextPath}/resources/js/highlight/highlight.pack.js"></script> --%>
	<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.5.0/highlight.min.js"></script>
	
	<!-- DataTable -->
	<script src="${pageContext.request.contextPath}/resources/js/dataTablesBootStrap/datatables.min.js"></script>
	
	<!-- include summernote js -->
	<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote.min.js"></script>
	
	<script>
		hljs.initHighlightingOnLoad();
		$(document).ready(function() {
			$.noConflict(); /* 데이터 테이블 충돌 방지 */	
		});
	</script>
  
</head>

<body id="page-top">
  <!-- Page Wrapper -->
  <div id="wrapper">
  	
 	<!-- Sidebar --> 
	<tiles:insertAttribute name="left" />
    <!-- End of Sidebar -->
    
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">
        <!-- Topbar -->
        <tiles:insertAttribute name="header" />

		<!-- content -->
		<div class="container-fluid">
	    	<tiles:insertAttribute name="body" />
        </div>

      </div>

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        	<tiles:insertAttribute name="footer" />
      </footer>

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
  <script src="${pageContext.request.contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>

</body>

</html>

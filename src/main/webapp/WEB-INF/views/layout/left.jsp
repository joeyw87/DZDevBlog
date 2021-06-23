<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

 <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<c:url value="/main.do" />">
        <img class="img-fluid" src="${pageContext.request.contextPath}/resources/Images/devLogo.png">
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="<c:url value="/main.do" />">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Douzone Developer</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        menu
      </div>

      <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="" data-toggle="collapse" data-target="#apiTest" aria-expanded="true" aria-controls="apiTest">
          <i class="fas fa-fw fa-wrench"></i>
          <span>Douzone API call</span>
        </a>
        <div id="apiTest" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">메뉴</h6>
            <a class="collapse-item" href="<c:url value="/api/test/apiTest.do" />">전자결재 API TEST</a>
            <a class="collapse-item" href="<c:url value="/api/test/apiTest.do" />">조직정보제공 API TEST</a>
          </div>
        </div>
      </li>

      <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="" data-toggle="collapse" data-target="#apiParameter" aria-expanded="true" aria-controls="apiParameter">
          <i class="fas fa-fw fa-folder"></i>
          <span>Douzone API parameter</span>
        </a>
        <div id="apiParameter" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">메뉴</h6>
            <a class="collapse-item" href="<c:url value="/api/developer/apiParameter.do" />">영리(EAP)</a>
            <a class="collapse-item" href="<c:url value="/api/developer/apiParameter.do" />">비영리(EA)</a>
          </div>
        </div>
      </li>
      
      
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="" data-toggle="collapse" data-target="#Community" aria-expanded="true" aria-controls="Community">
          <i class="fas fa-fw fa-table"></i>
          <span>Community</span>
        </a>
        <div id="Community" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">메뉴</h6>
            <a class="collapse-item" href="<c:url value="/board/community/communityListView.do" />">커뮤니티 게시판</a>
            <a class="collapse-item" href="<c:url value="/api/board/apiProfitList.do" />">영리(EAP)</a>
            <a class="collapse-item" href="<c:url value="/api/board/apiNonProfitList.do" />">비영리(EA)</a>
          </div>
        </div>
      </li>
      
      
      <!-- Nav Item - Charts -->
      <li class="nav-item">
        <a class="nav-link" href="<c:url value="/api/stat/apiStat.do" />">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Statistics</span></a>
      </li>
      
     
    </ul>
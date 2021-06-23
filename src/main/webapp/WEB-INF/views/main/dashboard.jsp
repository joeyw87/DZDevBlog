<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	puddready(function() {

	});


</script>

<p class="tit_p mb5 mt20">로그인 한 유저의 대시보드 화면입니다.</p>
</br>
<input type="hidden" id="hidIndex"/>

<form id="listForm" name="listForm" method="post">
    <input type="hidden" name="cnsltSeq" id="cnsltSeq" />
</form>


<div id="loadingProgressBar"></div>
<div class="sub_contents_wrap" style="width: 100%;">
    <!-- 오른쪽 영역 -->
    <div style="width: 60%; height: 80%; float: left;">
        <div style="height: 30%; border: indianred solid 1px;">
            <div class="btn_div">
                <div class="left_div">
                    <p class="tit_p mb5 mt5">고객정보</p>
                </div>
                <div class="right_div">
                    <input type="button" class="puddSetup" id="btn_Reload_UserInfo" value="수정" />
                </div>
            </div>
            <div id="tGrid_userInfo"></div>
        </div>
        </br>
        <div style="height: 65%; border: indianred solid 1px;">
            <div class="btn_div">
                <div class="left_div">
                    <p class="tit_p mb5 mt5">상담내역 뷰타입</p>
                </div>
                <div class="right_div">
                    <input type="button" class="puddSetup" id="btn_Add" value="수정" />
                </div>
            </div>
            <div id="tGrid_consultInfo"></div>
        </div>
    </div>
    <div style="width: 38%; border: indianred solid 1px; float: right">
        <!-- 버튼/타이틀 -->
        <div class="btn_div">
            <div class="left_div">
                <p class="tit_p mb5 mt5">오른쪽 영역 1 : 제품 버전정보</p>
                <p class="tit_p mb5 mt5">오른쪽 영역 2 : 나의 상담현황 영역</p>
                <p class="tit_p mb5 mt5">오른쪽 영역 3 : 공지/교육 영역</p>
                <p class="tit_p mb5 mt5">오른쪽 영역 4 : 추천 영역</p>
            </div>
            <div class="right_div">
                <input type="button" class="puddSetup" id="btn_Reload_UserInfo2" value="수정" style="display: none;" />
            </div>
        </div>

        <div id="tGrid_userInfo2"></div>
    </div>
</div>

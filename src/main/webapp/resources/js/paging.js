// ******************************************************
//페이징 처리
// ******************************************************
$.fn.extend({
    SetPage: function (callback, totalCnt, viewCnt, nowPage, groupCnt) {
        fnLoadPaging($(this), callback, totalCnt, viewCnt, nowPage, groupCnt);
    }
});

function fnLoadPaging(th, callback, totalCnt, viewCnt, nowPage, groupCnt){
	try { 
		$("#hidPaging").val(nowPage);
	} catch (e) { }
	
	if (groupCnt == undefined) groupCnt = 10;
	
	var totalPage = 0, startPage = 0, endPage = 0, pageHalfIndex = 0;
	var innerHtml = ''; 
	
	try {
		totalCnt = parseInt(totalCnt);
		viewCnt = parseInt(viewCnt);
		nowPage = parseInt(nowPage);
		groupCnt = parseInt(groupCnt);

		totalPage = Math.ceil( totalCnt / viewCnt );
		pageHalfIndex = parseInt(groupCnt / 2);

		if (nowPage > pageHalfIndex)
        {
			endPage = nowPage + pageHalfIndex;
            if (endPage > totalPage)
            	endPage = totalPage;

            startPage = endPage - groupCnt + 1;
            if (startPage < 1)
            	startPage = 1;
        }
        else
        {
        	startPage = 1;
        	endPage = groupCnt;

            if (totalPage < groupCnt)
            	endPage = totalPage;
        }

		// 1페이지 뿐이면 페이징 처리 안나옴
		if (totalPage > 1) {
		    innerHtml += '<span class="pre_pre"><a href="#n" id="btnPageFirst">10페이지전</a></span>';
		    innerHtml += '<span class="pre"><a href="#n" id="btnPagePre">이전</a></span>';
		    innerHtml += '<ol>';
		    for(var i = startPage; i <= endPage; i++) {
		    	if (i == nowPage)
                {
		    		innerHtml += '<li class="on"><a href="#n">' + i + '</a></li>';
                } else {
                	innerHtml += '<li><a href="#n" id="btnGoPage">' + i + '</a></li>';
                }
		    }
		    innerHtml += '</ol>';
		    innerHtml += '<span class="nex"><a href="#n" id="btnPageNex">다음</a></span>';
		    innerHtml += '<span class="nex_nex"><a href="#n" id="btnPageEnd">10페이지다음</a></span>';
		}
    }
    catch (e) { }
    
    $(th).html(innerHtml);
    
    $("#btnPageFirst").unbind("click").click(function () { 
    	if (nowPage == 1) {
    		alert("처음 페이지입니다.");
            return;
    	}
    	
    	eval(callback)(1);	
	});
    
    $("#btnPageEnd").unbind("click").click(function () { 
		if (nowPage == totalPage) {
			alert("마지막 페이지입니다.");
            return;
		}
    	eval(callback)(totalPage);
	});
    
    $("#btnPagePre").unbind("click").click(function () { 
    	if (nowPage == 1) {
    		alert("처음 페이지입니다.");
            return;
    	}
    	
    	eval(callback)(nowPage - 1);	
	});
    
    $("#btnPageNex").unbind("click").click(function () { 
		if (nowPage == totalPage) {
			alert("마지막 페이지입니다.");
            return;
		}
    	eval(callback)(nowPage + 1);
	});
    
    $("[id='btnGoPage']").unbind("click").click(function () { 
    	eval(callback)($(this).text());
	});
}

function fncGetStartIndex(nowPage, viewCnt) {
	var startIndex = 0;
	
	if(nowPage != 1){
		try {
			startIndex = ((parseInt(nowPage) - 1) * parseInt(viewCnt));
        }
        catch (e) { }
        
    } 
	
	return startIndex;
}

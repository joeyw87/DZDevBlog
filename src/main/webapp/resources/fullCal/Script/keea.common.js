/************************************
// 리스트 index 리턴
*************************************/
function fncSelectedIndex (arr, val, val_nm) {
	var result = 0;

	$.each(arr, function (row) {
		if (arr[row][val_nm] == val) {
			result = row;
			return false;
		}
    });

	return result;
}

/******************************************
//일자포맷전환
******************************************/
function fncDateFormat(data){
	var result = '';
	if(data !== '' && data !== null){
		result = data.substring(0,4) + '-' + data.substring(4,6) + '-' + data.substring(6,8);
		}
	return result;
}

/******************************************
//일자포맷전환
******************************************/
function fncDateToString(date, separator){
	var result = '';

	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();

	month = month < 10 ? "0" + month : month;
	day = day < 10 ? "0" + day : day;

	result = year + separator + month + separator + day;

	return result;
}


/************************************
// empty data
*************************************/
function fncGridEmptyData(gridObj, gridId) {
	if (gridObj == undefined) {
		return;
	}

	var totalCount = gridObj.optObject.dataSource.totalCount;

	if (gridId != undefined) {
 		$(gridId).find(".grid-content").find("tbody").empty();
 		$(gridId).find(".PUDD-UI-pager").empty();
 		totalCount = 0;
	}

	// grid 에 dataSource 전달되지 않은 경우는 skip
	if( ! gridObj.optObject.dataSource ) {
		return;
	}

	if( totalCount == 0 || totalCount == null ) {

		var colCount = gridObj.gridColCount();
		if( colCount == 0 || colCount == null ) return;

		var trObj = new Pudd.Element( "tr" );
		var tdObj = new Pudd.Element( "td" );
		tdObj.attr( "colspan", colCount );
		tdObj.text( '데이터가 존재하지 않습니다' );

		trObj.append( tdObj );

		gridObj.contentTableTbodyObj.append( trObj );
	}
}

/************************************
팝업 공통사용
******************************************/
function custPop(url, param, width, height, popName) {
    // 값이 NULL 일 경우에 대한 처리
    if (url == null) { url = ""; }
    if (param == null) { param = ""; }
    if (width == null) {
        if (screen.width <= 900) {
            width = screen.width;
        }
        else {
            width = 900;
        }
    }
    if (height == null) { height = screen.height - 120; }

    // width 와 height 에 대한 처리 ( 실제 화면보다 크게 설정이 되었을 경우 )
    if (width >= screen.width) {
        width = screen.width - 120;
    }
    if (height >= screen.heigth) {
        height = screen.height - 120;
    }

    var popObj;

    // 파라미터 체크
    if (url == "" || url == null) {
        alert("호출대상이 전달되지 않았습니다. ( url 누락 )");
        return false;
    }
    else {
        var date = new Date();
        var PopUrl = url + "?" + param;
        var popX = (screen.width / 2) - (width / 2);
        var popY = (screen.height - height) / 6;
        var PopOption = "width=" + width + ", height=" + height + ", left=" + popX + ", top=" + popY + ", resizable=no, scrollbars=yes, status=no";

        if (popName == undefined || popName == "" || popName == null){
        	popObj = window.open(PopUrl, "pop_" + date.getFullYear() + ((date.getMonth() + 1) <= 9 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1)) + (date.getDate() <= 9 ? '0' + date.getDate() : date.getDate()) + date.getHours() + date.getMinutes() + date.getSeconds(), PopOption);
        } else {
        	popObj = window.open(PopUrl, popName, PopOption);
        }
    }

//    if (isOpener) {
//        popObj.opener = opener;
//    }

    return popObj;

}

function fnGetStartIndex(nowPage, viewCnt) {
	var startIndex = 0;

	if(nowPage != 1){
		try {
			startIndex = ((parseInt(nowPage) - 1) * parseInt(viewCnt));
        }
        catch (e) { }

    }

	return startIndex;
}

/**********************************************************
* 3자리 마다 ',' 추가
**********************************************************/
function setComma(num) {

    if (num == undefined || num == null || num == "") {
        return "0";
    }

    num = num.toString(); //num이 숫자형으로 넘어올 경우 오류를 발생하므로 형변환한다.
    var num_amount = '';
    var flot = '';

    if (num.indexOf(".") >= 0) {
        num_amount = num.substring(0, num.indexOf("."));
        flot = num.substring(num.indexOf("."), num.length);
    }
    else {
        num_amount = num.toString();
    }

    var fmt_amount = '';
    var minus_flag = '';

    num_amount = num_amount.replace(/,/g, '');

    if (num_amount.charAt(0) == '-') {
        minus_flag = 'Y';
        num_amount = num_amount.substring(1);
    }

    if (num_amount.length > 3) {
        var str1 = num_amount.substring(0, num_amount.length % 3);
        var str2 = num_amount.substring(num_amount.length % 3, num_amount.length);

        if (str1.length != 0) str1 += ',';

        fmt_amount += str1;

        for (i = 0; i < str2.length; i++) {
            if (i % 3 == 0 && i != 0) fmt_amount += ',';
            fmt_amount += str2.charAt(i);
        }
    }
    else {
        fmt_amount = num_amount;
    }

    if (minus_flag == 'Y') fmt_amount = '-' + fmt_amount;

    num = (fmt_amount + flot);
    return num;
}

/************************************
잠시 멈춤
************************************/
function sleep(num){	//[1/1000초]
	 var now = new Date();
	   var stop = now.getTime() + num;
	   while(true){
		 now = new Date();
		 if(now.getTime() > stop)return;
	   }
}

/******************************************
함수명: fncDateDiff
설  명: 일자차이 구하기
******************************************/
function fncDateDiff(pSDt, pEDt) {
	try {
	     sYear = parseInt(pSDt.substring(0,4), 10);
	     sMon = parseInt(pSDt.substring(4,6), 10) - 1;
	     sDt = parseInt(pSDt.substring(6,8), 10);

	     eYear = parseInt(pEDt.substring(0,4), 10);
	     eMon = parseInt(pEDt.substring(4,6), 10) - 1;
	     eDt = parseInt(pEDt.substring(6,8), 10);

	     start = new Date(sYear, sMon, sDt);
	     end = new Date(eYear, eMon, eDt);

	     mil = end.getTime() - start.getTime();

	     sec = mil/1000;     // 초 구함
	     min = sec/60;       // 분 구함
	     hr = min/60;        // 시 구함
	     dd = hr/24;         // 일 구함

	     return dd + 1;
	}
	catch (e)
	{
		alert(e);
		return 0;
	}
}

/******************************************
함수명: fncDateCal
설  명: 날짜 계산
******************************************/
function fncDateCal(dt, num) {
	var date = new Date(dt);

	date.setDate(date.getDate() + num);

	var year = date.getFullYear();
	var month = date.getMonth()+1
	var day = date.getDate();

	if(month < 10){
	    month = "0"+month;
	}
	if(day < 10){
	    day = "0"+day;
	}

	return year + "-" + month + "-" + day;

}

/******************************************
함수명: numberChk
******************************************/
$.fn.numberChk = function (callback) {
	$(this).unbind("keyup").keyup(function (event) {
		regexp = /[^0-9]/gi;
		v = $(this).val();
		if (regexp.test(v)) {
		    $(this).val(v.replace(regexp, ''));
		}
		if (callback != undefined) {
		    eval(callback)($(this));
		}
	});

	$(this).unbind("focusout").focusout(function () {
	    regexp = /[^0-9]/gi;
	    v = $(this).val();
	    if (regexp.test(v)) {
	        $(this).val(0);
	    }
	});
}

/******************************************
함수명: fncGridHeight
설  명: 높이 구하기
******************************************/
function fncGridHeight(defultHeight, topHeight) {
	var height = defultHeight;

	try {
		height = $(window).height() - topHeight;
		return height;

	}
	catch (e)
	{
		return defultHeight;
	}
}

function fncParseInt(num) {
	try {
		if (num == null || num == "" || num == undefined) {
			num = 0;

		} else {
			num = parseInt(num);

		}

	} catch(e) {
		num = 0;
	}

	return num;
}

function isEmpty(str) {
    if (!str || str == undefined || str == null || str == "" || str.length === 0)
    {
    	return true;
    }
    else
    {
         return false;
    }

  }


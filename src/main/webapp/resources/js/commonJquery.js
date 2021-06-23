jQuery.fn.extend({
	fncPuddSelectDDL: function (param, reqData, puddData) {
        fncPuddSelectBoxAjax($(this), param['url'], reqData, param['async'], param['callback'], param, puddData);
    },
    fncSetRadioDDL: function (param, reqData) {
    	fncRadioAjax($(this), param['url'], reqData, param['async'], param['callback'], param['click'], param);
    },
    fncSetCheckDDL: function (param, reqData) {
    	fncCheckAjax($(this), param['url'], reqData, param['async'], param['callback'], param['click'], param);
    }
});

function fncPuddSelectBoxAjax(tagObj, url, reqData, async, callback, selOption, puddData) {
	if (reqData == undefined || reqData == null || reqData == "") {
		reqData = {};
	}

	$.ajax({
        type: "POST"
        , contentType: "application/json; charset=utf-8"
        , url: url
        , async: async
        , data: JSON.stringify(reqData)
        , success: function (res) {
        	fncPuddSelectBinding(tagObj, res, selOption, puddData);
            if (callback != '' && callback != undefined && callback != null) {
                eval(callback)(tagObj, result, selOption, puddData);
            }

        }
        , error: function (request, status, error, result) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

function fncRadioAjax(tagObj, url, reqData, async, callback, click, selOption) {
	if (reqData == undefined || reqData == null || reqData == "") {
		reqData = {};
	}

	$.ajax({
        type: "POST"
        , contentType: "application/json; charset=utf-8"
        , url: url
        , async: async
        , global: false
        , data: JSON.stringify(reqData)
        , success: function (res) {
            fncRadioBinding(tagObj, res, selOption, click);
            if (callback != '' && callback != undefined && callback != null) {
                eval(callback)();
            }
        }
        , error: function (request, status, error, result) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

function fncCheckAjax(tagObj, url, reqData, async, callback, click, selOption) {
	if (reqData == undefined || reqData == null || reqData == "") {
		reqData = {};
	}

	$.ajax({
        type: "POST"
        , contentType: "application/json; charset=utf-8"
        , url: url
        , async: async
        , global: false
        , data: JSON.stringify(reqData)
        , success: function (res) {
            fncCheckBinding(tagObj, res, selOption, click);
            if (callback != '' && callback != undefined && callback != null) {
                eval(callback)();
            }
        }
        , error: function (request, status, error, result) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

/*
* Binding 함수
*/
function fncPuddSelectBinding(tagObj, result, selOption, puddData) {
	var pudd_id = tagObj[0].id;

	/*if (selOption['firstValue'] != undefined && jQuery.isEmptyObject(selOption['firstValue']) == false) {
		result.list.unshift(selOption['firstValue']);
	}*/

	// Pudd DataSource 매핑
	var dataSourceComboBox = new Pudd.Data.DataSource({
		data : result
	});

	puddData.dataSource = dataSourceComboBox;

	Pudd( "#" + pudd_id ).puddComboBox(puddData);
}

function fncRadioBinding(tagObj, result, selOption, click) {
    var radioHtml = '', id = tagObj[0].id, idIdx = 1, chkStr = '', chkIdx = 0;

    /*if (selOption['checkedIdx'] != undefined && jQuery.isEmptyObject(selOption['checkedIdx']) == false) {
        chkIdx = selOption['checkedIdx'];
    }

    if (selOption['firstValue'] != undefined && jQuery.isEmptyObject(selOption['firstValue']) == false) {

        if (chkIdx == (idIdx - 1)) {
            chkStr = 'checked';
        }
        radioHtml += "<input type='radio' style='margin-right:5px' id='" + id + idIdx + "' name='" + id + "' value='" + selOption.firstValue['key'] + "' class='input-radio' " + chkStr + " onclick='" + click + "'><label for='" + id + idIdx + "' style='margin-right:10px'>" + selOption.firstValue['value'] + "</label>&nbsp;&nbsp;";

        idIdx++;
    }*/
	
    for (var idx in result) {
        chkStr = '';
        if (chkIdx == (idIdx - 1)) {
            chkStr = 'checked';
        }
        
        radioHtml += "&nbsp;<input type='radio' name='" + id + "' value='" + result[idx]["code_detail_id"] + "' onclick='" + click + "' " + chkStr + ">" + result[idx]["code_detail_name"];
        idIdx++;
    }

   
    $( "#" + id ).html(radioHtml);
}

function fncCheckBinding(tagObj, result, selOption, click) {
    var checkHtml = '', id = tagObj[0].id, idIdx = 1, chkStr = '', chkIdx = 0;

    /*if (selOption['checkedIdx'] != undefined && jQuery.isEmptyObject(selOption['checkedIdx']) == false) {
        chkIdx = selOption['checkedIdx'];
    }

    if (selOption['firstValue'] != undefined && jQuery.isEmptyObject(selOption['firstValue']) == false) {

        if (chkIdx == (idIdx - 1)) {
            chkStr = 'checked';
        }
        checkHtml += "<input type='check' style='margin-right:5px' id='" + id + idIdx + "' name='" + id + "' value='" + selOption.firstValue['key'] + "' class='input-radio' " + chkStr + " onclick='" + click + "'><label for='" + id + idIdx + "' style='margin-right:10px'>" + selOption.firstValue['value'] + "</label>&nbsp;&nbsp;";

        idIdx++;
    }*/

    for (var idx in result) {
        chkStr = '';
        if (chkIdx == (idIdx - 1)) {
            chkStr = 'checked';
        }
        
        checkHtml += "&nbsp;<input type='checkbox' id='" + id + "_" + result[idx]["code_detail_id"] + "' name='" + id + "' value='" + result[idx]["code_detail_id"] + "'>" + result[idx]["code_detail_name"];
        idIdx++;
    }

    $( "#" + id ).html(checkHtml);
}

function fncRadioClick(){
	alert("클릭");
}
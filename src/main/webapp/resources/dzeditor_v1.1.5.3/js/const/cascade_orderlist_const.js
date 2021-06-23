/*
* 다단계목록 드롭다운 다이알로그 
*/
var dzeCasCadeOrderList = [
	{
		"name": "list1",
		"list_image": "btn_dialog_orderlist_set1.png",
		"over_image": "btn_dialog_orderlist_set_big1.png",
		"order": ["decimal","upper-alpha","lower-alpha","upper-roman","lower-roman","decimal-leading-zero"]
	},
	{
		"name": "list2",
		"list_image": "btn_dialog_orderlist_set2.png",
		"over_image": "btn_dialog_orderlist_set_big2.png",
		"order": ["upper-alpha","upper-roman","lower-alpha","lower-roman","decimal","decimal-leading-zero"]
	},
	{
		"name": "list3",
		"list_image": "btn_dialog_orderlist_set3.png",
		"over_image": "btn_dialog_orderlist_set_big3.png",
		"order": ["upper-roman","upper-alpha","lower-roman","lower-alpha","decimal","decimal-leading-zero"]
	}
];

/*
* 글머리표 모양 드롭다운 다이알로그 
* unorderlist_styles 에 동일한 내용이 정의되어 있어 해당 내용 사용하도록 처리.
*/
var dzeStyleUnOrderList = [
	{
		"style": "none",
	}
];

/*
* 문단번호 모양 드롭다운 다이알로그 
* orderlist_styles 에 동일한 내용이 정의되어 있어 해당 내용 사용하도록 처리.
*/
var dzeStyleOrderList = [
	{
		"style": "none"
	}
];
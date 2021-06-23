<?php
$allow_file_ext = array("html","htm","txt");
if(is_uploaded_file($_FILES["openfile"]["tmp_name"])) {

	$info = pathinfo($_FILES["openfile"]["name"]);
	$ext = strtolower($info["extension"]);
	if(!in_array($ext, $allow_file_ext)) {
		exit;
	}

	$contents = file_get_contents($_FILES["openfile"]["tmp_name"]);

	$enc = mb_detect_encoding($contents,array("UTF-8","EUC-KR","SJIS"));
	if($enc != "UTF-8") {
		$contents = iconv($enc,"UTF-8",$contents);
	}

	//txt파일은 공백 및 P 태그적용
	if($ext == "txt") {
		/*
		$contents = str_replace(" ","&nbsp;",$contents);
		$contents = str_replace("\r\n\r\n","</p><p>&nbsp;<p></p>",$contents);
		$contents = str_replace("\r\n","</p><p>",$contents);
		$contents = "<p>".$contents."</p>";
		*/
		$contents = nl2br($contents);
	}

	//$contents = htmlspecialchars($contents);
	print($contents);
}
?>
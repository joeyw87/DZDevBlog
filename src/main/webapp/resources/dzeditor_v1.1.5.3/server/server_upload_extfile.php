<?php
$allowExt = array("doc","docx","xls","xlsx","ppt","pptx","hwp","txt","pdf");
if(is_uploaded_file($_FILES["dze_up_extfile"]["tmp_name"])) {

	$filename	= $_FILES["dze_up_extfile"]["name"];
	$filenames	= explode(".",$filename);
	$ext		= array_pop($filenames);

	if(!in_array($ext,$allowExt)) {
		$result			= "fail";
		$download_url	= "";
		$filename		= "";
	} else {

		$uniqFileName = time().rand(1000,9999).".".$ext;
		if(!move_uploaded_file($_FILES["dze_up_extfile"]["tmp_name"],"upload/".$uniqFileName)) {
			$result			= "fail";
			$download_url	= "";
			$filename		= "";
		} else {
			$result			= "success";
			$download_url	= "/dzeditor2.0/server/server_download_extfile.php?fileId=".$uniqFileName;
		}

	}

} else {
		$result			= "fail";
		$download_url	= "";
		$filename		= "";
}

$data = array(
	"result"		=> $result,
	"type"			=> "form_upload_extfile",
	"filename"		=> $filename,
	"url"			=> $download_url
);

$jsonData = json_encode($data);
print($jsonData);
?>
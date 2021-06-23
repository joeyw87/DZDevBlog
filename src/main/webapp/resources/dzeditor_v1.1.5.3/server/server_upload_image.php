<?php
$type = $_POST["type"];
//if(!$type) {
//	$type = "form_upload_image";
//}

if(is_uploaded_file($_FILES["dze_upimage_file"]["tmp_name"])) {

	$orgfilename = $_FILES["dze_upimage_file"]["name"];
	$filename = time()."_".rand(100000,999999).".png";

	if(!move_uploaded_file($_FILES["dze_upimage_file"]["tmp_name"],"upload/".$filename)) {
		echo "not uploaded";
		exit;
	}
	chmod("upload/".$filename,0777);

	$url = "http://localhost/dzeditor2.0/server/upload/".$filename;

	$responseData = array(
		"result"	=> "success",
		"type"		=> $type,
		"filename"	=> $orgfilename,
		"url"		=> $url
	);

} else {
	$responseData = array(
		"result"	=> "fail",
		"type"		=> $type,
		"filename"	=> "",
		"url"		=> ""
	);
}
print(json_encode($responseData));
?>
<?php
//print_r($_POST);
$data = $_POST["dze_upimage_data"];

list($type, $data) = explode(';', $data);
list(, $data)      = explode(',', $data);
$data = base64_decode($data);


//파일경로 생성
$up_file_name = time().'_'.rand(1000000,111111).'.png';
$up_file_path = 'upload/'.$up_file_name;

file_put_contents($up_file_path, $data);

$url = "http://localhost/dzeditor2.0/server/upload/".$up_file_name;

$responseData = array(
	"result"	=> "success",
	"type"		=> "paste_image",
	"filename"	=> $up_file_name,
	"url"		=> $url
);
print(json_encode($responseData));
?>
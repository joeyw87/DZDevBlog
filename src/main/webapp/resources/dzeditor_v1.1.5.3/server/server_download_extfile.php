<?php
//파일 다운로드
$fileId = $_GET["fileId"];
$filename = $fileId;		//=--------------- 서버에서 이 파일에 대한 원본파일명을 저장했다가 이곳에 세팅해야함
$filepath = "/dzeditor2.0/upload/".$filename;
$filesize = filesize($filepath);
$path_parts = pathinfo($filepath);
$extension = $path_parts['extension'];

header("Pragma: public");
header("Expires: 0");
header("Content-Type: application/octet-stream");
header("Content-Disposition: attachment; filename=\"$filename\"");
header("Content-Transfer-Encoding: binary");
header("Content-Length: $filesize");

ob_clean();
flush();
readfile($filepath);
?>
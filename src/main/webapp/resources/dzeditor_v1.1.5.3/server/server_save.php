<?php
//전송받은 HTML 그대로 파일로 다운로드
//sleep(10);

$strCR = "\r\n";

$strHTML = "";
$strHTML .= "<html>";
$strHTML .= $strCR;
$strHTML .= "<head>";
$strHTML .= $strCR;
$strHTML .= "<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />";
$strHTML .= $strCR;
$strHTML .= "<title></title>";
$strHTML .= $strCR;
$strHTML .= "</head>";
$strHTML .= $strCR;
$strHTML .= "<body>";
$strHTML .= $strCR;
$strHTML .= trim($_POST["content"]);
$strHTML .= $strCR;
$strHTML .= "</body>";
$strHTML .= $strCR;
$strHTML .= "</html>";

header("Pragma: public");
header("Expires: 0");
header("Content-Type: application/octet-stream");
header("Content-Disposition: attachment; filename=\"douzone_editor_content_".date("YmdHis").".html\"");
header("Content-Transfer-Encoding: binary");
//	header("Content-Length: ".strlen($strHTML));

ob_clean();
flush();

print $strHTML;
?>
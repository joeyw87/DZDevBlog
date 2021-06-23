<?php
echo $_POST["contents"];
echo "<br>";
echo "<br>";
echo "contents : <br/>";
echo "<hr/>";
echo "<div style='background-color:#ffffff;padding:5px;font-size:12px'>";
highlight_string($_POST["contents"]);
echo "</div>";
echo "<br>";
echo "uploaded file list : <br/>";
echo "<hr/>";
echo "<div style='background-color:#ffffff;padding:5px;font-size:12px'>";
echo $imgList = str_replace("|","<br/>",$_POST["imgList"]);
echo "</div>";
?>
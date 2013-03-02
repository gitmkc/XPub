<?php
if ($_REQUEST['code'] == 111) {
//		echo $_REQUEST['filename']."<br/>";
    $myFile = $_REQUEST['filename'];
    //$myFile = "data.txt";
    $fh = fopen($myFile, 'w') or die("can't open file");
    fwrite($fh, $_REQUEST['data']);
    fclose($fh);
    echo "1";
} else {
    echo "0";
}
?>
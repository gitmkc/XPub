<?php
if ($_REQUEST['code'] == 111) {
    $myFile = $_REQUEST['filename'];
    //echo "$myFile";
    //$myFile = "data.txt";
    $fh = fopen("$myFile", 'r');
    $theData = fread($fh, filesize("$myFile"));
    fclose($fh);
    echo $theData;
} else {
    echo "0";
}
?>
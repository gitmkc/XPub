<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$reloadStatus = '';
if (isset ($_POST['reloadFileContent']) && isset ($_POST['filepath']) && isset ($_POST['editfileName'])) {
    $fileContents = $_POST['reloadFileContent'];
    $filepath = $_POST['filepath'];
    $editfileName = $_POST['editfileName'];
    //echo $filePath."==".$editfileName;
    $fh = fopen("$filepath/$editfileName.edit", 'w') or die("can't open file");
    if (fwrite($fh, "$fileContents") == false) {
        $reloadStatus = "The file couldn't write";
    } else {
        $reloadStatus = "success";
    }
    fclose($fh);
}
//Print file status
echo "$reloadStatus";
?>

<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//echo $_POST['dir']."**<br/>".$_POST['cssData']."<br/>";

if (isset($_POST['dir']) && isset($_POST['cssData'])) {
    $filepath = "../published/jobs/".$_POST['dir'];
    // Pick stylesheet name
    $exclude_list = array(".","..");
    $directories = array_diff(scandir($filepath), $exclude_list);
    
    foreach ($directories as $dirContent) {
        if ($dirContent == 'css') {
            $cssDir = "/css";
            $subdirs = array_diff(scandir("$filepath$cssDir"), $exclude_list);
            foreach ($subdirs as $subdirContent) {
              if (preg_match("/([A-Za-z]+)\.css$/", $subdirContent, $cssfile)) {
                  $cssfileName = $cssfile[0];
              }  
            }            
        } elseif (preg_match("/([A-Za-z]+)\.css$/", $dirContent, $cssfile)) {
            $cssfileName = $cssfile[0];
            $cssDir = '';
        }
    }
    $cssFile = $filepath."$cssDir/edit_$cssfileName";
    
    $fh = fopen($cssFile, 'w') or die("can't open file");
    $fileData = $_POST['cssData'];
    if (fwrite($fh, "$fileData") == false) {
        echo "The data couldn't write to stylesheet.";
    } else {
        system("mv \"$cssFile\" \"$filepath$cssDir/$cssfileName\"");
        echo "The stylesheet has been modfied successfully.";
    }
    fclose($fh);
}
?>

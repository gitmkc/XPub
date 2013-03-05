<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$stringFound = '';
$fileCount = 0;
if (isset ($_REQUEST['filePath'])) {
    $filepath = "$_REQUEST[filePath]";
    //echo "file replace...".$_REQUEST['filePath'];
    if (isset ($_REQUEST['searchstring']) && isset ($_REQUEST['replacestring'])) {
        //echo "(".$_REQUEST['searchstring']."++".$_REQUEST['replacestring'].")";
        $searchString = "$_REQUEST[searchstring]";
        $replaceString = "$_REQUEST[replacestring]";
        $Filehandler = opendir($filepath);
        while ($filename = readdir($Filehandler)) {
            if (preg_match('/.html$/', $filename)) {
                $stringFound = shell_exec("fgrep -e \"$searchString\" $filepath/$filename");
                if ($stringFound) {
                    $fileCount++;
                    //echo $filename;
                    system("perl ../webapp/scripts/replaceText.pl $filepath/$filename \"$searchString\" \"$replaceString\"");
                }
            }
        }
        closedir($Filehandler);        
        echo $fileCount;
    }
} else {
    echo "file replace...no dir";    
}
?>

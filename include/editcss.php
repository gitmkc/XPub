<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

if (isset ($_REQUEST['dir']) && $_REQUEST['dir'] != '---SELECT---') {
    $filepath = $_REQUEST['dir'];
    if (file_exists("$filepath/css/stylesheet.css")) {
        $fileContent = file_get_contents("$filepath/css/stylesheet.css");
        echo $fileContent;
    } elseif (file_exists("$filepath/stylesheet.css")) {
        $fileContent = file_get_contents("$filepath/stylesheet.css");
        echo $fileContent;
    }
}
?>

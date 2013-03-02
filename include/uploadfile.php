<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$fileName = $_FILES['uploadfile']['name'];

$target_path = '../unpublished/';
//echo "file upload...$fileType, $fileName, $target_path<br/>";

if ((preg_match("/.epub$/", "$fileName")) || (preg_match("/.zip$/", "$fileName"))) {
    $target_path = $target_path . basename($_FILES['uploadfile']['name']);

    if (move_uploaded_file($_FILES['uploadfile']['tmp_name'], "$target_path")) {
        return 'success';
        //echo "The file " . basename($_FILES['uploadfile']['name']) . " has been uploaded";
    } else {
//        echo "<script language=javascript type='text/javascript'>alert('There was an error uploading the file, please try again!');</script>";
        return 'fail';
    }
} else {
//    echo "<script language=javascript type='text/javascript'>alert('Invalid File format!');</script>";
        return 'invalid';
}
?>

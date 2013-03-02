<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once("../conf/conf.php");
include_once("../classes/dbquery.php");
require_once "../cuteeditor_files/include_CuteEditor.php";

$cssName = 'stylesheet.css';
//$checkName = '';

if (isset($_REQUEST['stage'])) {
//    echo $_REQUEST['stage'] . "+ " . $_REQUEST['dirname'] . "+ and " . $_REQUEST['filename'] . "<br/>";
    $filepath = $_REQUEST['dirname'];
    $filename = $_REQUEST['filename'];
    $filename = preg_replace("/(.+?).html$/", "$1", $filename);
}

// WRITE EDITED FILE
if (isset($_POST['Editor1'])) {
    $editor = new CuteEditor();
    $editor->ID = "Editor1";
    $editor->Text = "$_POST[Editor1]";
    $editor->SaveFile("$filepath/$filename-stg2.html");
    $editor = null;

    system("../webapp/scripts/HTMLnormalize.pl \"$filepath\" \"${filename}-stg2.html\"");
    //system("echo $filename >> $filepath/xmlinfo.txt");

//    <script language="javascript" type="text/javascript">
//       var ans = confirm("Do you want to save the file?");
//    </script>
    
    if (file_exists("$filepath/${filename}-stg2.html")) {
        //unlink("$filepath/${filename}-stg1.html");
        //unlink("$filepath/${filename}-stg2.html");
    } else {
        $columnArray = array(
            'USER_NAME' => "$UserName",
            'QA_STATUS' => 'Done');
        $dbQuery->updateQuery($columnArray, "QA_epubtable", "FILE_ID='$filename.html'");
    }

    // Get source dir from path     
    $sourceDir = basename("$filepath");

    $dbQuery->doQuery("QA_STATUS", "QA_epubtable", "QA_STATUS='pending' and PACKET_NAME='$sourceDir'");
    if ($dbQuery->tableFieldValues['QA_STATUS'] != 'Pending') {
        //print "++====".$dbQuery->tableFieldValues['QA_STATUS']."<br/>===";
        ?>
        <script language="javascript" type="text/javascript">
            var ans = confirm("Do you want to proceed packet for ePub creation?");
            if (ans == true) {
                window.location.href="mainpage.php?module=publish&publish=epub&stage=createEpub&SourceDirFromEdit=<?php echo $sourceDir; ?>";
            } else {
                //alert("hi");
                //window.location.href="editclose.php";
                window.close();
            }
        </script>
        <?php
        //header("location:mainpage.php?module=publish&publish=epub&stage=createEpub&SourceDirFromEdit=$sourceDir");
    } else {
        ?>
        <script language="javascript" type="text/javascript">
            window.close();
        </script>
        <?php
        //header("location:editclose.php");
    }
} else {
    if (isset($_POST['reloadFileContent'])) {
        $filepath = "$_POST[filePath]";
        $filename = "$_POST[editfileName]";
        $fileContent = "$_POST[reloadFileContent]";
//        $fileContent = "MUKE++".$fileContent;
//        echo "reloadFileContent++$filepath";
//        $checkName = 'refresh-edit';
    } else {
        // OPEN FILE IN EDITOR
        system("../webapp/scripts/modifyHTML.pl \"$filepath/$filename.html\" \"$filepath/${filename}-stg1.html\"");
        $fileContent = file_get_contents("$filepath/$filename-stg1.html");
    }   
}
?>  
<form method="POST" name="publish" enctype="multipart/form-data">
    <div class="titleRow">HTML Publish - QA/Edit (<?php echo "$filepath/$filename" ?>)<a style="margin-bottom: 3px; float:right" href="#" onClick="reLoadEditor('<?php echo "$filepath"?>','<?php echo "$filename"?>');"><img align="top" src="../css/images/refresh_edit.png"/></a></div>
    <div class="clear"></div>
    <div id="loadContents">
        <div>
            <?php
            // Check CSS Stylesheet name    
            if (file_exists("$filepath/style.css")) {
                    $cssName = "$filepath/style.css";
            } elseif (file_exists("$filepath/css/sheet.css")) {
                    $cssName = "$filepath/css/style.css";
            } elseif (file_exists("$filepath/stylesheet.css")) {
                    $cssName = "$filepath/stylesheet.css";
            } elseif (file_exists("$filepath/css/stylesheet.css")) {
                    $cssName = "$filepath/css/stylesheet.css";
            }
            //Step 2: Create Editor object.   
            $editor = new CuteEditor();
            $editor->Text = "$fileContent";
            //Step 3: Set a unique ID to Editor   
            $editor->ID = "Editor1";
            $editor->UseHTMLEntities = false;
            $editor->AutoParseClasses = true;
            $editor->EditorWysiwygModeCss = "$cssName";
            $editor->BreakElement = "P";
            $editor->Focus = true;
            //$editor->XHTMLOutput=true;
            //Step 4: Render Editor   
            $editor->Draw();
            ?>
        </div>
        <div class="clear"></div>
    </div>
</form>



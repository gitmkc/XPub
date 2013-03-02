<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once("../conf/conf.php");
include_once("../classes/dbquery.php");

if (isset($_REQUEST['UserName'])) {
    $UserName = $_REQUEST['UserName'];
}

//
$fileArray = array();
$publishedFileArray = array();
//$todayDate = date("dmY");
if (isset($_REQUEST['sourceDir'])) {
    $sourceDir = $_REQUEST['sourceDir'];
//    echo $_REQUEST['sourceDir'] . "<br/>";
    if (isset($_REQUEST['HTMLfileArray'])) {
//        echo $_REQUEST['HTMLfileArray'] . "<br/>";
        $filetoProcess = $_REQUEST['HTMLfileArray'];
        $filetoProcess = split(",", $filetoProcess);
        foreach ($filetoProcess as $value) {
//            echo "Here...+$value";
//            system("mkdir -p \"../unpublished/$sourceDir/published-$todayDate\"");
            system("mkdir -p \"../published/jobs/$sourceDir\"");

            // copy images
            if (is_dir("../unpublished/$sourceDir/images")) {
//                echo "images Exist!";
                system("mv \"../unpublished/$sourceDir/images\" \"../published/jobs/$sourceDir\"");
            }
            // copy css
            if (is_dir("../unpublished/$sourceDir/css")) {
//                echo "CSS Exist!";
                system("mv \"../unpublished/$sourceDir/css\" \"../published/jobs/$sourceDir\"");
            } 
            
            //
            if (file_exists("../unpublished/$sourceDir/style.css")) {
//                echo "CSS Exist!";
                system("mv \"../unpublished/$sourceDir/style.css\" \"../published/jobs/$sourceDir\"");
            }

            if (file_exists("../unpublished/$sourceDir/stylesheet.css")) {
//                echo "CSS Exist!";
                system("mv \"../unpublished/$sourceDir/stylesheet.css\" \"../published/jobs/$sourceDir\"");
            }

            system("mv \"../unpublished/$sourceDir/$value\" \"../published/jobs/$sourceDir/$value\"");
            system("perl \"../webapp/scripts/generateHTML.pl\" \"../published/jobs/$sourceDir\" \"$value\"");

            // Add file information into Database
            $dbQuery->doQuery("FILE_ID", "QA_epubtable", "FILE_ID='$value' and PACKET_NAME='$sourceDir'");
            if ($dbQuery->tableFieldValues['FILE_ID']) {
                $columnArray = array('QA_STATUS' => 'Pending');
                $dbQuery->updateQuery($columnArray, "QA_epubtable", "FILE_ID='$value' and PACKET_NAME='$sourceDir'");
            } else {
            $sql = "insert into QA_epubtable values('','$sourceDir','$value','','Pending','$UserName','Published HTML')";
            mysql_query($sql);
            }
        }

        // REMAINING FILES IN UNPUBLISHED
        $Filehandler = opendir("../unpublished/$sourceDir");
        while ($filename = readdir($Filehandler)) {
            if (preg_match('/.html$/', $filename)) {
                $fileArray["$filename"] = "$filename";
            }
        }
        closedir($Filehandler);

        // PUBLISHED FILES
        $subdir = dir("../published/jobs/$sourceDir");

        //List files
        while (($filename = $subdir->read()) !== false) {
            if (preg_match('/\.html$/', $filename)) {
//                        echo $subfilename . ", ";
                $filetime = filemtime("../published/jobs/$sourceDir/$filename");
                $publishedFileArray[$filename] = "$filetime";
            }
        }
        $subdir->close();
        ?>
        <div class="twoColSec">
            <div class="col1">
                <h6 class="blk17">All Assets</h6>
                <div class="bx1">
                    <div class="cDesd">
                    <form name="processForm" method="post">
                        <table id="filelist" class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                            <tr class="tlhead"><th>#</th><th>Article No.</th><th>Article Name</th><th><input type='checkbox' name='filecheck' onClick="checkUncheck(document.processForm.filecheck)"/></th></tr>
                            <?php
                            ksort($fileArray);
                            foreach ($fileArray as $key => $value) {
                                $filecount++;
//                            $filecount = $filecount > 9 ? "$filecount" : "0$filecount";//row$filecount
                                echo "<tr id=\"file$value\"><td>$filecount</td><td>$value</td>
                            <td>Title</td><td><input type='checkbox' class='check_class' id='filecheck' value=\"$value\" name='filecheck'/></td></tr>";
                            }
                            ?>
                        </table>
                    </form>
                    </div>
                </div>
            </div>
            <div class="mbtn"> <a href="#" class="garrow" onclick="moveCheckedItem()"></a> <a href="#" class="refresh"></a> </div>
            <div class="col1">
                <h6 class="blk17">To Be Published</h6>
                <div class="bx1">
                    <input type="hidden" id="sourceDir" value="<?php echo $sourceDir ?>"/>
                    <div class="cDesd ritecDesc" id="processFiles">No Item to proceed</div>
                </div>
            </div>
            <div class="clear"></div>
            <input type="button" value="Publish" onclick="processFiles('targetfilelist')" class="bluBtn mrgnLft443" />
        </div>
        <div class="clear"></div>
        <div id="publishMyHTML">
            <div class="tableBox">
                <h6 class="blk17">Published History</h6>
                <table class="proj_table" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr class="tab_head">
                        <th align="left" valign="middle">#</th>
                        <th align="left" valign="middle">Article No</th>
                        <th align="center" valign="middle">Published Date<br /></th>
                        <th align="left" valign="middle">Published By</th>
                        <th align="left" valign="middle">Status</th>
                        <th align="left" valign="middle">Edit</th>
                    </tr>
                    <?php
                    arsort($publishedFileArray);
                    foreach ($publishedFileArray as $key => $value) {
                        $fileCount++;
                        $filetime = date("D, d M Y, H:i:s", $value);
                        $filename = $key;

                        $dbQuery->doQuery("USER_NAME,QA_STATUS", "QA_epubtable", "FILE_ID='$filename' and PACKET_NAME='$sourceDir'");
                        $UserName = $dbQuery->tableFieldValues['USER_NAME'];
                        $publishStatus = $dbQuery->tableFieldValues['QA_STATUS'];
                        
                        if ($publishStatus == 'Done') {
                            $publishStatus='<span style="color:green;font-weight:bold;">Done</span>';
                        } elseif ($publishStatus == 'Pending') {
                            $publishStatus='<span style="color:red;font-weight:bold;">Pending</span>';
                        }
                        
                        echo "<tr>";
                        echo "<td>$fileCount</td>";
                        echo "<td>$filename</td>";
                        echo "<td>$filetime</td>";
                        echo "<td>$UserName</td>";
                        echo "<td>$publishStatus</td>";
                        echo "<td><a href=\"mainpage.php?module=publish&publish=html&stage=edit&dirname=../published/jobs/$sourceDir&filename=$filename\"><img border=0 src=\"../css/images/edit.gif\"/></a></a></td>";
                        echo "</tr>";
                    }
                    ?>
                </table>
            </div>
        </div>
        <?php
    } else {
        echo "No file to be processed...";
    }
} else {
    echo "No Source dir...";
}
?>

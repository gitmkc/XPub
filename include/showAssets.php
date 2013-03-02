<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once("../conf/conf.php");
include_once("../classes/dbquery.php");

if (isset($_REQUEST['userName'])) {
    $UserName = $_REQUEST['userName'];
} else {
    $UserName = '';
}

//echo "User: " . $UserName . "<br/>(".$_REQUEST['sourcedir'].")<br/>";
$fileArray = array();
if (isset($_REQUEST['sourcedir'])) {
    $sourceDir = "$_REQUEST[sourcedir]";
    $Filehandler = opendir("../unpublished/$sourceDir");
    if (!$Filehandler) echo "<span style='color:red'>Error: Failed to open ($sourceDir) due to its mismatched or unsupported name.</span>";
    while ($filename = readdir($Filehandler)) {
        if (preg_match('/.html$/', $filename)) {
            $fileArray["$filename"] = "$filename";
        }
    }
    closedir($Filehandler);

    // PUBLISHED FILES
    $publishedFileArray = array();
    if (is_dir("../published/jobs/$sourceDir")) {
        $subdir = dir("../published/jobs/$sourceDir");

        //List files
        while (($filename = $subdir->read()) !== false) {
            if (preg_match('/\.html$/', $filename) && (!preg_match('/\-stg1.html$/', $filename))) {
                $filetime = filemtime("../published/jobs/$sourceDir/$filename");
                $publishedFileArray[$filename] = "$filetime";
            }
        }
        $subdir->close();
    }
    ?>
    <div class="twoColSec">
        <div class="col1">
            <h6 class="blk17">All Assets</h6>
            <div class="bx1">
                <div class="cDesd">
                    <form name="assetForm" method="post">
                        <table id="filelist" class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                            <tr class="tlhead"><th>#</th><th>Article No.</th><th>Article Name</th><th><input type='checkbox' name='checkAll' onClick="checkUncheck(document.assetForm.filecheck)"/></th></tr>
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
        <div class="mbtn"> <a href="#" class="garrow" onclick="moveCheckedItem()" title="Move file to process"></a> <a href="#" class="refresh" title="Refresh"></a> </div>
        <div class="col1">
            <h6 class="blk17">To Be Published</h6>
            <div class="bx1">
                <input type="hidden" id="sourceDir" value="<?php echo $sourceDir ?>"/>
                <div class="cDesd ritecDesc" id="processFiles">No Item to proceed</div>
            </div>
        </div>
        <div class="clear"></div>
        <input type="button" value="Publish" onclick="processFiles('targetfilelist','<?php echo $UserName ?>')" class="bluBtn mrgnLft443" />
    </div>
    <div class="clear"></div>
    <div id="publishMyHTML">
        <div class="tableBox">
            <h6 class="blk17">Published History <a style="margin-bottom: 3px; float:right" href="#" onClick="showAssetfiles('<?php echo $sourceDir?>','loadContents','<?php echo $UserName ?>')"><img align="top" src="../css/images/refresh.png"/></a></h6>
            <table class="proj_table" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr class="tab_head">
                    <th align="left" valign="middle">#</th>
                    <th align="left" valign="middle">Article No</th>
                    <th align="center" valign="middle">Published Date<br /></th>
                    <th align="left" valign="middle">Published By</th>
                    <th align="center" valign="middle">QA Status<br /></th>
                    <th align="left" valign="middle"> Edit </th>
                    <th align="left" valign="middle">Delete</th>
                </tr>
                <?php
                if (sizeof($publishedFileArray) > -1) {
                    arsort($publishedFileArray);
                    foreach ($publishedFileArray as $key => $value) {
                        $fileCount++;
                        $filename = $key;
                        $filetime = date("D, d M Y, H:i:s", $value);

                        $dbQuery->doQuery("USER_NAME,QA_STATUS", "QA_epubtable", "FILE_ID='$filename' and PACKET_NAME='$sourceDir'");
                        $UserName = $dbQuery->tableFieldValues['USER_NAME'];
                        $publishStatus = $dbQuery->tableFieldValues['QA_STATUS'];

                        if ($publishStatus == 'Done') {
                            $publishStatus = '<span style="color:green;font-weight:bold;">Done</span>';
                        } elseif ($publishStatus == 'Pending') {
                            $publishStatus = '<span style="color:red;font-weight:bold;">Pending</span>';
                        }

                        echo "<tr>";
                        echo "<td>$fileCount</td>";
                        echo "<td><a href='#'>$key</a></td>";
                        echo "<td>$filetime</td>";
                        echo "<td>$UserName</td>";
                        echo "<td>$publishStatus</td>";
                        echo "<td><a href=\"mainpage.php?module=publish&publish=html&stage=edit&dirname=../published/jobs/$sourceDir&filename=$filename\" target=\"_blank\"><img border=0 src=\"../css/images/edit.gif\"/></a></td>";
                        echo "<td>Delete</td>";
                        echo "</tr>";
                    }
                } else {
                    ?>
                    <tr>
                        <td colspan="7" align="left" valign="top">
                            <div class="noRecord">No Published Articles</div>
                        </td>
                    </tr>
                    <?php
                }
                ?>
            </table>
        </div>
    </div>
    <?php
} else {
    echo "No Item to show.";
}
?>


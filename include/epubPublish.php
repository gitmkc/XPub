<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$UserID = $_SESSION['sid'];
include_once("../conf/conf.php");
include_once("../classes/dbquery.php");
include_once("php_file_tree.php");
//echo "epub Publish...+$UserID+";
//echo "+++user:(".$UserID."===)<br/>";
//
//echo "$_REQUEST[stage]++$_REQUEST[dirname]<br/>";

if (isset($_REQUEST['taskStage']) && $_REQUEST['taskStage'] == 'movetoEpub') {
    $movePacket = $_REQUEST['packetName'];
    $dbQuery->doQuery("QA_STATUS", "QA_epubtable", "QA_STATUS='pending' and PACKET_NAME='$movePacket'");
    if ($dbQuery->tableFieldValues['QA_STATUS']) {
        ?>
        <script language="javascript" type="text/javascript">
            alert('OOPS, The Packet has not completed yet.');
        </script>
        <?php
    } else {
        system("mv ../published/jobs/$movePacket ../published/epub_publish/$UserID");
    }
}

// Check modified Jobs
$modifiedJobCount=0;
$Filehandler = opendir("../published/edit/$UserID");
while ($filename = readdir($Filehandler)) {
    if ($filename != '.' && $filename != '..') {
        $modifiedJobCount++;
    }
}
closedir($Filehandler);
$modifiedJobCount = ($modifiedJobCount)?" ($modifiedJobCount)":'';

if (isset($_REQUEST['stage']) && isset($_REQUEST['dirname'])) {
    include("modifyEpub.php");
} else {
//    $clientIP=$_SERVER["REMOTE_ADDR"];
//    echo "($clientIP)";
//    system("../webapp/scripts/myemacs.pl");
    ?>
    <form method="POST" name="publish" enctype="multipart/form-data">
        <div class="titleRow">ePub Publish</div>
        <div class="titlesubRow"><span>Type :</span><a class="TaskIcons" href="#" onClick="ViewModifiedJob('loadContents','edit','<?php echo $UserID ?>')">Modified Jobs<?php echo $modifiedJobCount?></a>
            <select id="epubtype" name='epubtype'>
                <option value='- - - Select Type - - -' selected>- - - Select Type - - -</option>
                <option value='OEBPS'>OEBPS</option>
                <option value='OPS'>OPS</option>
            </select><span style="padding-left: 10px;">Fix Layout: </span><span style="padding-left: 10px; margin-top: 3px; float: left; vertical-align: middle;"><input type="checkbox" id="fixlayout" value="Fix Layout"/></span>
        </div>
        <div class="clear"></div>
        <div id="loadContents">
            <div class="twoColSec">
                <div class="col1">
                    <h6 class="blk17">All Article(s)</h6>
                    <div class="bx1">
                        <div class="cDesd" id="assetview">
                            <table id="epubfilelist" class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                                <tr class="tlhead"><th>Name</th></tr>
                                <?php
                                //foreach ($assetsArray as $key => $value) {
                                //    $filecount++;
//                            $filecount = $filecount > 9 ? "$filecount" : "0$filecount";
                                //echo "<tr><td><img border=0 align=top src='../css/images/folder.png'/>&nbsp;<input type='hidden' id='selectedfile' value='$value'>$value</td></tr>";
                                echo "<tr><td style='border:none;' id='pubDir'>";
//                                echo php_file_tree("../published/", "javascript:alert('You clicked on [link]');");
                                echo php_file_tree("../published/epub_publish/$UserID", "javascript:alert('Clicked');");
                                echo "</td></tr>";
                                //}
                                ?>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="mbtn"><a href="#" class="garrow" onclick="dragit()"></a> <a href="#" class="refresh" onclick="removeSelect()"></a> </div>
                <div class="col1">
                    <h6 class="blk17">To Be Published</h6>
                    <div class="bx1">
                        <div class="cDesd ritecDesc">
                            <table class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                                <tr class="tlhead"><th>Name</th></tr>
                                <tr>
                                    <td><div class="drag" id="PacketName">No Item to proceed</div></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
                <input type="button" value="Publish" onClick="processEpub('PacketName','<?php echo $UserID ?>','')" class="bluBtn mrgnLft443" />
            </div>
            <div class="clear"></div>
            <div class="tableBox" id="publishEpub">
                <h6 class="blk17">Published History</h6>
                <table class="proj_table" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr class="tab_head">
                        <th align="left" valign="middle">#</th>
                        <th align="left" valign="middle">File</th>
                        <th align="left" valign="middle">Published Date<br /></th>
                        <th align="left" valign="middle">Published By</th>
                        <th align="center" valign="middle">Download <br /></th>
                        <th align="left" valign="middle">Status</th>
                        <th align="left" valign="middle">Edit</th>
                        <th align="left" valign="middle">View</th>
                        <th align="left" valign="middle">Delete</th>
                    </tr>
                    <?php
                    include("downloadTable.php");
                    ?>
                </table>
            </div>
        </div>
    </form>
    <?php
} // close of top if
?>

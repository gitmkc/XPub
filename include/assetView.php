<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once("php_file_tree.php");

//$hostaddr=gethostbyaddr($_SERVER['REMOTE_ADDR']);
$hostaddr = $_SERVER['SERVER_ADDR'];

//echo "IP: ($hostaddr)";

if ($hostaddr == '192.168.1.12') {
    $hostpath = "$hostaddr/demo/SunXpublish";
} elseif ($hostaddr == '192.168.1.199') {
    $hostpath = "$hostaddr/SunXpublish";
} else {
    $hostpath = "ubuntu/SunXpublish";
}

//echo "path: ($hostpath)";

$hostCWD = shell_exec("pwd");
?>
<div class="twoColSec">
    <div class="col1">
        <h6 class="blk17">All Article(s)</h6>
        <div class="bx1">
            <div class="cDesd" id="assetview">
                <?php
                if (isset($_REQUEST['viewDir'])) {
                    $viewDir = $_REQUEST['viewDir'];
                    $UserID = $_REQUEST['UserID'];
                    if (is_dir("../published/$viewDir/$UserID")) {
                        ?>
                        <table id="epubfilelist" class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                            <tr class="tlhead"><th>Name</th></tr>
                            <?php
                            echo "<tr><td style='border:none;' id='pubDir'>";
                            echo php_file_tree("../published/$viewDir/$UserID", "javascript:location.replace('sunxpublish:http://$hostpath/include/download.php?code=111&filename=$hostCWD/[link]');");
                            echo "</td></tr>";
                            //}
                            ?>
                        </table>
                        <?php
                    }
                }
                ?>                        
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
    <input type="button" value="Publish" onClick="processEpub('PacketName','<?php echo $UserID ?>','editedEpub')" class="bluBtn mrgnLft443" />
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

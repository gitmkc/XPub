<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//echo "$_REQUEST[stage]++$_REQUEST[dirname]++=($UserID)<br/>";
include_once("php_file_tree.php");

//$hostaddr=gethostbyaddr($_SERVER['REMOTE_ADDR']);
$hostaddr=$_SERVER['SERVER_ADDR'];

//echo "IP: ($hostaddr)";

if ($hostaddr == '192.168.1.12') {
    $hostpath="$hostaddr/demo/SunXpublish";
} elseif ($hostaddr == '192.168.1.199') {
    $hostpath="$hostaddr/SunXpublish";
} else {
    $hostpath="ubuntu/SunXpublish";
}

$hostCWD = shell_exec("pwd");

//echo "($hostpath+$hostCWD)";

$epubdir = "$_REQUEST[dirname]";
system("cp -p \"$epubdir\" \"../published/edit/$UserID\"");

$epubDirName = basename($epubdir);
//echo $epubDirName . ")))";
$epubDirName = preg_replace("/(.+?)-epub.zip/", "$1", "$epubDirName");
//echo "++".$epubDirName."+++";
system("/usr/bin/unzip -q -o \"../published/edit/$UserID/$epubDirName-epub.zip\" -d \"../published/edit/$UserID/$epubDirName\"");

system("mv ../published/edit/$UserID/$epubDirName/$epubDirName.epub ../published/edit/$UserID/$epubDirName/$epubDirName.zip");
system("/usr/bin/unzip -q -o \"../published/edit/$UserID/$epubDirName/$epubDirName.zip\" -d ../published/edit/$UserID/$epubDirName-edit");
system("rm -r ../published/edit/$UserID/$epubDirName && mv ../published/edit/$UserID/$epubDirName-edit ../published/edit/$UserID/$epubDirName");
unlink("../published/edit/$UserID/$epubDirName-epub.zip");
unlink("../published/download/$UserID/$epubDirName-epub.zip");
//unlink("../published/download/$UserID/$epubDirName.plg");
?>
<form method="POST" name="publish" enctype="multipart/form-data">
    <div class="titleRow">ePub Publish: Edit</div>
    <div class="titlesubRow"><span>Type :</span>
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
                    <div class="cDesd">
                        <table id="epubfilelist" class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                            <tr class="tlhead"><th>Name</th></tr>
                            <?php
                            //foreach ($assetsArray as $key => $value) {
                            //    $filecount++;
//                            $filecount = $filecount > 9 ? "$filecount" : "0$filecount";
                            //echo "<tr><td><img border=0 align=top src='../css/images/folder.png'/>&nbsp;<input type='hidden' id='selectedfile' value='$value'>$value</td></tr>";
                            echo "<tr><td style='border:none;' id='pubDir'>";
//                                echo php_file_tree("../published/", "javascript:alert('You clicked on [link]');");
                            echo php_file_tree("../published/edit/$UserID", "javascript:location.replace('sunxpublish:http://$hostpath/include/download.php?code=111&filename=$hostCWD/[link]');");
                            echo "</td></tr>";
                            //}
                            ?>
                        </table>
                    </div>
                </div>
            </div>
            <div class="mbtn"> <a href="#" class="garrow" onclick="dragit()"></a> <a href="#" class="refresh"></a> </div>
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
            <input type="button" value="Publish" onClick="processEpub('PacketName','<?php echo $UserID?>','editedEpub')" class="bluBtn mrgnLft443" />
        </div>
        <div class="clear"></div>
        <div class="tableBox" id="modifyEPub">
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

<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include("php_file_tree.php");

echo "I am here...";
if (isset($_REQUEST['epubpacket'])) {
    echo "packet=(" . $_REQUEST['epubpacket'] . ")<br>";
}
        
$eassetsArray = array();
$Filehandler = opendir("../published/");
while ($filename = readdir($Filehandler)) {
    if ((is_dir("../published/$filename")) && ($filename != '.') && ($filename != "..")) {
        echo "($filename), ";
        $eassetsArray[] = $filename;
    }
}
closedir($Filehandler);

        
//echo php_file_tree('../published/', 'javascript:alert("You clicked on [link]");');
?>
        <div class="twoColSec">
            <div class="col1">
                <h6 class="blk17">All Article(s)</h6>
                <div class="bx1">
                    <div class="cDesd">
                        <?php
                        if (count($eassetsArray) > 0) {
                            ?>
                            <table id="epubfilelist" class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                                <tr class="tlhead"><th>Name</th></tr>
                                <?php
                                //foreach ($assetsArray as $key => $value) {
                                //    $filecount++;
//                            $filecount = $filecount > 9 ? "$filecount" : "0$filecount";
                                //echo "<tr><td><img border=0 align=top src='../css/images/folder.png'/>&nbsp;<input type='hidden' id='selectedfile' value='$value'>$value</td></tr>";
                                echo "<tr><td style='border:none;' id='pubDir'>";
                                echo php_file_tree('../published/', 'javascript:alert("You clicked on [link]");');
                                echo "</td></tr>";
                                //}
                                ?>
                            </table>
                            <?php
                        } else {
                            echo "No item availabel in the published repository!<br/>";
                        }
                        ?>
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
            <input type="button" value="Publish" onClick="processEpub('PacketName')" class="bluBtn mrgnLft443" />
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
                    <th align="left" valign="middle"> Edit </th>
                    <th align="left" valign="middle">Delete</th>
                </tr>
                <tr>
                    <td colspan="7" align="left" valign="top">
                        <div class="noRecord">No Published Articles</div>
                    </td>
                </tr>
            </table>
        </div>

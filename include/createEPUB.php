<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once("../conf/conf.php");
include_once("../classes/dbquery.php");
include_once("php_file_tree.php");

$epubTask = 'generate';

if (isset($_REQUEST['epubpacket'])) {
//    echo "packet=(" . $_REQUEST['epubpacket'] . ")<br>";
    $epubDir = $_REQUEST['epubpacket'];
    $UserID = $_REQUEST['UserID'];
    $epubtype = $_REQUEST['epubtype'];
    $fixlayout = $_REQUEST['fixlayout'];
//    echo "UserID=".$UserID."==<br/>";
    // select QA_STATUS from QA_epubtable where QA_STATUS='Pending' and PACKET_NAME='9781909007710'
    $dbQuery->doQuery("QA_STATUS", "QA_epubtable", "QA_STATUS='pending' and PACKET_NAME='$epubDir'");
    if ($dbQuery->tableFieldValues['QA_STATUS']) {
        print $dbQuery->tableFieldValues['QA_STATUS'] . "<br/>";
    }
    
    if (isset($_REQUEST['epubstage']) && $_REQUEST['epubstage'] == 'editedEpub') {
        if (file_exists("../published/edit/$UserID/$epubDir/$epubtype/NAV.log") || file_exists("../published/edit/$UserID/$epubDir/$epubtype/OPF.log")) {
            $epubTask = 'generate';
            system("cd ../published/edit/$UserID/$epubDir/$epubtype && /usr/bin/zip -Xqr ../../../../upload/$UserID/$epubDir.zip css fonts images *.html *.xhtml");
            system("rm -r ../published/edit/$UserID/$epubDir");
        } else {
            $epubTask = 'validate';
            system("cd ../published/edit/$UserID/$epubDir && /usr/bin/zip -Xqr ../../../upload/$UserID/$epubDir.epub mimetype META-INF $epubtype");
    //        rename("../published/edit/$UserID/$epubDir", "../published/upload/$UserID/$epubDir");
            system("rm -r ../published/edit/$UserID/$epubDir");
        }
    } else {
        system("cd ../published/epub_publish/$UserID/$epubDir && /usr/bin/zip -Xqr ../../../upload/$UserID/$epubDir.zip *");
        //rename("../published/jobs/$epubDir", "../published/upload/$UserID/$epubDir");
//	system("mv ../published/jobs/$epubDir ../published/upload/$UserID/$epubDir");
        system("rm -r ../published/epub_publish/$UserID/$epubDir"); //rm -r ../published/jobs/$epubDir && 
    }
    // Create and Validate Epub    
    system("perl \"../webapp/scripts/createEPub.pl\" \"$epubTask\" \"$UserID\" \"$epubDir.zip\" \"$epubtype\" \"$fixlayout\"");

    // Delete dir from unpublished
    if (is_dir("../unpublished/$epubDir")) {
        rmdir("../unpublished/$epubDir");
    }

    // Delete QA Table
    $sql = "delete from QA_epubtable where PACKET_NAME=$epubDir";
    mysql_query($sql);
}
?>
<div id="spinner" class="spinner" style="display:none;">
    <img id="img-spinner" src="../css/images/ajax-loader.gif" alt="Loading"/>
</div>
<script type="text/javascript">
jQuery.ajaxSetup({
  beforeSend: function() {
     $('#spinner').show();
  },
  complete: function(){
     $('#spinner').hide();
  },
  success: function() {}
});
</script>
<div class="twoColSec">
    <div class="col1">
        <h6 class="blk17">All Article(s)</h6>
        <div class="bx1">
            <div class="cDesd">
                <table id="epubfilelist" class="lftWht" width="100%" cellpadding="0" cellspacing="0">
                    <tr class="tlhead"><th>Name</th></tr>
                    <?php
                    echo "<tr><td style='border:none;' id='pubDir'>";
                    echo php_file_tree("../published/epub_publish/$UserID", 'javascript:alert("You clicked on [link]");');
                    echo "</td></tr>";
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

<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//echo "HTML Publish...";
$UserName = $_SESSION['sname'];
//if (isset($_REQUEST['SourceDirFromEdit'])) {
//    $assetSelectValue = "$_REQUEST[SourceDirFromEdit]";
//} else {
//    $assetSelectValue='---SELECT---';
//}
if ($hostaddr == '192.168.1.12') {
    $hostpath = "$hostaddr/demo/SunXpublish";
} elseif ($hostaddr == '192.168.1.199') {
    $hostpath = "$hostaddr/SunXpublish";
} else {
    $hostpath = "ubuntu/SunXpublish";
}

//echo "path: ($hostpath)";

$hostCWD = shell_exec("pwd");
//echo $hostCWD;
?>
<form method="POST" name="publish" enctype="multipart/form-data">
    <div class="titleRow">HTML Publish</div>
    <div class="titlesubRow"><span>Unpublished Repository :</span><a class="modalInput cssedit" rel="#yesno" href="#">Modify CSS</a><a class="changeStage" href="#" onClick="changeStage('asset','epub')">Change Stage</a>
        <select id="asset" name='asset' onChange="showAssetfiles(this.value,'loadContents','<?php echo $UserName ?>')">
            <option value='---SELECT---'>---SELECT---</option>
            <?php
            foreach ($assetsArray as $key => $value) {
                echo "<option value='$value'>$value</option>";
            }
            ?>
        </select>
    </div>
    <div class="clear"></div>
    <div id="loadContents">
        <div class="twoColSec">
            <div class="col1">
                <h6 class="blk17">All Assets</h6>
                <div class="bx1">
                    <div class="cDesd">No Item to show</div>
                </div>
            </div>
            <div class="mbtn"> <a href="#" class="garrow" title="Publish HTML for ePub"></a> <a href="#" class="refresh" title="Refresh"></a> </div>
            <div class="col1">
                <h6 class="blk17">To Be Published</h6>
                <div class="bx1">
                    <div class="cDesd ritecDesc">No Item to proceed</div>
                </div>
            </div>
            <div class="clear"></div>
            <input type="button" value="Publish" class="bluBtn mrgnLft443" />
        </div>
        <div class="clear"></div>
        <div class="tableBox">
            <h6 class="blk17">Published History</h6>
            <table class="proj_table" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr class="tab_head">
                    <th align="left" valign="middle">#</th>
                    <th align="left" valign="middle">Article No</th>
                    <th align="left" valign="middle">Published By</th>
                    <th align="center" valign="middle">Published Date<br /></th>
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
    </div>
<!-- yes/no dialog -->
<div class="modal" id="yesno">
  <div class="titleRow">CSS Editor (<span id="cssJobName"></span>)</div>
  <textarea id="csseditor" cols="75" rows="20" wrap="off" style="width: 100%;">
    You can edit CSS stylesheet in this dialog. Please select appropriate packet name.
  </textarea>
  <!-- yes/no buttons -->
  <p>
    <input type="button" name="cssSave" value="Save" class="close bluBtn" onclick="saveCSSbyEditor('csseditor')"/>
    <input type="button" value="Cancel" class="close bluBtn" />
  </p>
</div>
<script>
$(document).ready(function() {
  //javascript:location.replace('sunxpublish:http://$hostpath/include/download.php?code=111&filename=$hostCWD/[link]');
  // get user input
  $("select#asset").change(function() {
      var input = $("select#asset option:selected").val();
      if (input != '' && input != '---SELECT---') {
        var triggers = $(".modalInput").overlay({

          // some mask tweaks suitable for modal dialogs
          mask: {
            color: '#ebecff',
            loadSpeed: 200,
            opacity: 0.8
          },

          closeOnClick: false
        });
        $.ajax({
            type: "POST",
            url: "editcss.php?dir=../published/jobs/"+input,
            //url: "sunxpublish:http://$hostpath/include/download.php?code=111&filename=$hostCWD/"+input+"/css/stylesheet.css",
            success: function(html){ 
              if(html!="") {                
                $("textarea#csseditor").fadeIn(500);
                $("span#cssJobName").html(input);
                $("textarea#csseditor").text(html);
              }
            }
         });
      } else {
        alert('Please select valid repository.');
      }
  });
});
</script>
</form>

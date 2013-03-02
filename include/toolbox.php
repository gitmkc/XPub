<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
if (isset($_REQUEST['uploadsource'])) {
    if ($_FILES["uploadfile"]["name"]) {
        $uploadStatus = include('uploadfile.php');
        $filename = $_FILES["uploadfile"]["name"];
//        echo "$filename<br/>";
//        echo "($uploadStatus)..";
        if (($filename) && ($uploadStatus == 'success')) {
            $target_path = '../unpublished/';
            $_SESSION['targetpath'] = $target_path;
            $filename = preg_replace("/(.+?).zip/", "$1", $filename);
//            echo "($filename)";
            // Unzip the packet
            system("unzip -q -o \"$target_path$filename\" -d $target_path$filename && chmod 777 $target_path$filename -R");
            // Remove zip file
            //system("rm -r  $target_path$filename.zip");
        }
    }
    
    //
    if ($uploadStatus == 'success') {
        $uploadStatus="<div class='ErrorMessage' style='width:250px;'><b>Status:<b> The file has been uploaded successfully.</div>";
    } elseif ($uploadStatus == 'success') {
        $uploadStatus="<div class='ErrorMessage' style='width:250px;'><b>Error: </b>Uploading error. Please try again.</div>";
    } elseif ($uploadStatus == 'invalid') {
        $uploadStatus="<div class='ErrorMessage' style='width:250px;'><b>Error: </b>Invalid file format.</div>";
    } else {
        $uploadStatus="<div class='ErrorMessage' style='width:250px;'>Failed to upload. Please try again.</div>";
    }
}
?>
<div class="heading">Toolbox</div>
<div class="clear"></div>
<div id="container">
    <div class="project_detail_sec">
        <div class="proj_cur_btm">
            <div class="proj_main">
                <div class="mainEditdiv">
                    <div class="publishBar">
                        <div id="publishBarB"><div class="titleRow">&nbsp;Upload</div>
                            <div class="titlesubRow">&nbsp;Source File</div>
                            <form method="POST" name="uploadtool" enctype="multipart/form-data" onsubmit="return uploadValidateInTool();">
                                <table class="uploadtable" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="formlabel" valign="top">
                                            <table  border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td valign="top"><input type="file" size="70" id="uploadfile" name="uploadfile" class="browsebtn"/><br />
                                                        <span class="formlabel">Note:</span> &nbsp;<span style="font-size: 11px;  color:#000;">Should be [ISBN.zip OR ProjectTitle.zip]</span></td>
                                                    <td valign="top"><input type="submit" name="uploadsource" class="inputbutton" value="Upload"/></td><td><?php echo $uploadStatus;?></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                        <div id="publishBarB"><div class="titlesubRow">&nbsp;Images</div>
                            <form method="POST" name="uploadtool" enctype="multipart/form-data" onsubmit="return uploadValidateInTool();">
                                <table class="uploadtable">
                                    <tr>
                                        <td class="formlabel" valign="top">
                                            <table  border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="formlabeltext" valign="top"><input type="file" size="70" id="uploadfile" name="uploadfile" class="browsebtn"/><br />
                                                        <span class="formlabel">Note:</span> &nbsp;<span style="font-size: 11px; color:#000;">Should be [ISBN_images.zip]</span></td>
                                                    <td valign="top"><input type="submit" name="uploadimage" class="inputbutton" value="Upload"/></td>
                                                </tr></table>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                        <div id="publishBarB"><div class="titlesubRow">&nbsp;HTML</div>
                            <table class="uploadtable" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="formlabel" valign="top">
                                        <!--                                        <fieldset><legend>HTML</legend>-->
                                        <table  border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                                <td class="formlabeltext" valign="top"><input type="file" size="70" id="uploadfile" name="uploadfile" class="browsebtn"/><br />
                                                    <span class="formlabel">Note:</span> &nbsp;<span style="font-size: 11px;  color:#000;">Should be [file.html or file.xhtml]</span></td>
                                                <td valign="top"><input type="submit" name="upload" class="inputbutton" value="Upload"/></td>
                                            </tr>
                                        </table>
                                        <!--                                        </fieldset>-->
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
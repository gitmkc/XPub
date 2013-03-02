<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
if (empty($_SESSION['sname'])) {
    header('location:../index.php');
}


//echo $_SESSION['sname']."<br/>";
$UserName = $_SESSION['sname'];
$UserID = $_SESSION['sid'];

//
$assetsArray = array();
$Filehandler = opendir("../unpublished/");
while ($filename = readdir($Filehandler)) {
    if ((is_dir("../unpublished/$filename")) && ($filename != '.') && ($filename != "..")) {
        $assetsArray["$filename"] = $filename;
    }
}
closedir($Filehandler);

//print_r($_REQUEST);
?>
<div class="heading">Publish</div>
<ul class="navright">
    <li<?php if ($_REQUEST['publish'] == 'html' || $_REQUEST['publish'] == '')
    echo " class='active'"
    ?>><a href="mainpage.php?module=publish&publish=html" title="Publish HTML for ePub">HTML Publish</a></li>
    <!--    <li<?php if ($_REQUEST['publish'] == 'online')
        echo " class='active'"
        ?>><a href="mainpage.php?module=publish&publish=online">Online Publish</a></li>-->
    <li<?php if ($_REQUEST['publish'] == 'epub')
        echo " class='active'"
    ?>><a href="mainpage.php?module=publish&publish=epub" title="Publish ePub">ePub Publish</a></li>
    <li<?php if ($_REQUEST['publish'] == 'xml')
    echo " class='active'"
    ?>><a href="mainpage.php?module=publish&publish=xml" title="Publish XML">XML Publish</a></li>
    <li<?php if ($_REQUEST['publish'] == 'pdf')
        echo " class='active'"
    ?>><a href="mainpage.php?module=publish&publish=pdf" title="Publish PDF">PDF Publish</a></li>
    <li<?php if ($_REQUEST['publish'] == 'other')
        echo " class='active'"
        ?>><a href="mainpage.php?module=publish&publish=other">Other</a></li>
</ul>
<div class="clear"></div>
<div id="container">
    <div class="project_detail_sec">
        <div class="proj_cur_btm">
            <div class="proj_main">
                <?php
                if ($_REQUEST['publish'] == 'html') {
                    if (isset($_REQUEST['stage']) && $_REQUEST['stage'] == 'edit') {
                        include('edit.php');
                    } else {
                        include("htmlPublish.php");
                    }
//                } elseif ($_REQUEST['publish'] == 'online') {
//                    include("htmlpublish.php");
                } elseif ($_REQUEST['publish'] == 'epub') {
//                    echo "user:(".$UserID.")<br/>";
                    if ((isset($_REQUEST['stage']) && $_REQUEST['stage'] == 'createEpub') && isset($_REQUEST['SourceDirFromEdit'])) {
                        $epubDir = $_REQUEST['SourceDirFromEdit'];
                        system("mv ../published/jobs/$epubDir ../published/epub_publish/$UserID");
                        system("rm -r ../unpublished/jobs/${epubDir}-epub.zip");
                    } elseif (isset($_REQUEST['action']) && $_REQUEST['action'] == 'epubdelete') {
                        $packetname = $_REQUEST['packetname'];
                        if ($packetname) {
                            //echo "($packetname)";
                            unlink("$packetname"); // delete zip file
                            $packetname=preg_replace("/(.+?)-epub.zip$/", "$1", $packetname);
                            //echo "+(".$packetname.")";
                            if (file_exists("$packetname.epub")) {
                                unlink("$packetname.epub");
                            }
                            unlink("$packetname.plg"); // delete .plg file
                        }
                    }
                    include("epubPublish.php");
                } elseif ($_REQUEST['publish'] == 'xml') {
                    echo "Page Under Construction<br/>";
                } elseif ($_REQUEST['publish'] == 'pdf') {
                    echo "Page Under Construction<br/>";
                } elseif ($_REQUEST['publish'] == 'other') {
                    echo "Page Under Construction<br/>";
                } else {
                    include("htmlPublish.php");
                }
                ?>
            </div>
        </div>
    </div>
</div>

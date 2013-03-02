<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//session_start();
require_once "../cuteeditor_files/include_CuteEditor.php";
//include_once("http://www.tsprojects.net/demo/SunXpublish/cuteeditor_files/include_CuteEditor.php");
//include_once("/home/tsprojec/public_html/demo/SunXpublish/cuteeditor_files/include_CuteEditor.php");

if (empty($_SESSION['sname'])) {
    header('location:../index.php');
}

$UserName = $_SESSION['sname'];
//include_once("top.php");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>SunXPublish - Digital Publishing Platform</title>
        <link rel="stylesheet" href="../css/style.css" type="text/css" />
        <script src="../js/jquery-1.3.2.js" type="text/javascript"></script>
        <script src="../js/php_file_tree_jquery.js" type="text/javascript"></script>
        <link href="../css/styles/default/default.css" rel="stylesheet" type="text/css" media="screen" />
        <script language="javascript" src="../js/jscript.js"></script>
        <script language="javascript" src="../js/select_box.js"></script>
        <script src="../js/jquery.tools.min.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="/media/css/standalone.css"/>
    </head>
    <body>
        <div id="wrapper">
            <!--wrapper starts-->

            <div class="mainheader">
                <div class="top">
                    <!--top starts-->
                    <h1 class="logo"><a href="#"></a></h1>
                    
                    <div class="top_right">
                        <div class="top_f_sec">
                            <div class="login_icon"></div> <strong>Welcome</strong>
                            <?php echo $UserName ?>
                            

                        </div>
                        <!--div class="innerclock">Saturday, 18 August 2012, 04 : 11 : 02 PM</div-->
                        <ul>
                        <li class="faq"><a href="#">FAQ</a></li>
                            <li class="last"><a href="../docs/SunXPublish.pdf" target=_blank>Help</a></li>
                            <li class="logout"><a href="../index.php" class="logout">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <div class="nav">
                <ul>
                    <li <?php if ($_REQUEST['module'] == 'project' || $_REQUEST['module'] == '')
                                echo " class='active'" ?>><a href="mainpage.php?module=project"><span><img src="../css/images/project_icon.png" alt="" />Project</span></a></li>
                    <li <?php if ($_REQUEST['module'] == 'toolbox')
                                echo " class='active'" ?>><a href="mainpage.php?module=toolbox"><span><img src="../css/images/toolbox.png" alt="" />Toolbox</span></a></li>
                    <li <?php if ($_REQUEST['module'] == 'publish')
                                echo " class='active'" ?>><a href="mainpage.php?module=publish"><span><img src="../css/images/publish_icon.png" alt="" />Publish</span></a></li>
                    <li <?php if ($_REQUEST['module'] == 'report')
                                echo " class='active'" ?>><a href="mainpage.php?module=report"><span><img src="../css/images/report_icon.png" alt="" />Reports</span></a></li>
                    <li <?php if ($_REQUEST['module'] == 'vendor')
                                echo " class='active'" ?>><a href="mainpage.php?module=vendor"><span><img src="../css/images/vendor_icon.png" alt="" />Vendor</span></a></li>
                </ul>
            </div>
            <div class="subWrap">
                <!--wrapper starts-->
                <!--top ends-->
                <div class="clear"></div>
                <?php
                if (isset($_REQUEST['module']) && $_REQUEST['module'] == 'project') {
                    include('project.php');
                } elseif (isset($_REQUEST['module']) && $_REQUEST['module'] == 'report') {
                    include('report.php');
                } elseif (isset($_REQUEST['module']) && $_REQUEST['module'] == 'publish') {
//                    if (isset($_REQUEST['stage']) && $_REQUEST['stage'] == 'edit') {
//                        include('edit.php');
//                    } else {
                    include('publish.php');
//                    }
                } elseif (isset($_REQUEST['module']) && $_REQUEST['module'] == 'toolbox') {
                    include('toolbox.php');
                } elseif (isset($_REQUEST['module']) && $_REQUEST['module'] == 'vendor') {
                    include('vendor.php');
                } else {
                    include('project.php');
                }
                ?>
                <div class="clear"></div>
                <!--wrapper ends-->
            </div>
<?php
// footer
include('footer.php');
?>
        </div>
    </body>
</html>
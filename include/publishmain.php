<?php
include_once("../conf/conf.php");

// Vars 
$host = "127.0.0.1"; //127.0.0.1 192.168.1.250
$user = "root";
$passwd = "123456"; //india
$db = "publish";

// create Object
$dbObject = new database($host, $user, $passwd);
$dbObject->dbSelect($db);

//$loginError = '';
$flag = 1;
if (isset($_POST['form_1'])) {
    include('login.php');
    if ($flag == 1) {
        session_start();
        $_SESSION['sid'] = $loginField->user_id;
        $_SESSION['sname'] = $loginField->user_name;
        header('location:mainpage.php');
    }
}
//include_once("top.php");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>SunXPublish - Digital Publishing Platform</title>
<link rel="stylesheet" href="../css/style.css" type="text/css" />
<script language="javascript" src="../js/jscript.js"></script>
<script language="javascript" src="../js/select_box.js"></script>
</head>
    <body style="background:#eee;">
    <div id="header">
        <?php
        // header
        include('header.php');
        ?>
    </div>
    <div class="clear"></div>
        <div class="innerCont">
            <div class="sld">
                <div class="sldWrap"><img src="../css/images/slider.jpg" alt="" width="408" height="229" /></div>
            </div>
            <div class="loginWrap">
                <?php
                if (isset($loginError)) {
                    ?>
                    <div id="loginError"><?php echo "<b>Error: </b>$loginError" ?></div>
                    <?php
                }
                ?>
                <div class="loginCont">
                    <form action="" onload="javascript: window.resizable=false;" method="post" name="loginform" onSubmit="return ValidateAllFields()">
                        <div class="loginTitle">Login</div>
                        <ul>
                            <li> <span>Usename</span>
                                <input type="text" id="username" name="id"/>
                            </li>
                            <li> <span>Password</span>
                                <input id="password" name="pwd" type="password"/>
                            </li>
                            <li class="pl80"> <a href="#" class="frgt">Forgot Password</a> <a href="#" class="signUp">Sign Up</a> </li>
                            <li>
                                <input name="form_1" type="submit" value="Login"  />
                            </li>
                        </ul>
                    </form>
                </div>
            </div>
            <div class="clear"></div>
            <div class="hpContLeft">
                <h6 class="title">Advantage of SXP</h6>
                <ul class="blueList">
                    <li>This is web-based authoring and content processing tool to cater the needs of publications. It enables the creation of structured content in an easy to use word like publishing environment.</li>
                </ul>
            </div>
            <div class="hpContRight">
                <h6 class="title">Note</h6>
                <ul class="blueList">
                    <li>SXP supports the Firefox 4.0 and above.</li>
<!--                    <li><a href="#">Note 2.</a></li>-->
                </ul>
            </div>
        </div>
    <div class="clear"></div>
    <?php
    // footer
    include('footer.php');
    ?>
</body>
</html>

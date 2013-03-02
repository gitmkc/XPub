<?php
$id = $pwd = "";
//$flag = 1;
if (isset($_POST['id']) && isset($_POST['pwd'])) {
    $id = $_POST['id'];
    $pwd = $_POST['pwd'];
    // SQL query
    $result = mysql_query("select user_id, user_pass, user_name from pb_emp_master where user_id='$id'"); //   AND user_pass='$pwd'
    $loginField = mysql_fetch_object($result);

    if (empty($id) || empty($pwd)) {
        $loginError = "The field couldn't be empty!";
        $flag = 0;
    }

    if ($id != $loginField->user_id) {
        $loginError = "The Userid mismatched.";
        $flag = 0;
    }

    if ($pwd != $loginField->user_pass) {
        $loginError = $loginError . " The Password mismatched!";
        $flag = 0;
    }
}
?>
<?php
class database {
    private $db_connect;
    private $user_name;
    private $password;
    private $data_base;
    private $host_name;
    private $sql;
    private $results;

    function __construct($host, $user, $passwd) {
        if (!mysql_connect($host, $user, $passwd)) {
            echo "Error connecting to Database...";
        } else {
	        $this->db_connect = mysql_connect($host, $user, $passwd);
        }
    }

    function dbSelect($db) {
        $this->database = $db;
        if (!mysql_select_db($this->database, $this->db_connect)) {
            echo "Error selecting to Database...";
        } else {
	    //$this->mysql_select_db($this->database, $this->db_connect);
            /* echo "selected Database"; */
        }
    }
}

$host = "127.0.0.1"; //127.0.0.1 192.168.1.250
$user = "root";
$passwd = "123456"; //india
$db = "publish";

// create Object
$dbObject = new database($host, $user, $passwd);
$dbObject->dbSelect($db);

//$dbObject->executeSql($sql);
?>

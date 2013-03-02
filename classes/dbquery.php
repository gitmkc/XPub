<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class dbquery {

    // Add Records
    function addRecords($FieldList, $tableName) {
        print "$tableName,$FieldList<br/>";
        $sql = "insert into $tableName values ($FieldList)";
        if (mysql_query($sql)) {
            echo "Done<br/>";
        } else {
            echo "fail<br/>";
        }
    }

    function doQuery($selectFields, $tableName, $condition) {
        if ($condition != '') {
            $sql = mysql_query("SELECT $selectFields FROM $tableName WHERE $condition");
        } else {
            $sql = mysql_query("SELECT $selectFields FROM $tableName");
        }

        $this->tableFieldValues = array();

        while ($result = mysql_fetch_array($sql)) {
            foreach ($result as $key => $value) {
                $this->tableFieldValues[$key] = $value;
            }
        }
    }

    function updateQuery($updateFields, $tableName, $condition) {
        foreach ($updateFields as $key => $value) {
            $sql = "update $tableName set $key=\"$value\" where $condition";
            if (mysql_query($sql)) {
//                echo "<br/>**Updated++$tableName=$condition=($key)<br/>';
            } else {
                //echo "OOPS!! Failed to update value ($value) into database.";
            }
        }
    }

}

$dbQuery = new dbquery();
?>

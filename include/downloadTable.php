<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once("../conf/conf.php");
include_once("../classes/dbquery.php");

$dbQuery->doQuery("user_name", "pb_emp_master", "user_id='$UserID'");
if ($dbQuery->tableFieldValues['user_name']) {
    $UserName=$dbQuery->tableFieldValues['user_name'];
}


$downloadFileArray = array();
$downloaddir = "../published/download/" . $UserID;
$Filehandler = opendir($downloaddir);
while ($filename = readdir($Filehandler)) {
    $realFileName = $filename;
    if (preg_match("/-epub.zip$/", $realFileName)) {
        $realFileName = preg_replace("/-epub.zip$/", "", $realFileName);
    } elseif (preg_match("/.plg$/", $realFileName)) {
        $realFileName = preg_replace("/.plg$/", "", $realFileName);
    } elseif (preg_match("/.epub$/", $realFileName)) {
        $realFileName = preg_replace("/.epub$/", "", $realFileName);
    }

    if ($realFileName != '.' && $realFileName != '..') {
        if (file_exists("$downloaddir/$realFileName-epub.zip")) {
            $filetime = filemtime("$downloaddir/$realFileName-epub.zip");
            $downloadFileArray["$realFileName-epub.zip"] = "$filetime";
        } else {
            $filetime = filemtime("$downloaddir/$realFileName.plg");
            $downloadFileArray["$realFileName.plg"] = "$filetime";
        }
    }
}
closedir($Filehandler);


if ($downloadFileArray) {
    arsort($downloadFileArray);
    foreach ($downloadFileArray as $key => $value) {
        $filecount++;

        $ePacketName = $key;

        if ($filecount % 2 == 0) {
            $trClass = " class=\"evenRow\"";
        } else {
            $trClass = " class=\"oddRow\"";
        }

        $filecount = ($filecount > 9) ? "$filecount" : "0$filecount";

        // Get real file name
        $realFilename = $key;

        if (preg_match("/-epub.zip$/", $realFilename)) {
            $realFilename = preg_replace("/-epub.zip$/", "", $realFilename);
        } elseif (preg_match("/.plg$/", $realFilename)) {
            $realFilename = preg_replace("/.plg$/", "", $realFilename);
        }

        //$realFilename = preg_replace('/^(.+?)\-epub\.zip$/', "$1", $realFilename);

        $errNo = shell_exec("fgrep -e \"There were\" ../published/download/$UserID/$realFilename.plg | cut -f3 -d\" \"") . "\n";
        $errNo = rtrim($errNo);
        if ($errNo) {
            $errNo = "<span style=\"color:red\">Failed ($errNo)</span>";
        } else {
            $errNo = shell_exec("fgrep -e \"There was\" ../published/download/$UserID/$realFilename.plg | cut -f3 -d\" \"") . "\n";
            $errNo = rtrim($errNo);
            if ($errNo == 'one') {
                $errNo = 1;
            }
            if ($errNo) {
                $errNo = "<span style=\"color:red\">Failed ($errNo)</span>";
            } else {
                $errNo = "<span style=\"color:green\">Success</span>";
            }
        }

        //echo "<td><a href=\"mainpage.php?stage=published&action=QA&dirname=../published/$sourceDir&selectedfilename=$value\">Edit</a></td>";

        $value = date("D, d M Y, H:i:s", $value);
        echo "<tr$trClass>";
        echo "<td>$filecount</td>";
        echo "<td>$ePacketName</td>"; //
        echo "<td>$value</td>";
        echo "<td>$UserName</td>";

        if (preg_match("/.plg$/", $ePacketName)) {
            echo "<td>N/A</td>";
        } else {
            echo "<td><a href='../published/download/$UserID/$ePacketName'>Download</a></td>";
        }

        echo "<td><a href=\"javascript:viewLogFile('../published/download/$UserID/$realFilename.plg')\">$errNo</a></td>";
        if ($errNo == "<span style=\"color:green\">Success</span>") {
            echo "<td align=center>N/A</td>";
        } else {
            if (preg_match("/.plg$/", $ePacketName)) {
                echo "<td align=center>N/A</td>";
            } else {
                echo "<td align=center><a href='mainpage.php?module=publish&publish=epub&stage=editEpub&dirname=$downloaddir/$ePacketName'><img border=\"0\" align=\"top\" src='../css/images/edit.png' alt=''/></a></td>";
            }
        }
        echo "<td align=center><a href='../published/download/$UserID/$realFilename.epub'><img border=\"0\" align=\"top\" width=20 height=20 src=\"../css/images/epub.png\"/></a></td>";
        echo "<td align=center><a href=\"#\" onclick=\"if (confirm('Are you sure you want to delete the packet?')) window.location='mainpage.php?module=publish&publish=epub&action=epubdelete&packetname=$downloaddir/$ePacketName'; return false\"><img border=\"0\" align=\"top\" src=\"../css/images/Images_delete.gif\"/></a></td>";
        echo "</tr>";
    }
} else {
    echo "<tr><td colspan='8' align='left' valign='top'><div class='noRecord'>No Published Articles</div></td></tr>";
}
?>

/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// D I G I T A L  C L O C K
// digital clock
tday  =new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
tmonth=new Array("January","February","March","April","May","June","July","August","September","October","November","December");

function GetClock(){
    d = new Date();
    nday   = d.getDay();
    nmonth = d.getMonth();
    ndate  = d.getDate();
    nyear = d.getYear();
    nhour  = d.getHours();
    nmin   = d.getMinutes();
    nsec   = d.getSeconds();
    
    if(nyear<1000) nyear=nyear+1900;
    
    if(nhour ==  0) {
        ap = " AM";
        nhour = 12;
    } 
    else if(nhour <= 11) {
        ap = " AM";
    } 
    else if(nhour == 12) {
        ap = " PM";
    } 
    else if(nhour >= 13) {
        ap = " PM";
        nhour -= 12;
    }
    
    if(nhour <= 9) {
        nhour = "0" +nhour;
    }
    if(nmin <= 9) {
        nmin = "0" +nmin;
    }
    if(nsec <= 9) {
        nsec = "0" +nsec;
    }
    
    var clockElement = document.getElementById("clockbox");
    
    if (clockElement != null) {
        document.getElementById('clockbox').innerHTML=""+tday[nday]+", "+ndate+" "+tmonth[nmonth]+" "+nyear+", "+nhour+" : "+nmin+" : "+nsec+ap+"";
        setTimeout("GetClock()", 1000);
    } else {
    }
}

function start() {
//    GetClock();
}

window.onload = start;


// XMLhttpRequest
function getXMLHttp()
{
    var xmlHttp;

    try
    {
        //Firefox, Opera 8.0+, Safari
        xmlHttp = new XMLHttpRequest();
    }
    catch(e)
    {
        //Internet Explorer
        try
        {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch(e)
        {
            try
            {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch(e)
            {
                alert("Your browser does not support AJAX!")
                return false;
            }
        }
    }
    return xmlHttp;
}


//  S H O W  A S S E T'S  F I L E S
function showAssetfiles (data,divID,userName) {
    var xmlHttp = getXMLHttp();
    
    //    alert(data+','+divID+', '+userName);
    
    var obj = document.getElementById(divID);
    //    document.getElementById('dirname').value=document.getElementById('dirname').value+data;
    if (data != '---SELECT---') {
        xmlHttp.onreadystatechange = function()
        {
            if(xmlHttp.readyState == 4 && xmlHttp.status == 200)
            {
                obj.innerHTML = xmlHttp.responseText;
            }
        }
        xmlHttp.open("POST", "showAssets.php?sourcedir="+data+'&userName='+userName); 
        xmlHttp.send();
    } else {
        alert('Please select appropriate source!');
    }
}

function moveCheckedItem () {
    var chks = document.getElementsByName('filecheck');
    var newHTML = "<table id='targetfilelist' class='lftWht' width='100%' cellpadding='0' cellspacing='0'>";
    newHTML=newHTML+"<tr class='tlhead'><th>Article No.</th></tr>";
    var checkCount = 0;
    
    if (chks.length == 0) {
        alert('No checked item to proceed.');
    } else {
        for (var i = 0; i < chks.length; i++) {
            if (chks[i].checked)
            {
                //alert(chks[i].value);
                newHTML = newHTML+"<tr><td>"+ chks[i].value +"</td></tr>";
                //            ('file'+chks[i].value).hide();
                document.getElementById("file"+chks[i].value).style.display = 'none';
            //$("#file"+chks[i].value).find("tr").hide();
            }
        }
        newHTML = newHTML+"</table>";
        document.getElementById('processFiles').innerHTML = newHTML;
    }
}

//
function checkUncheck (field) {
    for (i = 0; i < field.length; i++) {
        if (field[i].checked == true) {
            field[i].checked = false;
        } else {
            field[i].checked = true;
        }
    }
}


var HTMLfileArray = null;
function processFiles (targetID,UserName) {
    var table = document.getElementById(targetID); 
    rows = table.getElementsByTagName('tr');

    var sourceDir=document.getElementById('sourceDir').value;
    
    //    alert("Dir: "+sourceDir);

    for (i = 0, j = rows.length; i < j; ++i) {
        
        cells = rows[i].getElementsByTagName('td');
        if (!cells.length) {
            continue;
        }
        var targettableID = cells[0].innerHTML;
        //        alert(targettableID);
        
        if (HTMLfileArray == null) {
            HTMLfileArray=targettableID;    
        } else {
            HTMLfileArray=HTMLfileArray+","+targettableID;    
        }
    }
    
    
    var xmlHttp = getXMLHttp();
    
    //alert(sourceDir+','+HTMLfileArray);
    
    var obj = document.getElementById("loadContents");//publishMyHTML
    //    document.getElementById('dirname').value=document.getElementById('dirname').value+data;
    xmlHttp.onreadystatechange = function()
    {
        if(xmlHttp.readyState == 4 && xmlHttp.status == 200)
        {
            obj.innerHTML = xmlHttp.responseText;
        } 
    }
    xmlHttp.open("POST", "processHTML.php?sourceDir="+ sourceDir +"&UserName="+ UserName +"&HTMLfileArray="+HTMLfileArray); 
    xmlHttp.send();
        
    //
    document.getElementById('processFiles').innerHTML = 'No Item to proceed';
        
}

function activeTab (tabId) {
    //    var linktabs = document.getElementsByTagName("li");
    document.getElementById(tabId).setAttribute('class','active');
}

//
function moveSelectedItem() {
    //selectDir

    var chks = document.getElementsByName('selectDir');
    alert(document.getElementById('selectDirVal').value);
    
    var newHTML = "<table id='targetfilelist' class='lftWht' width='100%' cellpadding='0' cellspacing='0'>";
    //    newHTML=newHTML+"<tr class='tlhead'><th>Article No.</th></tr>";
    var checkCount = 0;
    for (var i = 0; i < chks.length; i++)
    {
        if (chks[i].selected)
        {
            //alert('hi'+chks[i].value);
            newHTML = newHTML+"<tr><td>"+ chks[i].value +"</td></tr>";
        }
    }
    newHTML = newHTML+"</table>";
    document.getElementById('processFiles').innerHTML = newHTML;
}

function selectEpubDir(id) {
    $(id).addClass("selected");
    $(id).siblings().removeClass("selected"); 
}

function dragit() {
    if ($(".selected a:first").text() != '') {
        $(".drag").html($(".selected a:first").text());  //    $(".drag").html($(".selected").html());  
        $(".selected").hide();// to hide selected tag
    } else {
        alert("Please select item to proceed.");
    }
        
}

function removeSelect() {
//    $(".drag").hide();// to hide selected tag
//    $(".selected").show();// to hide selected tag
}

//
var ePubPacketName = null;
function processEpub (targetID,UserID,editedEpub) {
    ePubPacketName=document.getElementById(targetID).innerHTML;
    //    alert("packet: ("+ePubPacketName+")"+UserID);
 
    var epubtype=document.getElementById('epubtype').value;
    //alert(epubtype);
    var fixlayout = document.getElementById('fixlayout').checked;

if (epubtype == 'OEBPS' || epubtype == 'OPS') {
        if (ePubPacketName == 'No Item to proceed') {
            alert("OOPS, No packet to publish. Please try again.");
        } else {
            var obj = document.getElementById("loadContents");//ePub publish
            $('#loadContents').load('createEPUB.php?epubpacket='+ePubPacketName+'&epubstage='+editedEpub+'&UserID='+UserID+'&epubtype='+epubtype+'&fixlayout='+fixlayout, function(response, status, xhr) {
                if (status == "error") {
                    alert("Problem in loading file.");
                } else {
                    // Hide all subfolders at startup
                    $(".php-file-tree").find("UL").hide();
	
                    // Expand/collapse on click
                    $(".pft-directory A").click( function() {
                        $(this).parent().find("UL:first").slideToggle("medium");
                        if( $(this).parent().attr('className') == "pft-directory" ) return false;
                    });
                }
            });
        }
    } else {
        if (ePubPacketName == 'No Item to proceed') {
            alert("OOPS, No packet to publish. Please try again.");
        } else {
            alert("Please select 'EPUB TYPE' to publish ePub.");
        }
    }
    
//    var xmlHttp = getXMLHttp();
//    
//    xmlHttp.onreadystatechange = function()
//    {
//        if(xmlHttp.readyState == 4 && xmlHttp.status == 200)
//        {
//            alert(xmlHttp.readyState+', '+xmlHttp.status);
//            obj.innerHTML = xmlHttp.responseText;
//        } else {
//            alert(xmlHttp.readyState+', '+xmlHttp.status);
//        }
//    }
//    xmlHttp.open("POST", "createEPUB.php?epubpacket="+ePubPacketName); 
//    xmlHttp.send(); 
}


function viewLogFile(FileLoc) {
    mywindow = window.open(FileLoc,"Window3",
        "menubar=no,width=600,height=400,toolbar=no,resizable=1,scrollbars=1");
    mywindow.moveTo(0,0);
}

// Open file to edit in CuteEditor
function editFile (ceFileName) {
    //    alert ("edit html file"+ceFileName);
    $('#modifyEPub').load('mytest1.php?filename='+ceFileName, function(response, status, xhr) {
        if (status == "error") {
            alert("Problem in loading file.");
        } else {
        //            alert("test loaded");
        }
    });
}

function ViewModifiedJob(assetView,dirLoc,UserID) {
    var obj = document.getElementById(assetView);
    $("#"+assetView+"").load('assetView.php?viewDir='+dirLoc+'&UserID='+UserID, function(response, status, xhr) {
        if (status == "error") {
            alert("Problem in loading directory.");
        } else {
            // Hide all subfolders at startup
            $(".php-file-tree").find("UL").hide();
	
            // Expand/collapse on click
            $(".pft-directory A").click( function() {
                $(this).parent().find("UL:first").slideToggle("medium");
                if( $(this).parent().attr('className') == "pft-directory" ) return false;
            });
        }
    });
}

function changeStage(assetName,taskName) {
    var assetName = document.getElementById(assetName).value;
    //alert(assetName);
    if (assetName == '---SELECT---') {
        alert('Please Select valid packet!');
    } else {
        var ans = confirm("Do you want to proceed packet ("+assetName+") for ePub creation?");
        if (ans == true) {
            window.location.href="mainpage.php?module=publish&publish=epub&taskStage=movetoEpub&packetName="+assetName;
        } 
    }
}

//
function saveCSSbyEditor(divID) {
    var cssJobName = document.getElementById('cssJobName').innerHTML;
    var cssData = document.getElementById(divID).value;
    //alert(cssData);
    $.ajax({
        url: "saveCSS.php",
        type: "POST",
        data: {cssData: cssData, dir: cssJobName},
        success: function(result) {
          if(result == "The data couldn't write to stylesheet.") {
              alert("The data couldn't write to stylesheet.");
          } else {
              alert('The stylesheet has been modified successfully.');
          }
        }
     });
    
    
}

// Reload editor - refresh edting file
function reLoadEditor (filePath,editfileName) {
    //alert(filePath);
    var reloadFileContent = document.getElementById('Editor1').value;
    //alert('filepath=>'+filePath+'] [edit file=>'+editfile_content);
    //alert(filePath);
    $.ajax({
        //url: "testedit.php",mainpage.php?module=publish&publish=html&stage=edit&filePath="+filePath // ?filePath="+filePath
        url: "edit.php?stage=edit",
        //url: "mainpage.php?module=publish&publish=html&stage=edit",
        type: "POST",
        data: {filePath: filePath, editfileName: editfileName, reloadFileContent: reloadFileContent},
        success: function(result) {
          if(result != '') {
              //$("#textareaContent").text(result);
//              alert('mk');
          } else {
//              alert('mk2');
          }
        }
   });
}
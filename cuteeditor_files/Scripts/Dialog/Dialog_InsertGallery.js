var OxO736d=["browse_Img_gallery","TargetUrl","uploader1","src","upload.php?","\x26FP=","\x26Type=Image","value","lightyellow","0px","-3px","all","getElementById","\x3Cdiv id=\x22tooltipdiv\x22 style=\x22visibility:hidden;background-color:","\x22 \x3E\x3C/div\x3E","tooltipdiv","left","offsetLeft","offsetTop","offsetParent","style","top","visibility","compatMode","BackCompat","documentElement","body","rightedge","opera","scrollLeft","clientWidth","pageXOffset","innerWidth","contentmeasure","offsetWidth","x","scrollTop","clientHeight","pageYOffset","innerHeight","offsetHeight","y","innerHTML","visible","hidden","px","bottomedge","undefined","hidetip()","element","editor","editdoc","^[a-z]*:[/][/][^/]*","","width","height","IMG","border","alt","product","Gecko","src_cetemp","Edit"];var browse_Img_gallery=Window_GetElement(window,OxO736d[0],true);var TargetUrl=Window_GetElement(window,OxO736d[1],true);function SetUpload_imagePath(Ox4de){if(document.getElementById(OxO736d[2])){document.getElementById(OxO736d[2])[OxO736d[3]]=OxO736d[4]+setting+OxO736d[5]+Ox4de+OxO736d[6];} ;} ;function row_click(Ox4de){TargetUrl[OxO736d[7]]=Ox4de;} ;function cancel(){Window_CloseDialog(window);} ;var tipbgcolor=OxO736d[8];var disappeardelay=250;var vertical_offset=OxO736d[9];var horizontal_offset=OxO736d[10];var delayhidetimerid;var ie4=document[OxO736d[11]];var ns6=document[OxO736d[12]]&&!document[OxO736d[11]];if(ie4||ns6){document.write(OxO736d[13]+tipbgcolor+OxO736d[14]);var dropmenuobj=Window_GetElement(window,OxO736d[15],true);} ;function getposOffset(Ox50b,Ox50c){var Ox50d=(Ox50c==OxO736d[16])?Ox50b[OxO736d[17]]:Ox50b[OxO736d[18]];var Ox50e=Ox50b[OxO736d[19]];while(Ox50e!=null){Ox50d+=(Ox50c==OxO736d[16])?Ox50e[OxO736d[17]]:Ox50e[OxO736d[18]];Ox50e=Ox50e[OxO736d[19]];} ;return Ox50d;} ;function showhide(obj,Ox510,Ox511){if(ie4||ns6){dropmenuobj[OxO736d[20]][OxO736d[16]]=dropmenuobj[OxO736d[20]][OxO736d[21]]=-500;} ;obj[OxO736d[22]]=Ox510;} ;function iecompattest(){return (document[OxO736d[23]]&&document[OxO736d[23]]!=OxO736d[24])?document[OxO736d[25]]:document[OxO736d[26]];} ;function clearbrowseredge(obj,Ox514){var Ox515=(Ox514==OxO736d[27])?parseInt(horizontal_offset)*-1:parseInt(vertical_offset)*-1;if(Ox514==OxO736d[27]){var Ox516=ie4&&!window[OxO736d[28]]?iecompattest()[OxO736d[29]]+iecompattest()[OxO736d[30]]-15:window[OxO736d[31]]+window[OxO736d[32]]-15;dropmenuobj[OxO736d[33]]=dropmenuobj[OxO736d[34]];if(Ox516-dropmenuobj[OxO736d[35]]<dropmenuobj[OxO736d[33]]){Ox515=dropmenuobj[OxO736d[33]]-obj[OxO736d[34]];} ;} else {var Ox516=ie4&&!window[OxO736d[28]]?iecompattest()[OxO736d[36]]+iecompattest()[OxO736d[37]]-15:window[OxO736d[38]]+window[OxO736d[39]]-18;dropmenuobj[OxO736d[33]]=dropmenuobj[OxO736d[40]];if(Ox516-dropmenuobj[OxO736d[41]]<dropmenuobj[OxO736d[33]]){Ox515=dropmenuobj[OxO736d[33]]+obj[OxO736d[40]];} ;} ;return Ox515;} ;function showTooltip(Ox518,obj){Event_CancelEvent();clearhidetip();dropmenuobj[OxO736d[42]]=Ox518;if(ie4||ns6){showhide(dropmenuobj.style,OxO736d[43],OxO736d[44]);dropmenuobj[OxO736d[35]]=getposOffset(obj,OxO736d[16]);dropmenuobj[OxO736d[41]]=getposOffset(obj,OxO736d[21]);dropmenuobj[OxO736d[20]][OxO736d[16]]=dropmenuobj[OxO736d[35]]-clearbrowseredge(obj,OxO736d[27])+OxO736d[45];dropmenuobj[OxO736d[20]][OxO736d[21]]=dropmenuobj[OxO736d[41]]-clearbrowseredge(obj,OxO736d[46])+obj[OxO736d[40]]*1.1+2+OxO736d[45];} ;} ;function hidetip(){if( typeof dropmenuobj!=OxO736d[47]){if(ie4||ns6){dropmenuobj[OxO736d[20]][OxO736d[22]]=OxO736d[44];} ;} ;} ;function delayhidetip(){if(ie4||ns6){delayhidetimerid=setTimeout(OxO736d[48],disappeardelay);} ;} ;function clearhidetip(){clearTimeout(delayhidetimerid);} ;function cancel(){Window_CloseDialog(window);} ;var obj=Window_GetDialogArguments(window);var element=obj[OxO736d[49]];var editor=obj[OxO736d[50]];var editdoc=obj[OxO736d[51]];function insert(src){if(src){var Ox3b9=src.replace( new RegExp(OxO736d[52],OxO736d[53]),OxO736d[53]);function Actualsize(){var Ox51b= new Image();Ox51b[OxO736d[3]]=Ox3b9;if(Ox51b[OxO736d[54]]>0&&Ox51b[OxO736d[55]]>0){element[OxO736d[54]]=Ox51b[OxO736d[54]];element[OxO736d[55]]=Ox51b[OxO736d[55]];} else {setTimeout(Actualsize,400);} ;} ;if(element){element[OxO736d[3]]=Ox3b9;} else {element=editdoc.createElement(OxO736d[56]);element[OxO736d[3]]=Ox3b9;element[OxO736d[57]]=0;element[OxO736d[58]]=OxO736d[53];Actualsize();} ;if(navigator[OxO736d[59]]==OxO736d[60]){try{element.setAttribute(OxO736d[61],Ox3b9);} catch(e){} ;} else {if(editor.GetActiveTab()==OxO736d[62]){element.setAttribute(OxO736d[61],Ox3b9);} ;} ;editor.InsertElement(element);Window_CloseDialog(window);} ;} ;
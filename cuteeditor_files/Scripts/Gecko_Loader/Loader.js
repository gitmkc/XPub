var OxO8621=["ua","userAgent","isOpera","opera","isSafari","safari","isGecko","gecko","isWinIE","msie","compatMode","document","CSS1Compat","head","script","language","javascript","type","text/javascript","src","id","undefined","Microsoft.XMLHTTP","readyState","onreadystatechange","","length","all","childNodes","nodeType","\x0D\x0A","caller","onchange","oninitialized","command","commandui","commandvalue","returnValue","oncommand","string","_fireEventFunction","event","parentNode","_IsCuteEditor","True","value","arguments","target","nodeName","SELECT","OPTION","readOnly","_IsRichDropDown","null","selectedIndex","TR","cells","display","style","nextSibling","innerHTML","\x3Cimg src=\x22","/Images/t-minus.gif\x22\x3E","onclick","CuteEditor_CollapseTreeDropDownItem(this,\x22","\x22)","onmousedown","none","/Images/t-plus.gif\x22\x3E","CuteEditor_ExpandTreeDropDownItem(this,\x22","contains","UNSELECTABLE","on","tabIndex","-1","//TODO: event not found? throw error ?","contentWindow","contentDocument","parentWindow","frames","frameElement","//TODO:frame contentWindow not found?","preventDefault","parent","top","opener","srcElement","//TODO: srcElement not found? throw error ?","fromElement","relatedTarget","toElement","keyCode","clientX","clientY","offsetX","offsetY","button","ctrlKey","altKey","shiftKey","cancelBubble","stopPropagation",";CuteEditor_GetEditor(this).ExecImageCommand(this.getAttribute(\x27Command\x27),this.getAttribute(\x27CommandUI\x27),this.getAttribute(\x27CommandArgument\x27))","this.onmouseout();CuteEditor_GetEditor(this).DropMenu(this.getAttribute(\x27Group\x27),this)","ResourceDir","Theme","/Themes/","/Images/all.png","/Images/blank2020.png","IMG","alt","title","Command","Group","ThemeIndex","width","20px","height","backgroundImage","url(",")","backgroundPosition","0 -","px","onload","className","separator","CuteEditorButton","onmouseover","CuteEditor_ButtonCommandOver(this)","onmouseout","CuteEditor_ButtonCommandOut(this)","CuteEditor_ButtonCommandDown(this)","onmouseup","CuteEditor_ButtonCommandUp(this)","oncontextmenu","ondragstart","ondblclick","_ToolBarID","_CodeViewToolBarID","_FrameID"," CuteEditorFrame"," CuteEditorToolbar","cursor","no-drop","ActiveTab","Edit","Code","View","buttonInitialized","isover","CuteEditorButtonOver","CuteEditorButtonDown","CuteEditorDown","border","solid 1px #0A246A","backgroundColor","#b6bdd2","padding","1px","solid 1px #f5f5f4","inset 1px","IsCommandDisabled","CuteEditorButtonDisabled","IsCommandActive","CuteEditorButtonActive","cmd_fromfullpage","(","href","location",",DanaInfo=",",","+","scriptProperties","initfuncbecalled","GetScriptProperty","/Scripts/Gecko_Implementation/CuteEditorImplementation.js?i=1","CuteEditorImplementation","function","GET","\x26getModified=1","status","body","InitializeCode","block","contentEditable","/Scripts/resource.php","?type=license\x26_ver=","Failed to load editor license data.","responseText","0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","0000000000000840",";","/",":","//",".","www","?type=serverip\x26_ver=","Failed to load editor license info!","You are using an incorrect license file.","Invalid lcparts count:","Invalid product version.","Invalid license type.","(0) license expired!","(0) only localhost!","(1) host not match!","(2) ip not match!","(3) host not match!","(4) license expired!","License Error : ","CuteEditorInitialize"];var _Browser_TypeInfo=null;function Browser__InitType(){if(_Browser_TypeInfo!=null){return ;} ;var Ox357={};Ox357[OxO8621[0]]=navigator[OxO8621[1]].toLowerCase();Ox357[OxO8621[2]]=(Ox357[OxO8621[0]].indexOf(OxO8621[3])>-1);Ox357[OxO8621[4]]=(Ox357[OxO8621[0]].indexOf(OxO8621[5])>-1);Ox357[OxO8621[6]]=(!Ox357[OxO8621[2]]&&Ox357[OxO8621[0]].indexOf(OxO8621[7])>-1);Ox357[OxO8621[8]]=(!Ox357[OxO8621[2]]&&Ox357[OxO8621[0]].indexOf(OxO8621[9])>-1);_Browser_TypeInfo=Ox357;} ;Browser__InitType();function Browser_IsWinIE(){return _Browser_TypeInfo[OxO8621[8]];} ;function Browser_IsGecko(){return _Browser_TypeInfo[OxO8621[6]];} ;function Browser_IsOpera(){return _Browser_TypeInfo[OxO8621[2]];} ;function Browser_IsSafari(){return _Browser_TypeInfo[OxO8621[4]];} ;function Browser_UseIESelection(){return _Browser_TypeInfo[OxO8621[8]];} ;function Browser_IsCSS1Compat(){return window[OxO8621[11]][OxO8621[10]]==OxO8621[12];} ;function include(Ox3b8,Ox3b9){var Ox3ba=document.getElementsByTagName(OxO8621[13]).item(0);var Ox3bb=document.getElementById(Ox3b8);if(Ox3bb){Ox3ba.removeChild(Ox3bb);} ;var Ox3bc=document.createElement(OxO8621[14]);Ox3bc.setAttribute(OxO8621[15],OxO8621[16]);Ox3bc.setAttribute(OxO8621[17],OxO8621[18]);Ox3bc.setAttribute(OxO8621[19],Ox3b9);Ox3bc.setAttribute(OxO8621[20],Ox3b8);Ox3ba.appendChild(Ox3bc);} ;function CreateXMLHttpRequest(){try{if( typeof (XMLHttpRequest)!=OxO8621[21]){return  new XMLHttpRequest();} ;if( typeof (ActiveXObject)!=OxO8621[21]){return  new ActiveXObject(OxO8621[22]);} ;} catch(x){return null;} ;} ;function LoadXMLAsync(Oxb7d,Ox3b9,Ox363,Oxb7e){var Ox9dd=CreateXMLHttpRequest();function Oxb7f(){if(Ox9dd[OxO8621[23]]!=4){return ;} ;Ox9dd[OxO8621[24]]= new Function();var Ox3c1=Ox9dd;Ox9dd=null;if(Ox363){Ox363(Ox3c1);} ;} ;Ox9dd[OxO8621[24]]=Oxb7f;Ox9dd.open(Oxb7d,Ox3b9,true);Ox9dd.send(Oxb7e||OxO8621[25]);} ;function Element_GetAllElements(p){var arr=[];if(Browser_IsWinIE()){for(var i=0;i<p[OxO8621[27]][OxO8621[26]];i++){arr.push(p[OxO8621[27]].item(i));} ;return arr;} ;Ox36f(p);function Ox36f(Oxa){var Ox370=Oxa[OxO8621[28]];var Oxd=Ox370[OxO8621[26]];for(var i=0;i<Oxd;i++){var Ox248=Ox370.item(i);if(Ox248[OxO8621[29]]!=1){continue ;} ;arr.push(Ox248);Ox36f(Ox248);} ;} ;return arr;} ;var __ISDEBUG=false;function Debug_Todo(msg){if(!__ISDEBUG){return ;} ;throw ( new Error(msg+OxO8621[30]+Debug_Todo[OxO8621[31]]));} ;function Window_GetElement(Ox2d4,Ox2ee,Ox36d){var Oxa=Ox2d4[OxO8621[11]].getElementById(Ox2ee);if(Oxa){return Oxa;} ;var Ox269=Ox2d4[OxO8621[11]].getElementsByName(Ox2ee);if(Ox269[OxO8621[26]]>0){return Ox269.item(0);} ;return null;} ;function CuteEditor_AddMainMenuItems(Ox77c){} ;function CuteEditor_AddDropMenuItems(Ox77c,Ox783){} ;function CuteEditor_AddTagMenuItems(Ox77c,Ox785){} ;function CuteEditor_AddVerbMenuItems(Ox77c,Ox785){} ;function CuteEditor_OnInitialized(editor){} ;function CuteEditor_OnCommand(editor,Ox789,Ox78a,Ox254){} ;function CuteEditor_OnChange(editor){} ;function CuteEditor_FilterCode(editor,Ox399){return Ox399;} ;function CuteEditor_FilterHTML(editor,Ox3b1){return Ox3b1;} ;function CuteEditor_FireChange(editor){window.CuteEditor_OnChange(editor);CuteEditor_FireEvent(editor,OxO8621[32],null);} ;function CuteEditor_FireInitialized(editor){window.CuteEditor_OnInitialized(editor);CuteEditor_FireEvent(editor,OxO8621[33],null);} ;function CuteEditor_FireCommand(editor,Ox789,Ox78a,Ox254){var Ox271=window.CuteEditor_OnCommand(editor,Ox789,Ox78a,Ox254);if(Ox271==true){return true;} ;var Ox791={};Ox791[OxO8621[34]]=Ox789;Ox791[OxO8621[35]]=Ox78a;Ox791[OxO8621[36]]=Ox254;Ox791[OxO8621[37]]=true;CuteEditor_FireEvent(editor,OxO8621[38],Ox791);if(Ox791[OxO8621[37]]==false){return true;} ;} ;function CuteEditor_FireEvent(editor,Ox793,Ox794){if(Ox794==null){Ox794={};} ;var Ox795=editor.getAttribute(Ox793);if(Ox795){if( typeof (Ox795)==OxO8621[39]){editor[OxO8621[40]]= new Function(OxO8621[41],Ox795);} else {editor[OxO8621[40]]=Ox795;} ;editor._fireEventFunction(Ox794);} ;} ;function CuteEditor_GetEditor(element){for(var Ox283=element;Ox283!=null;Ox283=Ox283[OxO8621[42]]){if(Ox283.getAttribute(OxO8621[43])==OxO8621[44]){return Ox283;} ;} ;return null;} ;function CuteEditor_DropDownCommand(element,Oxb81){var Ox275=element[OxO8621[45]];if(CuteEditor_DropDownCommand[OxO8621[31]]){var Ox283=CuteEditor_DropDownCommand[OxO8621[31]][OxO8621[46]][0];if(Ox283&&Ox283[OxO8621[47]]){if(Ox283[OxO8621[47]][OxO8621[48]]==OxO8621[49]){return ;} ;if(Ox283[OxO8621[47]][OxO8621[48]]==OxO8621[50]){Ox275=Ox283[OxO8621[47]][OxO8621[45]];} ;} ;} ;var editor=CuteEditor_GetEditor(element);if(editor[OxO8621[51]]){return ;} ;if(element.getAttribute(OxO8621[52])==OxO8621[44]){var Ox275=element.GetValue();if(Ox275==OxO8621[53]){Ox275=OxO8621[25];} ;var Ox32e=element.GetText();if(Ox32e==OxO8621[53]){Ox32e=OxO8621[25];} ;element.SetSelectedIndex(0);editor.ExecCommand(Oxb81,false,Ox275,Ox32e);} else {if(Ox275){if(Ox275==OxO8621[53]){Ox275=OxO8621[25];} ;element[OxO8621[54]]=0;editor.ExecCommand(Oxb81,false,Ox275,Ox32e);} else {element[OxO8621[54]]=0;} ;} ;editor.FocusDocument();} ;function CuteEditor_ExpandTreeDropDownItem(src,Ox869){var Ox312=null;while(src!=null){if(src[OxO8621[48]]==OxO8621[55]){Ox312=src;break ;} ;src=src[OxO8621[42]];} ;var Ox13=Ox312[OxO8621[56]].item(0);Ox312[OxO8621[59]][OxO8621[58]][OxO8621[57]]=OxO8621[25];Ox13[OxO8621[60]]=OxO8621[61]+Ox869+OxO8621[62];Ox312[OxO8621[63]]= new Function(OxO8621[64]+Ox869+OxO8621[65]);Ox312[OxO8621[66]]= new Function(OxO8621[64]+Ox869+OxO8621[65]);} ;function CuteEditor_CollapseTreeDropDownItem(src,Ox869){var Ox312=null;while(src!=null){if(src[OxO8621[48]]==OxO8621[55]){Ox312=src;break ;} ;src=src[OxO8621[42]];} ;var Ox13=Ox312[OxO8621[56]].item(0);Ox312[OxO8621[59]][OxO8621[58]][OxO8621[57]]=OxO8621[67];Ox13[OxO8621[60]]=OxO8621[61]+Ox869+OxO8621[68];Ox312[OxO8621[63]]= new Function(OxO8621[69]+Ox869+OxO8621[65]);Ox312[OxO8621[66]]= new Function(OxO8621[69]+Ox869+OxO8621[65]);} ;function Element_Contains(element,Ox2ad){if(!Browser_IsOpera()){if(element[OxO8621[70]]){return element.contains(Ox2ad);} ;} ;for(;Ox2ad!=null;Ox2ad=Ox2ad[OxO8621[42]]){if(element==Ox2ad){return true;} ;} ;return false;} ;function Element_SetUnselectable(element){element.setAttribute(OxO8621[71],OxO8621[72]);element.setAttribute(OxO8621[73],OxO8621[74]);var arr=Element_GetAllElements(element);var len=arr[OxO8621[26]];if(!len){return ;} ;for(var i=0;i<len;i++){arr[i].setAttribute(OxO8621[71],OxO8621[72]);arr[i].setAttribute(OxO8621[73],OxO8621[74]);} ;} ;function Event_GetEvent(Ox373){Ox373=Event_FindEvent(Ox373);if(Ox373==null){Debug_Todo(OxO8621[75]);} ;return Ox373;} ;function Frame_GetContentWindow(Ox47d){if(Ox47d[OxO8621[76]]){return Ox47d[OxO8621[76]];} ;if(Ox47d[OxO8621[77]]){if(Ox47d[OxO8621[77]][OxO8621[78]]){return Ox47d[OxO8621[77]][OxO8621[78]];} ;} ;var Ox2d4;if(Ox47d[OxO8621[20]]){Ox2d4=window[OxO8621[79]][Ox47d[OxO8621[20]]];if(Ox2d4){return Ox2d4;} ;} ;var len=window[OxO8621[79]][OxO8621[26]];for(var i=0;i<len;i++){Ox2d4=window[OxO8621[79]][i];if(Ox2d4[OxO8621[80]]==Ox47d){return Ox2d4;} ;if(Ox2d4[OxO8621[11]]==Ox47d[OxO8621[77]]){return Ox2d4;} ;} ;Debug_Todo(OxO8621[81]);} ;function Array_IndexOf(arr,Ox375){for(var i=0;i<arr[OxO8621[26]];i++){if(arr[i]==Ox375){return i;} ;} ;return -1;} ;function Array_Contains(arr,Ox375){return Array_IndexOf(arr,Ox375)!=-1;} ;function Event_FindEvent(Ox373){if(Ox373&&Ox373[OxO8621[82]]){return Ox373;} ;if(Browser_IsGecko()){return Event_FindEvent_FindEventFromCallers();} else {if(window[OxO8621[41]]){return window[OxO8621[41]];} ;return Event_FindEvent_FindEventFromWindows();} ;return null;} ;function Event_FindEvent_FindEventFromCallers(){var Ox2ba=Event_GetEvent[OxO8621[31]];for(var i=0;i<100;i++){if(!Ox2ba){break ;} ;var Ox373=Ox2ba[OxO8621[46]][0];if(Ox373&&Ox373[OxO8621[82]]){return Ox373;} ;Ox2ba=Ox2ba[OxO8621[31]];} ;} ;function Event_FindEvent_FindEventFromWindows(){var arr=[];return Ox37c(window);function Ox37c(Ox2d4){if(Ox2d4==null){return null;} ;if(Ox2d4[OxO8621[41]]){return Ox2d4[OxO8621[41]];} ;if(Array_Contains(arr,Ox2d4)){return null;} ;arr.push(Ox2d4);var Ox37d=[];if(Ox2d4[OxO8621[83]]!=Ox2d4){Ox37d.push(Ox2d4.parent);} ;if(Ox2d4[OxO8621[84]]!=Ox2d4[OxO8621[83]]){Ox37d.push(Ox2d4.top);} ;if(Ox2d4[OxO8621[85]]){Ox37d.push(Ox2d4.opener);} ;for(var i=0;i<Ox2d4[OxO8621[79]][OxO8621[26]];i++){Ox37d.push(Ox2d4[OxO8621[79]][i]);} ;for(var i=0;i<Ox37d[OxO8621[26]];i++){try{var Ox373=Ox37c(Ox37d[i]);if(Ox373){return Ox373;} ;} catch(x){} ;} ;return null;} ;} ;function Event_GetSrcElement(Ox373){Ox373=Event_GetEvent(Ox373);if(Ox373[OxO8621[86]]){return Ox373[OxO8621[86]];} ;if(Ox373[OxO8621[47]]){return Ox373[OxO8621[47]];} ;Debug_Todo(OxO8621[87]);return null;} ;function Event_GetFromElement(Ox373){Ox373=Event_GetEvent(Ox373);if(Ox373[OxO8621[88]]){return Ox373[OxO8621[88]];} ;if(Ox373[OxO8621[89]]){return Ox373[OxO8621[89]];} ;return null;} ;function Event_GetToElement(Ox373){Ox373=Event_GetEvent(Ox373);if(Ox373[OxO8621[90]]){return Ox373[OxO8621[90]];} ;if(Ox373[OxO8621[89]]){return Ox373[OxO8621[89]];} ;return null;} ;function Event_GetKeyCode(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[91]];} ;function Event_GetClientX(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[92]];} ;function Event_GetClientY(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[93]];} ;function Event_GetOffsetX(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[94]];} ;function Event_GetOffsetY(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[95]];} ;function Event_IsLeftButton(Ox373){Ox373=Event_GetEvent(Ox373);if(Browser_IsWinIE()){return Ox373[OxO8621[96]]==1;} ;if(Browser_IsGecko()){return Ox373[OxO8621[96]]==0;} ;return Ox373[OxO8621[96]]==0;} ;function Event_IsCtrlKey(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[97]];} ;function Event_IsAltKey(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[98]];} ;function Event_IsShiftKey(Ox373){Ox373=Event_GetEvent(Ox373);return Ox373[OxO8621[99]];} ;function Event_PreventDefault(Ox373){Ox373=Event_GetEvent(Ox373);Ox373[OxO8621[37]]=false;if(Ox373[OxO8621[82]]){Ox373.preventDefault();} ;} ;function Event_CancelBubble(Ox373){Ox373=Event_GetEvent(Ox373);Ox373[OxO8621[100]]=true;if(Ox373[OxO8621[101]]){Ox373.stopPropagation();} ;return false;} ;function Event_CancelEvent(Ox373){Ox373=Event_GetEvent(Ox373);Event_PreventDefault(Ox373);return Event_CancelBubble(Ox373);} ;function CuteEditor_BasicInitialize(editor){var Ox7f5=Browser_IsOpera();var Ox832= new Function(OxO8621[102]);var Oxb85= new Function(OxO8621[103]);var Oxb86=editor.GetScriptProperty(OxO8621[104]);var Oxb87=editor.GetScriptProperty(OxO8621[105]);var Oxb88=Oxb86+OxO8621[106]+Oxb87+OxO8621[107];var Oxb89=Oxb86+OxO8621[108];var images=editor.getElementsByTagName(OxO8621[109]);var len=images[OxO8621[26]];for(var i=0;i<len;i++){var img=images[i];if(img.getAttribute(OxO8621[110])&&!img.getAttribute(OxO8621[111])){img.setAttribute(OxO8621[111],img.getAttribute(OxO8621[110]));} ;var Ox268=img.getAttribute(OxO8621[112]);var Ox783=img.getAttribute(OxO8621[113]);if(!(Ox268||Ox783)){continue ;} ;var Oxb8a=img.getAttribute(OxO8621[114]);if(parseInt(Oxb8a)>=0){img[OxO8621[58]][OxO8621[115]]=OxO8621[116];img[OxO8621[58]][OxO8621[117]]=OxO8621[116];img[OxO8621[19]]=Oxb89;img[OxO8621[58]][OxO8621[118]]=OxO8621[119]+Oxb88+OxO8621[120];img[OxO8621[58]][OxO8621[121]]=OxO8621[122]+(Oxb8a*20)+OxO8621[123];img[OxO8621[58]][OxO8621[57]]=OxO8621[25];} ;if(!Ox268&&!Ox783){if(Ox7f5){img[OxO8621[124]]=CuteEditor_OperaHandleImageLoaded;} ;continue ;} ;if(img[OxO8621[125]]!=OxO8621[126]){img[OxO8621[125]]=OxO8621[127];img[OxO8621[128]]= new Function(OxO8621[129]);img[OxO8621[130]]= new Function(OxO8621[131]);img[OxO8621[66]]= new Function(OxO8621[132]);img[OxO8621[133]]= new Function(OxO8621[134]);} ;if(!img[OxO8621[135]]){img[OxO8621[135]]=Event_CancelEvent;} ;if(!img[OxO8621[136]]){img[OxO8621[136]]=Event_CancelEvent;} ;if(Ox268){var Ox2ba=Ox832;if(img[OxO8621[63]]==null){img[OxO8621[63]]=Ox2ba;} ;if(img[OxO8621[137]]==null){img[OxO8621[137]]=Ox2ba;} ;} else {if(Ox783){if(img[OxO8621[63]]==null){img[OxO8621[63]]=Oxb85;} ;} ;} ;} ;var Ox89e=Window_GetElement(window,editor.GetScriptProperty(OxO8621[138]),true);var Ox89f=Window_GetElement(window,editor.GetScriptProperty(OxO8621[139]),true);var Ox89b=Window_GetElement(window,editor.GetScriptProperty(OxO8621[140]),true);Ox89b[OxO8621[125]]+=OxO8621[141];Ox89e[OxO8621[125]]+=OxO8621[142];Ox89f[OxO8621[125]]+=OxO8621[142];Element_SetUnselectable(Ox89e);Element_SetUnselectable(Ox89f);try{editor[OxO8621[58]][OxO8621[143]]=OxO8621[144];} catch(x){} ;var Ox925=editor.GetScriptProperty(OxO8621[145]);switch(Ox925){case OxO8621[146]:Ox89e[OxO8621[58]][OxO8621[57]]=OxO8621[25];break ;;case OxO8621[147]:Ox89f[OxO8621[58]][OxO8621[57]]=OxO8621[25];break ;;case OxO8621[148]:break ;;} ;} ;function CuteEditor_OperaHandleImageLoaded(){var img=this;if(img[OxO8621[58]][OxO8621[57]]){img[OxO8621[58]][OxO8621[57]]=OxO8621[67];setTimeout(function Oxb8c(){img[OxO8621[58]][OxO8621[57]]=OxO8621[25];} ,1);} ;} ;function CuteEditor_ButtonOver(element){if(!element[OxO8621[149]]){element[OxO8621[135]]=Event_CancelEvent;element[OxO8621[130]]=CuteEditor_ButtonOut;element[OxO8621[66]]=CuteEditor_ButtonDown;element[OxO8621[133]]=CuteEditor_ButtonUp;Element_SetUnselectable(element);element[OxO8621[149]]=true;} ;element[OxO8621[150]]=true;element[OxO8621[125]]=OxO8621[151];} ;function CuteEditor_ButtonOut(){var element=this;element[OxO8621[125]]=OxO8621[127];element[OxO8621[150]]=false;} ;function CuteEditor_ButtonDown(){if(!Event_IsLeftButton()){return ;} ;var element=this;element[OxO8621[125]]=OxO8621[152];} ;function CuteEditor_ButtonUp(){if(!Event_IsLeftButton()){return ;} ;var element=this;if(element[OxO8621[150]]){element[OxO8621[125]]=OxO8621[151];} else {element[OxO8621[125]]=OxO8621[153];} ;} ;function CuteEditor_ColorPicker_ButtonOver(element){if(!element[OxO8621[149]]){element[OxO8621[135]]=Event_CancelEvent;element[OxO8621[130]]=CuteEditor_ColorPicker_ButtonOut;element[OxO8621[66]]=CuteEditor_ColorPicker_ButtonDown;Element_SetUnselectable(element);element[OxO8621[149]]=true;} ;element[OxO8621[150]]=true;element[OxO8621[58]][OxO8621[154]]=OxO8621[155];element[OxO8621[58]][OxO8621[156]]=OxO8621[157];element[OxO8621[58]][OxO8621[158]]=OxO8621[159];} ;function CuteEditor_ColorPicker_ButtonOut(){var element=this;element[OxO8621[150]]=false;element[OxO8621[58]][OxO8621[154]]=OxO8621[160];element[OxO8621[58]][OxO8621[156]]=OxO8621[25];element[OxO8621[58]][OxO8621[158]]=OxO8621[159];} ;function CuteEditor_ColorPicker_ButtonDown(){var element=this;element[OxO8621[58]][OxO8621[154]]=OxO8621[161];element[OxO8621[58]][OxO8621[156]]=OxO8621[25];element[OxO8621[58]][OxO8621[158]]=OxO8621[159];} ;function CuteEditor_ButtonCommandOver(element){element[OxO8621[150]]=true;if(element[OxO8621[162]]){element[OxO8621[125]]=OxO8621[163];} else {element[OxO8621[125]]=OxO8621[151];} ;} ;function CuteEditor_ButtonCommandOut(element){element[OxO8621[150]]=false;if(element[OxO8621[164]]){element[OxO8621[125]]=OxO8621[165];} else {if(element[OxO8621[162]]){element[OxO8621[125]]=OxO8621[163];} else {if(element[OxO8621[20]]!=OxO8621[166]){element[OxO8621[125]]=OxO8621[127];} ;} ;} ;} ;function CuteEditor_ButtonCommandDown(element){if(!Event_IsLeftButton()){return ;} ;element[OxO8621[125]]=OxO8621[152];} ;function CuteEditor_ButtonCommandUp(element){if(!Event_IsLeftButton()){return ;} ;if(element[OxO8621[162]]){element[OxO8621[125]]=OxO8621[163];return ;} ;if(element[OxO8621[150]]){element[OxO8621[125]]=OxO8621[151];} else {if(element[OxO8621[164]]){element[OxO8621[125]]=OxO8621[165];} else {element[OxO8621[125]]=OxO8621[127];} ;} ;} ;var CuteEditorGlobalFunctions=[CuteEditor_GetEditor,CuteEditor_ButtonOver,CuteEditor_ButtonOut,CuteEditor_ButtonDown,CuteEditor_ButtonUp,CuteEditor_ColorPicker_ButtonOver,CuteEditor_ColorPicker_ButtonOut,CuteEditor_ColorPicker_ButtonDown,CuteEditor_ButtonCommandOver,CuteEditor_ButtonCommandOut,CuteEditor_ButtonCommandDown,CuteEditor_ButtonCommandUp,CuteEditor_DropDownCommand,CuteEditor_ExpandTreeDropDownItem,CuteEditor_CollapseTreeDropDownItem,CuteEditor_OnInitialized,CuteEditor_OnCommand,CuteEditor_OnChange,CuteEditor_AddVerbMenuItems,CuteEditor_AddTagMenuItems,CuteEditor_AddMainMenuItems,CuteEditor_AddDropMenuItems,CuteEditor_FilterCode,CuteEditor_FilterHTML];function SetupCuteEditorGlobalFunctions(){for(var i=0;i<CuteEditorGlobalFunctions[OxO8621[26]];i++){var Ox2ba=CuteEditorGlobalFunctions[i];var name=Ox2ba+OxO8621[25];name=name.substr(8,name.indexOf(OxO8621[167])-8).replace(/\s/g,OxO8621[25]);if(!window[name]){window[name]=Ox2ba;} ;} ;} ;SetupCuteEditorGlobalFunctions();var __danainfo=null;var danaurl=window[OxO8621[169]][OxO8621[168]];var danapos=danaurl.indexOf(OxO8621[170]);if(danapos!=-1){var pluspos1=danaurl.indexOf(OxO8621[171],danapos+10);var pluspos2=danaurl.indexOf(OxO8621[172],danapos+10);if(pluspos1!=-1&&pluspos1<pluspos2){pluspos2=pluspos1;} ;__danainfo=danaurl.substring(danapos,pluspos2)+OxO8621[172];} ;function CuteEditor_GetScriptProperty(name){return this[OxO8621[173]][name];} ;function CuteEditor_SetScriptProperty(name,Ox275){if(Ox275==null){this[OxO8621[173]][name]=null;} else {this[OxO8621[173]][name]=String(Ox275);} ;} ;function CuteEditorInitialize(Oxb97,Oxb98){var editor=Window_GetElement(window,Oxb97,true);if(editor[OxO8621[174]]){return ;} ;editor[OxO8621[174]]=1;editor[OxO8621[173]]=Oxb98;editor[OxO8621[175]]=CuteEditor_GetScriptProperty;var Ox89b=Window_GetElement(window,editor.GetScriptProperty(OxO8621[140]),true);var editwin,editdoc;try{editwin=Frame_GetContentWindow(Ox89b);editdoc=editwin[OxO8621[11]];} catch(x){} ;var Oxb99=false;var Oxb9a;var Oxb9b=false;var Oxb9c=editor.GetScriptProperty(OxO8621[104])+OxO8621[176];function Oxb9d(){if( typeof (window[OxO8621[177]])==OxO8621[178]){return ;} ;LoadXMLAsync(OxO8621[179],Oxb9c+OxO8621[180],Oxb9e);} ;function Oxb9e(Ox3c1){if(Ox3c1[OxO8621[181]]!=200){return ;} ;CuteEditorInstallScriptCode(Ox3c1.responseText,OxO8621[177]);if(Oxb99){Oxba0();} ;} ;function Oxb9f(Ox3c1){if(Ox3c1[OxO8621[181]]!=200){return ;} ;CuteEditorInstallScriptCode(Ox3c1.responseText,OxO8621[177]);if(Oxb99){Oxba0();} ;} ;function Oxba0(){if(Oxb9b){return ;} ;Oxb9b=true;window.CuteEditorImplementation(editor);try{editor[OxO8621[58]][OxO8621[143]]=OxO8621[25];} catch(x){} ;try{editdoc[OxO8621[182]][OxO8621[58]][OxO8621[143]]=OxO8621[25];} catch(x){} ;var Oxba1=editor.GetScriptProperty(OxO8621[183]);if(Oxba1){editor.Eval(Oxba1);} ;} ;function Oxba2(){if(!Element_Contains(window[OxO8621[11]].body,editor)){return ;} ;try{Ox89b=Window_GetElement(window,editor.GetScriptProperty(OxO8621[140]),true);editwin=Frame_GetContentWindow(Ox89b);editdoc=editwin[OxO8621[11]];var Ox302=editdoc[OxO8621[182]];} catch(x){setTimeout(Oxba2,100);return ;} ;if(!editdoc[OxO8621[182]]){setTimeout(Oxba2,100);return ;} ;if(!Oxb99){Ox89b[OxO8621[58]][OxO8621[57]]=OxO8621[184];if(Browser_IsOpera()){editdoc[OxO8621[182]][OxO8621[185]]=true;} else {} ;Oxb99=true;setTimeout(Oxba2,50);return ;} ;if( typeof (window[OxO8621[177]])==OxO8621[178]){Oxba0();} else {try{editdoc[OxO8621[182]][OxO8621[58]][OxO8621[143]]=OxO8621[144];} catch(x){} ;} ;} ;var Oxba3=0;var Ox283=CuteEditor_Find_DisplayNone(editor);if(Ox283){function Oxba4(){if(Ox283[OxO8621[58]][OxO8621[57]]!=OxO8621[67]){window.clearInterval(Oxba3);Oxba3=OxO8621[25];CuteEditorInitialize(Oxb97,Oxb98);} ;} ;Oxba3=setInterval(Oxba4,1000);return ;} ;function Oxba5(Oxba6){function Oxba7(Ox401,Oxba8,Oxba9,Ox342,Oxbaa,Oxbab){var Oxbac= new Array(0x1010400,0,0x10000,0x1010404,0x1010004,0x10404,0x4,0x10000,0x400,0x1010400,0x1010404,0x400,0x1000404,0x1010004,0x1000000,0x4,0x404,0x1000400,0x1000400,0x10400,0x10400,0x1010000,0x1010000,0x1000404,0x10004,0x1000004,0x1000004,0x10004,0,0x404,0x10404,0x1000000,0x10000,0x1010404,0x4,0x1010000,0x1010400,0x1000000,0x1000000,0x400,0x1010004,0x10000,0x10400,0x1000004,0x400,0x4,0x1000404,0x10404,0x1010404,0x10004,0x1010000,0x1000404,0x1000004,0x404,0x10404,0x1010400,0x404,0x1000400,0x1000400,0,0x10004,0x10400,0,0x1010004);var Oxbad= new Array(-0x7fef7fe0,-0x7fff8000,0x8000,0x108020,0x100000,0x20,-0x7fefffe0,-0x7fff7fe0,-0x7fffffe0,-0x7fef7fe0,-0x7fef8000,-0x80000000,-0x7fff8000,0x100000,0x20,-0x7fefffe0,0x108000,0x100020,-0x7fff7fe0,0,-0x80000000,0x8000,0x108020,-0x7ff00000,0x100020,-0x7fffffe0,0,0x108000,0x8020,-0x7fef8000,-0x7ff00000,0x8020,0,0x108020,-0x7fefffe0,0x100000,-0x7fff7fe0,-0x7ff00000,-0x7fef8000,0x8000,-0x7ff00000,-0x7fff8000,0x20,-0x7fef7fe0,0x108020,0x20,0x8000,-0x80000000,0x8020,-0x7fef8000,0x100000,-0x7fffffe0,0x100020,-0x7fff7fe0,-0x7fffffe0,0x100020,0x108000,0,-0x7fff8000,0x8020,-0x80000000,-0x7fefffe0,-0x7fef7fe0,0x108000);var Oxbae= new Array(0x208,0x8020200,0,0x8020008,0x8000200,0,0x20208,0x8000200,0x20008,0x8000008,0x8000008,0x20000,0x8020208,0x20008,0x8020000,0x208,0x8000000,0x8,0x8020200,0x200,0x20200,0x8020000,0x8020008,0x20208,0x8000208,0x20200,0x20000,0x8000208,0x8,0x8020208,0x200,0x8000000,0x8020200,0x8000000,0x20008,0x208,0x20000,0x8020200,0x8000200,0,0x200,0x20008,0x8020208,0x8000200,0x8000008,0x200,0,0x8020008,0x8000208,0x20000,0x8000000,0x8020208,0x8,0x20208,0x20200,0x8000008,0x8020000,0x8000208,0x208,0x8020000,0x20208,0x8,0x8020008,0x20200);var Oxbaf= new Array(0x802001,0x2081,0x2081,0x80,0x802080,0x800081,0x800001,0x2001,0,0x802000,0x802000,0x802081,0x81,0,0x800080,0x800001,0x1,0x2000,0x800000,0x802001,0x80,0x800000,0x2001,0x2080,0x800081,0x1,0x2080,0x800080,0x2000,0x802080,0x802081,0x81,0x800080,0x800001,0x802000,0x802081,0x81,0,0,0x802000,0x2080,0x800080,0x800081,0x1,0x802001,0x2081,0x2081,0x80,0x802081,0x81,0x1,0x2000,0x800001,0x2001,0x802080,0x800081,0x2001,0x2080,0x800000,0x802001,0x80,0x800000,0x2000,0x802080);var Oxbb0= new Array(0x100,0x2080100,0x2080000,0x42000100,0x80000,0x100,0x40000000,0x2080000,0x40080100,0x80000,0x2000100,0x40080100,0x42000100,0x42080000,0x80100,0x40000000,0x2000000,0x40080000,0x40080000,0,0x40000100,0x42080100,0x42080100,0x2000100,0x42080000,0x40000100,0,0x42000000,0x2080100,0x2000000,0x42000000,0x80100,0x80000,0x42000100,0x100,0x2000000,0x40000000,0x2080000,0x42000100,0x40080100,0x2000100,0x40000000,0x42080000,0x2080100,0x40080100,0x100,0x2000000,0x42080000,0x42080100,0x80100,0x42000000,0x42080100,0x2080000,0,0x40080000,0x42000000,0x80100,0x2000100,0x40000100,0x80000,0,0x40080000,0x2080100,0x40000100);var Oxbb1= new Array(0x20000010,0x20400000,0x4000,0x20404010,0x20400000,0x10,0x20404010,0x400000,0x20004000,0x404010,0x400000,0x20000010,0x400010,0x20004000,0x20000000,0x4010,0,0x400010,0x20004010,0x4000,0x404000,0x20004010,0x10,0x20400010,0x20400010,0,0x404010,0x20404000,0x4010,0x404000,0x20404000,0x20000000,0x20004000,0x10,0x20400010,0x404000,0x20404010,0x400000,0x4010,0x20000010,0x400000,0x20004000,0x20000000,0x4010,0x20000010,0x20404010,0x404000,0x20400000,0x404010,0x20404000,0,0x20400010,0x10,0x4000,0x20400000,0x404010,0x4000,0x400010,0x20004010,0,0x20404000,0x20000000,0x400010,0x20004010);var Oxbb2= new Array(0x200000,0x4200002,0x4000802,0,0x800,0x4000802,0x200802,0x4200800,0x4200802,0x200000,0,0x4000002,0x2,0x4000000,0x4200002,0x802,0x4000800,0x200802,0x200002,0x4000800,0x4000002,0x4200000,0x4200800,0x200002,0x4200000,0x800,0x802,0x4200802,0x200800,0x2,0x4000000,0x200800,0x4000000,0x200800,0x200000,0x4000802,0x4000802,0x4200002,0x4200002,0x2,0x200002,0x4000000,0x4000800,0x200000,0x4200800,0x802,0x200802,0x4200800,0x802,0x4000002,0x4200802,0x4200000,0x200800,0,0x2,0x4200802,0,0x200802,0x4200000,0x800,0x4000002,0x4000800,0x800,0x200002);var Oxbb3= new Array(0x10001040,0x1000,0x40000,0x10041040,0x10000000,0x10001040,0x40,0x10000000,0x40040,0x10040000,0x10041040,0x41000,0x10041000,0x41040,0x1000,0x40,0x10040000,0x10000040,0x10001000,0x1040,0x41000,0x40040,0x10040040,0x10041000,0x1040,0,0,0x10040040,0x10000040,0x10001000,0x41040,0x40000,0x41040,0x40000,0x10041000,0x1000,0x40,0x10040040,0x1000,0x41040,0x10001000,0x40,0x10000040,0x10040000,0x10040040,0x10000000,0x40000,0x10001040,0,0x10041040,0x40040,0x10000040,0x10040000,0x10001000,0x10001040,0,0x10041040,0x41000,0x41000,0x1040,0x1040,0x40040,0x10000000,0x10041000);var Ox404=Oxbc2(Ox401);var m=0,i,Ox1f7,Ox337,Oxbb4,Oxbb5,Oxbb6,Ox7e8,Oxbb7,Oxbb8;var Oxbb9,Oxbba,Oxbbb,Oxbbc;var Oxbbd,Oxbbe;var len=Oxba8[OxO8621[26]];var Oxbbf=0;var Oxbc0=Ox404[OxO8621[26]]==32?3:9;if(Oxbc0==3){Oxbb8=Oxba9? new Array(0,32,2): new Array(30,-2,-2);} else {Oxbb8=Oxba9? new Array(0,32,2,62,30,-2,64,96,2): new Array(94,62,-2,32,64,2,30,-2,-2);} ;var Ox338=OxO8621[25];var Oxbc1=OxO8621[25];if(Ox342==1){Oxbb9=(Oxbaa.charCodeAt(m++)<<24)|(Oxbaa.charCodeAt(m++)<<16)|(Oxbaa.charCodeAt(m++)<<8)|Oxbaa.charCodeAt(m++);Oxbbb=(Oxbaa.charCodeAt(m++)<<24)|(Oxbaa.charCodeAt(m++)<<16)|(Oxbaa.charCodeAt(m++)<<8)|Oxbaa.charCodeAt(m++);m=0;} ;while(m<len){Ox7e8=(Oxba8.charCodeAt(m++)<<24)|(Oxba8.charCodeAt(m++)<<16)|(Oxba8.charCodeAt(m++)<<8)|Oxba8.charCodeAt(m++);Oxbb7=(Oxba8.charCodeAt(m++)<<24)|(Oxba8.charCodeAt(m++)<<16)|(Oxba8.charCodeAt(m++)<<8)|Oxba8.charCodeAt(m++);if(Ox342==1){if(Oxba9){Ox7e8^=Oxbb9;Oxbb7^=Oxbbb;} else {Oxbba=Oxbb9;Oxbbc=Oxbbb;Oxbb9=Ox7e8;Oxbbb=Oxbb7;} ;} ;Ox337=((Ox7e8>>>4)^Oxbb7)&0x0f0f0f0f;Oxbb7^=Ox337;Ox7e8^=(Ox337<<4);Ox337=((Ox7e8>>>16)^Oxbb7)&0x0000ffff;Oxbb7^=Ox337;Ox7e8^=(Ox337<<16);Ox337=((Oxbb7>>>2)^Ox7e8)&0x33333333;Ox7e8^=Ox337;Oxbb7^=(Ox337<<2);Ox337=((Oxbb7>>>8)^Ox7e8)&0x00ff00ff;Ox7e8^=Ox337;Oxbb7^=(Ox337<<8);Ox337=((Ox7e8>>>1)^Oxbb7)&0x55555555;Oxbb7^=Ox337;Ox7e8^=(Ox337<<1);Ox7e8=((Ox7e8<<1)|(Ox7e8>>>31));Oxbb7=((Oxbb7<<1)|(Oxbb7>>>31));for(Ox1f7=0;Ox1f7<Oxbc0;Ox1f7+=3){Oxbbd=Oxbb8[Ox1f7+1];Oxbbe=Oxbb8[Ox1f7+2];for(i=Oxbb8[Ox1f7];i!=Oxbbd;i+=Oxbbe){Oxbb5=Oxbb7^Ox404[i];Oxbb6=((Oxbb7>>>4)|(Oxbb7<<28))^Ox404[i+1];Ox337=Ox7e8;Ox7e8=Oxbb7;Oxbb7=Ox337^(Oxbad[(Oxbb5>>>24)&0x3f]|Oxbaf[(Oxbb5>>>16)&0x3f]|Oxbb1[(Oxbb5>>>8)&0x3f]|Oxbb3[Oxbb5&0x3f]|Oxbac[(Oxbb6>>>24)&0x3f]|Oxbae[(Oxbb6>>>16)&0x3f]|Oxbb0[(Oxbb6>>>8)&0x3f]|Oxbb2[Oxbb6&0x3f]);} ;Ox337=Ox7e8;Ox7e8=Oxbb7;Oxbb7=Ox337;} ;Ox7e8=((Ox7e8>>>1)|(Ox7e8<<31));Oxbb7=((Oxbb7>>>1)|(Oxbb7<<31));Ox337=((Ox7e8>>>1)^Oxbb7)&0x55555555;Oxbb7^=Ox337;Ox7e8^=(Ox337<<1);Ox337=((Oxbb7>>>8)^Ox7e8)&0x00ff00ff;Ox7e8^=Ox337;Oxbb7^=(Ox337<<8);Ox337=((Oxbb7>>>2)^Ox7e8)&0x33333333;Ox7e8^=Ox337;Oxbb7^=(Ox337<<2);Ox337=((Ox7e8>>>16)^Oxbb7)&0x0000ffff;Oxbb7^=Ox337;Ox7e8^=(Ox337<<16);Ox337=((Ox7e8>>>4)^Oxbb7)&0x0f0f0f0f;Oxbb7^=Ox337;Ox7e8^=(Ox337<<4);if(Ox342==1){if(Oxba9){Oxbb9=Ox7e8;Oxbbb=Oxbb7;} else {Ox7e8^=Oxbba;Oxbb7^=Oxbbc;} ;} ;Oxbc1+=String.fromCharCode((Ox7e8>>>24),((Ox7e8>>>16)&0xff),((Ox7e8>>>8)&0xff),(Ox7e8&0xff),(Oxbb7>>>24),((Oxbb7>>>16)&0xff),((Oxbb7>>>8)&0xff),(Oxbb7&0xff));Oxbbf+=8;if(Oxbbf==512){Ox338+=Oxbc1;Oxbc1=OxO8621[25];Oxbbf=0;} ;} ;return Ox338+Oxbc1;} ;function Oxbc2(Ox401){var Oxbc3= new Array(0,0x4,0x20000000,0x20000004,0x10000,0x10004,0x20010000,0x20010004,0x200,0x204,0x20000200,0x20000204,0x10200,0x10204,0x20010200,0x20010204);var Oxbc4= new Array(0,0x1,0x100000,0x100001,0x4000000,0x4000001,0x4100000,0x4100001,0x100,0x101,0x100100,0x100101,0x4000100,0x4000101,0x4100100,0x4100101);var Oxbc5= new Array(0,0x8,0x800,0x808,0x1000000,0x1000008,0x1000800,0x1000808,0,0x8,0x800,0x808,0x1000000,0x1000008,0x1000800,0x1000808);var Oxbc6= new Array(0,0x200000,0x8000000,0x8200000,0x2000,0x202000,0x8002000,0x8202000,0x20000,0x220000,0x8020000,0x8220000,0x22000,0x222000,0x8022000,0x8222000);var Oxbc7= new Array(0,0x40000,0x10,0x40010,0,0x40000,0x10,0x40010,0x1000,0x41000,0x1010,0x41010,0x1000,0x41000,0x1010,0x41010);var Oxbc8= new Array(0,0x400,0x20,0x420,0,0x400,0x20,0x420,0x2000000,0x2000400,0x2000020,0x2000420,0x2000000,0x2000400,0x2000020,0x2000420);var Oxbc9= new Array(0,0x10000000,0x80000,0x10080000,0x2,0x10000002,0x80002,0x10080002,0,0x10000000,0x80000,0x10080000,0x2,0x10000002,0x80002,0x10080002);var Oxbca= new Array(0,0x10000,0x800,0x10800,0x20000000,0x20010000,0x20000800,0x20010800,0x20000,0x30000,0x20800,0x30800,0x20020000,0x20030000,0x20020800,0x20030800);var Oxbcb= new Array(0,0x40000,0,0x40000,0x2,0x40002,0x2,0x40002,0x2000000,0x2040000,0x2000000,0x2040000,0x2000002,0x2040002,0x2000002,0x2040002);var Oxbcc= new Array(0,0x10000000,0x8,0x10000008,0,0x10000000,0x8,0x10000008,0x400,0x10000400,0x408,0x10000408,0x400,0x10000400,0x408,0x10000408);var Oxbcd= new Array(0,0x20,0,0x20,0x100000,0x100020,0x100000,0x100020,0x2000,0x2020,0x2000,0x2020,0x102000,0x102020,0x102000,0x102020);var Oxbce= new Array(0,0x1000000,0x200,0x1000200,0x200000,0x1200000,0x200200,0x1200200,0x4000000,0x5000000,0x4000200,0x5000200,0x4200000,0x5200000,0x4200200,0x5200200);var Oxbcf= new Array(0,0x1000,0x8000000,0x8001000,0x80000,0x81000,0x8080000,0x8081000,0x10,0x1010,0x8000010,0x8001010,0x80010,0x81010,0x8080010,0x8081010);var Oxbd0= new Array(0,0x4,0x100,0x104,0,0x4,0x100,0x104,0x1,0x5,0x101,0x105,0x1,0x5,0x101,0x105);var Oxbc0=Ox401[OxO8621[26]]>8?3:1;var Ox404= new Array(32*Oxbc0);var Oxbd1= new Array(0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0);var Oxbd2,Oxbd3,m=0,Ox248=0,Ox337;var Ox7e8,Oxbb7;for(var Ox1f7=0;Ox1f7<Oxbc0;Ox1f7++){Ox7e8=(Ox401.charCodeAt(m++)<<24)|(Ox401.charCodeAt(m++)<<16)|(Ox401.charCodeAt(m++)<<8)|Ox401.charCodeAt(m++);Oxbb7=(Ox401.charCodeAt(m++)<<24)|(Ox401.charCodeAt(m++)<<16)|(Ox401.charCodeAt(m++)<<8)|Ox401.charCodeAt(m++);Ox337=((Ox7e8>>>4)^Oxbb7)&0x0f0f0f0f;Oxbb7^=Ox337;Ox7e8^=(Ox337<<4);Ox337=((Oxbb7>>>-16)^Ox7e8)&0x0000ffff;Ox7e8^=Ox337;Oxbb7^=(Ox337<<-16);Ox337=((Ox7e8>>>2)^Oxbb7)&0x33333333;Oxbb7^=Ox337;Ox7e8^=(Ox337<<2);Ox337=((Oxbb7>>>-16)^Ox7e8)&0x0000ffff;Ox7e8^=Ox337;Oxbb7^=(Ox337<<-16);Ox337=((Ox7e8>>>1)^Oxbb7)&0x55555555;Oxbb7^=Ox337;Ox7e8^=(Ox337<<1);Ox337=((Oxbb7>>>8)^Ox7e8)&0x00ff00ff;Ox7e8^=Ox337;Oxbb7^=(Ox337<<8);Ox337=((Ox7e8>>>1)^Oxbb7)&0x55555555;Oxbb7^=Ox337;Ox7e8^=(Ox337<<1);Ox337=(Ox7e8<<8)|((Oxbb7>>>20)&0x000000f0);Ox7e8=(Oxbb7<<24)|((Oxbb7<<8)&0xff0000)|((Oxbb7>>>8)&0xff00)|((Oxbb7>>>24)&0xf0);Oxbb7=Ox337;for(i=0;i<Oxbd1[OxO8621[26]];i++){if(Oxbd1[i]){Ox7e8=(Ox7e8<<2)|(Ox7e8>>>26);Oxbb7=(Oxbb7<<2)|(Oxbb7>>>26);} else {Ox7e8=(Ox7e8<<1)|(Ox7e8>>>27);Oxbb7=(Oxbb7<<1)|(Oxbb7>>>27);} ;Ox7e8&=-0xf;Oxbb7&=-0xf;Oxbd2=Oxbc3[Ox7e8>>>28]|Oxbc4[(Ox7e8>>>24)&0xf]|Oxbc5[(Ox7e8>>>20)&0xf]|Oxbc6[(Ox7e8>>>16)&0xf]|Oxbc7[(Ox7e8>>>12)&0xf]|Oxbc8[(Ox7e8>>>8)&0xf]|Oxbc9[(Ox7e8>>>4)&0xf];Oxbd3=Oxbca[Oxbb7>>>28]|Oxbcb[(Oxbb7>>>24)&0xf]|Oxbcc[(Oxbb7>>>20)&0xf]|Oxbcd[(Oxbb7>>>16)&0xf]|Oxbce[(Oxbb7>>>12)&0xf]|Oxbcf[(Oxbb7>>>8)&0xf]|Oxbd0[(Oxbb7>>>4)&0xf];Ox337=((Oxbd3>>>16)^Oxbd2)&0x0000ffff;Ox404[Ox248++]=Oxbd2^Ox337;Ox404[Ox248++]=Oxbd3^(Ox337<<16);} ;} ;return Ox404;} ;var Oxba8=[];for(var i=0;i<Oxba6[OxO8621[26]];i++){Oxba8.push(String.fromCharCode(Oxba6[i]));} ;Oxba8=Oxba8.join(OxO8621[25]);var Oxbd4=[0x46,0x35,0x32,0x42,0x31,0x38,0x36,0x46];var Ox401=[];for(var i=0;i<Oxbd4[OxO8621[26]];i++){Ox401.push(String.fromCharCode(Oxbd4[i]));} ;Ox401=Ox401.join(OxO8621[25]);var Oxbaa=Ox401;return Oxba7(Ox401,Oxba8,0,1,Oxbaa);} ;var Oxbd5;var Oxbd6;var Oxbd7;var Oxbd8;function Oxbd9(Oxbda){var Ox3c1=CreateXMLHttpRequest();var Oxbdb=Oxbea;if(!Oxbd5){Ox3c1.open(OxO8621[179],editor.GetScriptProperty(OxO8621[104])+OxO8621[186]+OxO8621[187]+ new Date().getTime(),false);Ox3c1.send(OxO8621[25]);if(Ox3c1[OxO8621[181]]!=200){return Oxbdb(1000,OxO8621[188]);} ;Oxbd5=Ox3c1[OxO8621[189]].toUpperCase();} ;if(!Oxbd6){Oxbd6={};var Oxbdc=[OxO8621[190],OxO8621[191],OxO8621[192],OxO8621[193],OxO8621[194],OxO8621[195],OxO8621[196],OxO8621[197],OxO8621[198],OxO8621[199],OxO8621[200],OxO8621[201],OxO8621[202],OxO8621[203],OxO8621[204],OxO8621[205]];for(var i=0;i<Oxbdc[OxO8621[26]];i++){Oxbd6[Oxbdc[i]]=i;} ;} ;try{if(!Oxbd7){if(Oxbd5.substring(0,16)!=OxO8621[206]){return Oxbdb(1001);} ;var Oxbdd=[];for(var i=0;i<Oxbd5[OxO8621[26]];i+=2){Oxbdd.push(Oxbd6[Oxbd5.charAt(i)]*16+Oxbd6[Oxbd5.charAt(i+1)]);} ;Oxbdd.splice(0,8);Oxbdd.splice(0,123);var Oxbde=Oxbdd[0]+Oxbdd[1]*256;Oxbdd.splice(0,4);var Oxbdf=Oxbdd.slice(0,Oxbde);var Oxbe0=Oxba5(Oxbdf);Oxbe0=Oxbe0.replace(/^\xEF\xBB\xBF/,OxO8621[25]).replace(/[\x00-\x08]*$/,OxO8621[25]);Oxbd7=Oxbe0.split(OxO8621[207]);} ;if(Oxbd7[OxO8621[26]]!=10){return Oxbdb(1002,Oxbd7.length);} ;var Oxbe1=Oxbd7[9].split(OxO8621[208]);var Oxbe2= new Date(parseFloat(Oxbe1[2]),parseFloat(Oxbe1[1])-1,parseFloat(Oxbe1[0]));var Oxbe3=Oxbe2.getTime();if((Oxbd7[5]<<2)!=1200685124){return Oxbdb(1003,Oxbd7[5]);} ;var Oxbe4=window[OxO8621[169]][OxO8621[168]].split(OxO8621[210])[1].split(OxO8621[208])[0].split(OxO8621[209])[0].toLowerCase();var Oxbe5=false;if(Oxbe4==String.fromCharCode(108,111,99,97,108,104,111,115,116)){Oxbe5=true;} ;if(Oxbe4==String.fromCharCode(49,50,55,46,48,46,48,46,49)){Oxbe5=true;} ;function Oxbe6(Oxbe7){var Ox259=Oxbe7.split(OxO8621[211]);if(Ox259[0]==OxO8621[212]){Ox259.splice(0,1);} ;return Ox259.join(OxO8621[211]);} ;Oxbe4=Oxbe6(Oxbe4);var Oxbe8=Oxbd7[7].toLowerCase();var Oxbe9=Oxbd7[8];switch(parseInt(Oxbd7[6])){case 0:if(Oxbe3< new Date().getTime()){return Oxbdb(20000,Oxbe2);} ;if(Oxbe5){break ;} ;return Oxbdb(20001,Oxbe4);;case 1:if(Oxbe5){break ;} ;if(Oxbe8!=Oxbe4&&Oxbe8.indexOf(Oxbe4)==-1){return Oxbdb(20010,Oxbe4,Oxbe8);} ;break ;;case 2:if(Oxbe5){break ;} ;if(!Oxbd8){Ox3c1.open(OxO8621[179],editor.GetScriptProperty(OxO8621[104])+OxO8621[186]+OxO8621[213]+ new Date().getTime(),false);Ox3c1.send(OxO8621[25]);if(Ox3c1[OxO8621[181]]!=200){return Oxbdb(1000,OxO8621[214]);} ;Oxbd8=Ox3c1[OxO8621[189]];} ;if(Oxbe9!=Oxbd8&&Oxbe9.indexOf(Oxbd8)==-1){return Oxbdb(20020,Oxbd8,Oxbe9);} ;break ;;case 3:if(Oxbe5){break ;} ;if(Oxbe8.indexOf(Oxbe4)==-1){return Oxbdb(20030,Oxbe4,Oxbe8);} ;break ;;case 4:if(Oxbe3< new Date().getTime()){return Oxbdb(20040,Oxbe2);} ;break ;;case 5:break ;;default:return Oxbdb(1004,parseInt(Oxbd7[6]));;} ;} catch(x){return Oxbdb(1000,x.message);} ;return Oxbda();} ;function Oxbea(Oxbeb,Ox847){var msg=OxO8621[25];switch(Oxbeb){case 1000:msg=Ox847;break ;;case 1001:msg=OxO8621[215];break ;;case 1002:msg=OxO8621[216]+Ox847;break ;;case 1003:msg=OxO8621[217];break ;;case 1004:msg=OxO8621[218];break ;;case 20000:msg=OxO8621[219];break ;;case 20001:msg=OxO8621[220];break ;;case 20010:msg=OxO8621[221]+Ox847;break ;;case 20020:msg=OxO8621[222]+Ox847;break ;;case 20030:msg=OxO8621[223]+Ox847;break ;;case 20040:msg=OxO8621[224];break ;;} ;try{return alert(OxO8621[225]+msg);} catch(x){} ;} ;CuteEditor_BasicInitialize(editor);Oxb9d();Oxbd9(Oxba2);function CuteEditor_Find_DisplayNone(element){var Oxbed;for(var Ox283=element;Ox283!=null;Ox283=Ox283[OxO8621[42]]){if(Ox283[OxO8621[58]]&&Ox283[OxO8621[58]][OxO8621[57]]==OxO8621[67]){Oxbed=Ox283;break ;} ;} ;return Oxbed;} ;} ;function CuteEditorInstallScriptCode(Oxae8,Oxae9){eval(Oxae8);window[Oxae9]=eval(Oxae9);} ;window[OxO8621[226]]=CuteEditorInitialize;
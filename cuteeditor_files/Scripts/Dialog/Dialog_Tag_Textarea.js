var OxO4d55=["inp_name","inp_cols","inp_rows","inp_value","sel_Wrap","inp_id","inp_access","inp_index","inp_Disabled","inp_Readonly","Name","value","name","id","cols","","rows","checked","disabled","readOnly","wrap","tabIndex","accessKey","textContent"];var inp_name=Window_GetElement(window,OxO4d55[0],true);var inp_cols=Window_GetElement(window,OxO4d55[1],true);var inp_rows=Window_GetElement(window,OxO4d55[2],true);var inp_value=Window_GetElement(window,OxO4d55[3],true);var sel_Wrap=Window_GetElement(window,OxO4d55[4],true);var inp_id=Window_GetElement(window,OxO4d55[5],true);var inp_access=Window_GetElement(window,OxO4d55[6],true);var inp_index=Window_GetElement(window,OxO4d55[7],true);var inp_Disabled=Window_GetElement(window,OxO4d55[8],true);var inp_Readonly=Window_GetElement(window,OxO4d55[9],true);UpdateState=function UpdateState_Textarea(){} ;SyncToView=function SyncToView_Textarea(){if(element[OxO4d55[10]]){inp_name[OxO4d55[11]]=element[OxO4d55[10]];} ;if(element[OxO4d55[12]]){inp_name[OxO4d55[11]]=element[OxO4d55[12]];} ;inp_id[OxO4d55[11]]=element[OxO4d55[13]];inp_value[OxO4d55[11]]=element[OxO4d55[11]];if(element[OxO4d55[14]]){if(element[OxO4d55[14]]==20){inp_cols[OxO4d55[11]]=OxO4d55[15];} else {inp_cols[OxO4d55[11]]=element[OxO4d55[14]];} ;} ;if(element[OxO4d55[16]]){if(element[OxO4d55[16]]==2){inp_rows[OxO4d55[11]]=OxO4d55[15];} else {inp_rows[OxO4d55[11]]=element[OxO4d55[16]];} ;} ;inp_Disabled[OxO4d55[17]]=element[OxO4d55[18]];inp_Readonly[OxO4d55[17]]=element[OxO4d55[19]];sel_Wrap[OxO4d55[11]]=element[OxO4d55[20]];if(element[OxO4d55[21]]==0){inp_index[OxO4d55[11]]=OxO4d55[15];} else {inp_index[OxO4d55[11]]=element[OxO4d55[21]];} ;if(element[OxO4d55[22]]){inp_access[OxO4d55[11]]=element[OxO4d55[22]];} ;} ;SyncTo=function SyncTo_Textarea(element){element[OxO4d55[12]]=inp_name[OxO4d55[11]];if(element[OxO4d55[10]]){element[OxO4d55[10]]=inp_name[OxO4d55[11]];} else {if(element[OxO4d55[12]]){element.removeAttribute(OxO4d55[12],0);element[OxO4d55[10]]=inp_name[OxO4d55[11]];} else {element[OxO4d55[10]]=inp_name[OxO4d55[11]];} ;} ;element[OxO4d55[13]]=inp_id[OxO4d55[11]];element[OxO4d55[11]]=inp_value[OxO4d55[11]];if(!Browser_IsWinIE()){try{element[OxO4d55[23]]=inp_value[OxO4d55[11]];} catch(x){} ;} ;element[OxO4d55[21]]=inp_index[OxO4d55[11]];element[OxO4d55[18]]=inp_Disabled[OxO4d55[17]];element[OxO4d55[19]]=inp_Readonly[OxO4d55[17]];element[OxO4d55[22]]=inp_access[OxO4d55[11]];if(inp_cols[OxO4d55[11]]==OxO4d55[15]){element[OxO4d55[14]]=20;} else {element[OxO4d55[14]]=inp_cols[OxO4d55[11]];} ;if(inp_rows[OxO4d55[11]]==OxO4d55[15]){element[OxO4d55[16]]=2;} else {element[OxO4d55[16]]=inp_rows[OxO4d55[11]];} ;try{element[OxO4d55[20]]=sel_Wrap[OxO4d55[11]];} catch(e){element.removeAttribute(OxO4d55[20]);} ;element[OxO4d55[21]]=inp_index[OxO4d55[11]];if(element[OxO4d55[21]]==OxO4d55[15]){element.removeAttribute(OxO4d55[21]);} ;if(element[OxO4d55[22]]==OxO4d55[15]){element.removeAttribute(OxO4d55[22]);} ;} ;
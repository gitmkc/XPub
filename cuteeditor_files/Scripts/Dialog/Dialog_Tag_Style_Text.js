var OxO7e2f=["","sel_align","sel_valign","sel_justify","sel_letter","tb_letter","sel_letter_unit","sel_line","tb_line","sel_line_unit","tb_indent","sel_indent_unit","sel_direction","sel_writingmode","outer","div_demo","disabled","selectedIndex","cssText","style","value","textAlign","verticalAlign","textJustify","letterSpacing","length","options","lineHeight","textIndent","direction","writingMode"];function ParseFloatToString(Oxb){var Ox2c9=parseFloat(Oxb);if(isNaN(Ox2c9)){return OxO7e2f[0];} ;return Ox2c9+OxO7e2f[0];} ;var sel_align=Window_GetElement(window,OxO7e2f[1],true);var sel_valign=Window_GetElement(window,OxO7e2f[2],true);var sel_justify=Window_GetElement(window,OxO7e2f[3],true);var sel_letter=Window_GetElement(window,OxO7e2f[4],true);var tb_letter=Window_GetElement(window,OxO7e2f[5],true);var sel_letter_unit=Window_GetElement(window,OxO7e2f[6],true);var sel_line=Window_GetElement(window,OxO7e2f[7],true);var tb_line=Window_GetElement(window,OxO7e2f[8],true);var sel_line_unit=Window_GetElement(window,OxO7e2f[9],true);var tb_indent=Window_GetElement(window,OxO7e2f[10],true);var sel_indent_unit=Window_GetElement(window,OxO7e2f[11],true);var sel_direction=Window_GetElement(window,OxO7e2f[12],true);var sel_writingmode=Window_GetElement(window,OxO7e2f[13],true);var outer=Window_GetElement(window,OxO7e2f[14],true);var div_demo=Window_GetElement(window,OxO7e2f[15],true);UpdateState=function UpdateState_Text(){tb_letter[OxO7e2f[16]]=sel_letter_unit[OxO7e2f[16]]=(sel_letter[OxO7e2f[17]]>0);tb_line[OxO7e2f[16]]=sel_line_unit[OxO7e2f[16]]=(sel_line[OxO7e2f[17]]>0);div_demo[OxO7e2f[19]][OxO7e2f[18]]=element[OxO7e2f[19]][OxO7e2f[18]];} ;SyncToView=function SyncToView_Text(){sel_align[OxO7e2f[20]]=element[OxO7e2f[19]][OxO7e2f[21]];sel_valign[OxO7e2f[20]]=element[OxO7e2f[19]][OxO7e2f[22]];sel_justify[OxO7e2f[20]]=element[OxO7e2f[19]][OxO7e2f[23]];sel_letter[OxO7e2f[20]]=element[OxO7e2f[19]][OxO7e2f[24]];sel_letter_unit[OxO7e2f[17]]=0;if(sel_letter[OxO7e2f[17]]==-1){if(ParseFloatToString(element[OxO7e2f[19]].letterSpacing)){tb_letter[OxO7e2f[20]]=ParseFloatToString(element[OxO7e2f[19]].letterSpacing);for(var i=0;i<sel_letter_unit[OxO7e2f[26]][OxO7e2f[25]];i++){var Ox275=sel_letter_unit[OxO7e2f[26]][i][OxO7e2f[20]];if(Ox275&&element[OxO7e2f[19]][OxO7e2f[24]].indexOf(Ox275)!=-1){sel_letter_unit[OxO7e2f[17]]=i;break ;} ;} ;} ;} ;sel_line[OxO7e2f[20]]=element[OxO7e2f[19]][OxO7e2f[27]];sel_line_unit[OxO7e2f[17]]=0;if(sel_line[OxO7e2f[17]]==-1){if(ParseFloatToString(element[OxO7e2f[19]].lineHeight)){tb_line[OxO7e2f[20]]=ParseFloatToString(element[OxO7e2f[19]].lineHeight);for(var i=0;i<sel_line_unit[OxO7e2f[26]][OxO7e2f[25]];i++){var Ox275=sel_line_unit[OxO7e2f[26]][i][OxO7e2f[20]];if(Ox275&&element[OxO7e2f[19]][OxO7e2f[27]].indexOf(Ox275)!=-1){sel_line_unit[OxO7e2f[17]]=i;break ;} ;} ;} ;} ;sel_indent_unit[OxO7e2f[17]]=0;if(!isNaN(ParseFloatToString(element[OxO7e2f[19]].textIndent))){tb_indent[OxO7e2f[20]]=ParseFloatToString(element[OxO7e2f[19]].textIndent);for(var i=0;i<sel_indent_unit[OxO7e2f[26]][OxO7e2f[25]];i++){var Ox275=sel_indent_unit[OxO7e2f[26]][i][OxO7e2f[20]];if(Ox275&&element[OxO7e2f[19]][OxO7e2f[28]].indexOf(Ox275)!=-1){sel_indent_unit[OxO7e2f[17]]=i;break ;} ;} ;} ;sel_direction[OxO7e2f[20]]=element[OxO7e2f[19]][OxO7e2f[29]];sel_writingmode[OxO7e2f[20]]=element[OxO7e2f[19]][OxO7e2f[30]];} ;SyncTo=function SyncTo_Text(element){element[OxO7e2f[19]][OxO7e2f[21]]=sel_align[OxO7e2f[20]];element[OxO7e2f[19]][OxO7e2f[22]]=sel_valign[OxO7e2f[20]];element[OxO7e2f[19]][OxO7e2f[23]]=sel_justify[OxO7e2f[20]];if(sel_letter[OxO7e2f[17]]>0){element[OxO7e2f[19]][OxO7e2f[24]]=sel_letter[OxO7e2f[20]];} else {if(ParseFloatToString(tb_letter.value)){element[OxO7e2f[19]][OxO7e2f[24]]=ParseFloatToString(tb_letter.value)+sel_letter_unit[OxO7e2f[20]];} else {element[OxO7e2f[19]][OxO7e2f[24]]=OxO7e2f[0];} ;} ;if(sel_line[OxO7e2f[17]]>0){element[OxO7e2f[19]][OxO7e2f[27]]=sel_line[OxO7e2f[20]];} else {if(ParseFloatToString(tb_line.value)){element[OxO7e2f[19]][OxO7e2f[27]]=ParseFloatToString(tb_line.value)+sel_line_unit[OxO7e2f[20]];} else {element[OxO7e2f[19]][OxO7e2f[27]]=OxO7e2f[0];} ;} ;if(ParseFloatToString(tb_indent.value)){element[OxO7e2f[19]][OxO7e2f[28]]=ParseFloatToString(tb_indent.value)+sel_indent_unit[OxO7e2f[20]];} else {element[OxO7e2f[19]][OxO7e2f[28]]=OxO7e2f[0];} ;element[OxO7e2f[19]][OxO7e2f[29]]=sel_direction[OxO7e2f[20]]||OxO7e2f[0];element[OxO7e2f[19]][OxO7e2f[30]]=sel_writingmode[OxO7e2f[20]]||OxO7e2f[0];} ;
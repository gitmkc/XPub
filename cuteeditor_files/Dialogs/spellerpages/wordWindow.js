var OxO69be=["_forms","_getWordObject","_wordInputStr","_adjustIndexes","_isWordChar","_lastPos","wordChar","windowType","wordWindow","originalSpellings","suggestions","checkWordBgColor","pink","normWordBgColor","white","text","","textInputs","indexes","resetForm","totalMisspellings","totalWords","totalPreviousWords","getTextVal","setFocus","removeFocus","setText","writeBody","printForHtml","length","value","type","backgroundColor","style","size","document","\x3Cform name=\x22textInput","\x22\x3E","\x3Cdiv class=\x22plainText\x22\x3E","\x3C/div\x3E","\x3C/form\x3E","forms","elements","\x3Cinput readonly ","class=\x22blend\x22 type=\x22text\x22 value=\x22","\x22 size=\x22"];function wordWindow(){this[OxO69be[0]]=[];this[OxO69be[1]]=_getWordObject;this[OxO69be[2]]=_wordInputStr;this[OxO69be[3]]=_adjustIndexes;this[OxO69be[4]]=_isWordChar;this[OxO69be[5]]=_lastPos;this[OxO69be[6]]=/[a-zA-Z]/;this[OxO69be[7]]=OxO69be[8];this[OxO69be[9]]= new Array();this[OxO69be[10]]= new Array();this[OxO69be[11]]=OxO69be[12];this[OxO69be[13]]=OxO69be[14];this[OxO69be[15]]=OxO69be[16];this[OxO69be[17]]= new Array();this[OxO69be[18]]= new Array();this[OxO69be[19]]=resetForm;this[OxO69be[20]]=totalMisspellings;this[OxO69be[21]]=totalWords;this[OxO69be[22]]=totalPreviousWords;this[OxO69be[23]]=getTextVal;this[OxO69be[24]]=setFocus;this[OxO69be[25]]=removeFocus;this[OxO69be[26]]=setText;this[OxO69be[27]]=writeBody;this[OxO69be[28]]=printForHtml;} ;function resetForm(){if(this[OxO69be[0]]){for(var i=0;i<this[OxO69be[0]][OxO69be[29]];i++){this[OxO69be[0]][i].reset();} ;} ;return true;} ;function totalMisspellings(){var Ox22d=0;for(var i=0;i<this[OxO69be[17]][OxO69be[29]];i++){Ox22d+=this.totalWords(i);} ;return Ox22d;} ;function totalWords(Ox22f){return this[OxO69be[9]][Ox22f][OxO69be[29]];} ;function totalPreviousWords(Ox22f,Ox231){var Ox22d=0;for(var i=0;i<=Ox22f;i++){for(var Ox1f7=0;Ox1f7<this.totalWords(i);Ox1f7++){if(i==Ox22f&&Ox1f7==Ox231){break ;} else {Ox22d++;} ;} ;} ;return Ox22d;} ;function getTextVal(Ox22f,Ox231){var Ox233=this._getWordObject(Ox22f,Ox231);if(Ox233){return Ox233[OxO69be[30]];} ;} ;function setFocus(Ox22f,Ox231){var Ox233=this._getWordObject(Ox22f,Ox231);if(Ox233){if(Ox233[OxO69be[31]]==OxO69be[15]){Ox233.focus();Ox233[OxO69be[33]][OxO69be[32]]=this[OxO69be[11]];} ;} ;} ;function removeFocus(Ox22f,Ox231){var Ox233=this._getWordObject(Ox22f,Ox231);if(Ox233){if(Ox233[OxO69be[31]]==OxO69be[15]){Ox233.blur();Ox233[OxO69be[33]][OxO69be[32]]=this[OxO69be[13]];} ;} ;} ;function setText(Ox22f,Ox231,Ox227){var Ox233=this._getWordObject(Ox22f,Ox231);var Ox237;var Ox238;if(Ox233){var Ox239=this[OxO69be[18]][Ox22f][Ox231];var Ox23a=Ox233[OxO69be[30]];Ox237=this[OxO69be[17]][Ox22f].substring(0,Ox239);Ox238=this[OxO69be[17]][Ox22f].substring(Ox239+Ox23a[OxO69be[29]],this[OxO69be[17]][Ox22f].length);this[OxO69be[17]][Ox22f]=Ox237+Ox227+Ox238;var Ox23b=Ox227[OxO69be[29]]-Ox23a[OxO69be[29]];this._adjustIndexes(Ox22f,Ox231,Ox23b);Ox233[OxO69be[34]]=Ox227[OxO69be[29]];Ox233[OxO69be[30]]=Ox227;this.removeFocus(Ox22f,Ox231);} ;} ;function writeBody(){var Ox23d=window[OxO69be[35]];var Ox23e=false;Ox23d.open();for(var Ox23f=0;Ox23f<this[OxO69be[17]][OxO69be[29]];Ox23f++){var Ox240=0;var Ox241=0;Ox23d.writeln(OxO69be[36]+Ox23f+OxO69be[37]);var Ox242=this[OxO69be[17]][Ox23f];this[OxO69be[18]][Ox23f]=[];if(Ox242){var Ox243=this[OxO69be[9]][Ox23f];if(!Ox243){break ;} ;Ox23d.writeln(OxO69be[38]);for(var i=0;i<Ox243[OxO69be[29]];i++){do{Ox241=Ox242.indexOf(Ox243[i],Ox240);Ox240=Ox241+Ox243[i][OxO69be[29]];if(Ox241==-1){break ;} ;var Ox244=Ox242.charAt(Ox241-1);var Ox245=Ox242.charAt(Ox240);} while(this._isWordChar(Ox244)||this._isWordChar(Ox245));;this[OxO69be[18]][Ox23f][i]=Ox241;for(var Ox1f7=this._lastPos(Ox23f,i);Ox1f7<Ox241;Ox1f7++){Ox23d.write(this.printForHtml(Ox242.charAt(Ox1f7)));} ;Ox23d.write(this._wordInputStr(Ox243[i]));if(i==Ox243[OxO69be[29]]-1){Ox23d.write(printForHtml(Ox242.substr(Ox240)));} ;} ;Ox23d.writeln(OxO69be[39]);} ;Ox23d.writeln(OxO69be[40]);} ;this[OxO69be[0]]=Ox23d[OxO69be[41]];Ox23d.close();} ;function _lastPos(Ox23f,Ox217){if(Ox217>0){return this[OxO69be[18]][Ox23f][Ox217-1]+this[OxO69be[9]][Ox23f][Ox217-1][OxO69be[29]];} else {return 0;} ;} ;function printForHtml(Ox248){return Ox248;} ;function _isWordChar(Ox24a){if(Ox24a.search(this.wordChar)==-1){return false;} else {return true;} ;} ;function _getWordObject(Ox22f,Ox231){if(this[OxO69be[0]][Ox22f]){if(this[OxO69be[0]][Ox22f][OxO69be[42]][Ox231]){return this[OxO69be[0]][Ox22f][OxO69be[42]][Ox231];} ;} ;return null;} ;function _wordInputStr(Ox233){var Oxb=OxO69be[43];Oxb+=OxO69be[44]+Ox233+OxO69be[45]+Ox233[OxO69be[29]]+OxO69be[37];return Oxb;} ;function _adjustIndexes(Ox22f,Ox231,Ox23b){for(var i=Ox231+1;i<this[OxO69be[9]][Ox22f][OxO69be[29]];i++){this[OxO69be[18]][Ox22f][i]=this[OxO69be[18]][Ox22f][i]+Ox23b;} ;} ;
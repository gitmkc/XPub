#!/usr/bin/perl -w

## Developed for SunXPublish - Digital Publsihing Platform

## Use Pragma for restrictions
use strict;
use Archive::Extract;
use File::Copy;

my ($task,$user,$inputdir,$outputdir,$filename,$fileDir,$tempWorkDir);
my ($epubFiles,$epubType,$fixlayout);
my ($scriptPath,$epubCheckJar,$Scriptlog);

if (!$ARGV[0]) {
    #print "<script language=\"JavaScript\" type=\"text\/javascript\">alert(\"Sorry wrong list of arguments. Please coordinate with system admin (mukesh\@technoscore.net).\");<\/script>";
    exit(0);
}

## ARGUMENT LIST FROM INTERFACE 
$task=$ARGV[0];
$user=$ARGV[1];
$filename=$ARGV[2];
$epubType=$ARGV[3] if ($ARGV[3]);
$fixlayout=$ARGV[4];

# print "\n\n$task, $user, $filename, $epubType, $fixlayout\n";

##
my $CDATETIME=`date`;
chop($CDATETIME);
my $currentdate=`date \'\+\%d-\%m-\%y\'`;
chop($currentdate);

## Strip out the extension
$filename=~s/.epub$//s;
$filename=~s/.zip$//s;

$fileDir=$filename;

##
$inputdir="../published/upload/$user";#D:/xampp/htdocs/publish/upload/$user
$outputdir="../published/download/$user";#D:/xampp/htdocs/publish/download/$user
$epubFiles="../webapp/epubFiles";

$scriptPath="../webapp/scripts";#D:/xampp/htdocs/publish/webapp";

$tempWorkDir="$inputdir/.${fileDir}temp";

$epubCheckJar="$scriptPath/../epubcheck-3.0b3/epubcheck-3.0b3.jar";

$Scriptlog="../logs/T2XScript${currentdate}.log";

##
#TYPEOUT(">>>>> ePub logging started at $CDATETIME\n>>>>> File: $fileDir, Inputdir: $inputdir, Outputdir: $outputdir, WebApp: $epubFiles, ScriptPath: $scriptPath, epubCheck: $epubCheckJar, Scriptlog: $Scriptlog\n");

if (-e "$inputdir/$filename.epub") {
    rename("$inputdir/$filename.epub","$inputdir/$filename.zip") or die "Copy failed: $!";
}


## OPEN MESSAGE WINDOW
print "<script language=\"JavaScript\" type=\"text\/javascript\">\n var newWindow = window.open(\" \",\"newWin\",\"width=350,height=400,toolbar=0,directories=0,status=0,menubar=0,location=0,scrollbars=1,resizable=0,top=260,left=650\");\nnewWindow.document.write(\"<title>EUB Message Window... &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<\/title><b><span style='font-family:Calibri;font-size:13px;'>Generating EPUB...<\/span><\/b><br\/>\")\nnewWindow.document.bgColor=\"#F2F2F2\";\n</script>";

## Create Temp Workdir
system("mkdir -p ${tempWorkDir}");

## CHECK EPUB TYPE
if ($task eq "generate") {
    ##
    &createePub();

    ##
    &createPacket();
} else {
    &validateEPUB();
}

exit(0);

## SUBROUTINES
sub createePub() {
    ##
    &extractZip;

    ##
    if (-d "$tempWorkDir") {
	my ($file);
	#print "$epubType\n";
	system("mkdir -p $tempWorkDir/$epubType");
        opendir(DIR,"$tempWorkDir") || die ("Doesn't exist");  
        while (defined($file=readdir(DIR))) {
	    ## Remove XMLinfo
	    if ($file=~/^xmlinfo.txt([\~]?)$/) {
		unlink("$tempWorkDir/$file");
	    }

	    if ($file=~/\.(xhtml|html)$/) {
		#print "\nsubdir $epubType and files==>(".$file.")\n";
		# my $createDir=" >> ${Scriptlog} 2>"."\"$tempWorkDir/${fileDir}.log\"";
		&modifyHTML("$file");
		# system("mkdir -p $tempWorkDir/$epubType");
		move("$tempWorkDir/$file","$tempWorkDir/$epubType");
	    }
	    
	    ##
	    if ($file=~/.css$/s) {
		# system("mkdir -p $tempWorkDir/$epubType");
		system("mkdir -p $tempWorkDir/$epubType/css");
		system("mv $tempWorkDir/${file} $tempWorkDir/$epubType/css/stylesheet.css");
	    }
	    
	    if ($file eq "css") {
		# system("mkdir -p $tempWorkDir/$epubType");
		system("mv $tempWorkDir/${file} $tempWorkDir/$epubType");
	    }
	    
# 	    ## Copy Image Dir to epub
	    if (($file eq "Images" || $file eq "images") && ((-d "$tempWorkDir/Images") || (-d "$tempWorkDir/images"))) {
		# print "\n==($fileDir+$epubType=".$file.")\n";
		if (-e "$tempWorkDir/$file/Thumbs.db") {
		    system("rm $tempWorkDir/$file/Thumbs.db");
		}
		# system("mkdir -p $tempWorkDir/$epubType");
		system("mv $tempWorkDir/$file $tempWorkDir/$epubType");
	    }
	    
        }
	closedir(DIR);
# 	    ## Copy mimetype
	copy("$epubFiles/mimetype","$tempWorkDir");
	system("mkdir -p $tempWorkDir/META-INF");
	system("cp -p \"$epubFiles/$epubType/container.xml\" \"$tempWorkDir/META-INF\"");
	if ($fixlayout eq 'true') {
	    system("cp -p \"$epubFiles/$epubType/com.apple.ibooks.display-options.xml\" \"$tempWorkDir/META-INF\"");
	}
	system("cp -p \"$epubFiles/page-template.xpgt\" \"$tempWorkDir/$epubType\"");
    }

    ## Generate OPF
    &writeToPopup("Generating OPF...");
    system("perl $scriptPath/createOPF-v1.0.pl \"$tempWorkDir/$epubType\" >> ${Scriptlog}");# && mv \"$tempWorkDir/content.opf\" \"$tempWorkDir/$epubType\"

    ## Deletes OPF and NAV logs files
    unlink("$tempWorkDir/$epubType/OPF.log") if (-e "$tempWorkDir/$epubType/OPF.log");
    unlink("$tempWorkDir/$epubType/NAV.log") if (-e "$tempWorkDir/$epubType/NAV.log");
    
    ##
    # system("/usr/local/bin/xml_pp $tempWorkDir/$epubType/content.opf > $tempWorkDir/$epubType/CONTENT.opf 2>$tempWorkDir/$epubType/OPF.log");#
    # if (-s "$tempWorkDir/$epubType/OPF.log") {
    # 	#print "Problem to pretty printing OPF\n";
    # 	&writeToPopup("Problem to pretty printing OPF...");
    # 	system("rm $tempWorkDir/$epubType/CONTENT.opf");
    # } else {
    # 	#print "Success OPF\n";
    # 	system("rm $tempWorkDir/$epubType/OPF.log");
    # 	system("mv $tempWorkDir/$epubType/CONTENT.opf $tempWorkDir/$epubType/content.opf");
    # }

    ## Generate NCX
    &writeToPopup("Generating Navigation (toc)...");
    system("perl $scriptPath/createTOC-v1.0.pl \"$tempWorkDir/$epubType\" >> ${Scriptlog}");# && mv \"$tempWorkDir/toc.ncx\" \"$tempWorkDir/$epubType\"

    # system("/usr/local/bin/xml_pp -s indented $tempWorkDir/$epubType/toc.ncx > $tempWorkDir/$epubType/TOC.ncx 2>$tempWorkDir/$epubType/NAV.log");
    # if (-s "$tempWorkDir/$epubType/NAV.log") {
    # 	#print "Problem to pretty printing NAV\n";
    # 	&writeToPopup("Problem to pretty printing NAV...");
    # 	system("rm $tempWorkDir/$epubType/TOC.ncx");
    # } else {
    # 	#print "Success NAV\n";
    # 	system("rm $tempWorkDir/$epubType/NAV.log");
    # 	system("mv $tempWorkDir/$epubType/TOC.ncx $tempWorkDir/$epubType/toc.ncx");
    # }
}

##
sub modifyHTML () {
    my ($htmlFile) = @_;
    my ($HTMLContents,$htmlFileExt);
    #print $htmlFile."\n";
    open(HTMLFILE,"$tempWorkDir/$htmlFile") || die ("Couldn't open file '$htmlFile'!");
    {
	local $/ = undef;
	$HTMLContents = <HTMLFILE>;
    }
    close(HTMLFILE);

    ## Add space in Ligature for PDF QA - When we copy text from pdf then it contains spaces in ligatures.
    ## Case 1 - fl
    $HTMLContents=~s/([A-Za-z])f l([A-Za-z])/${1}fl$2/g;
    $HTMLContents=~s/ F l([A-Za-z])/Fl$1/g;
    $HTMLContents=~s/([A-Za-z])f l /${1}fl /g;

    ## Case 2 - fi
    $HTMLContents=~s/([A-Za-z])f i([A-Za-z])/${1}fi$2/g;
    $HTMLContents=~s/ F i([A-Za-z])/Fi$1/g;
    $HTMLContents=~s/([A-Za-z])f i /${1}fi /g;

    ## Case 3 - ff
    $HTMLContents=~s/([A-Za-z])f f([A-Za-z])/${1}ff$2/g;
    $HTMLContents=~s/ F f([A-Za-z])/Ff$1/g;
    $HTMLContents=~s/([A-Za-z])f f /${1}ff /g;

    ##
    if ($HTMLContents=~/<link (.+?) href="style.css"/s) {
	$HTMLContents=~s/<link (.+?) href="style.css"/<link $1 href="css\/stylesheet.css"/s;
    }

    if ($HTMLContents=~/<link (.+?) href="css\/style.css"/s) {
	$HTMLContents=~s/<link (.+?) href="css\/style.css"/<link $1 href="css\/stylesheet.css"/s;
    }

    if ($HTMLContents=~/<link (.+?) href="stylesheet.css"/s) {
	$HTMLContents=~s/<link (.+?) href="stylesheet.css"/<link $1 href="css\/stylesheet.css"/s;
    }

    ##
    $htmlFileExt=$htmlFile;
    $htmlFileExt=~s/(.+?).(xhtml|html)$/$2/s;

    $htmlFile=~s/.(xhtml|html)$//s;

    # print "($htmlFile)+++($htmlFileExt)\n";

    # ## Write Buffer to File
    open(HTMLOUT,">$tempWorkDir/${htmlFile}-out.$htmlFileExt") || die ("Couldn't create HTMLOUT file");
    print HTMLOUT $HTMLContents;
    close(HTMLOUT);
    system("mv $tempWorkDir/${htmlFile}-out.$htmlFileExt $tempWorkDir/${htmlFile}.$htmlFileExt");
}


##
sub createPacket() {
    ##
    &writeToPopup("Creating packet...");

    ## Adding Files
    system("cd $tempWorkDir && /usr/bin/zip -Xqr \"${fileDir}.epub\" mimetype META-INF $epubType");

    ##
    &validateEPUB();
}


## EXTRACT ZIP
sub extractZip () {
    ##
    &writeToPopup("Extracting archive...");
    
    system("unzip -q -o $inputdir/$filename -d ${tempWorkDir}");
}


sub validateEPUB () {
    my ($epubcheck);

    ##
    if (-e "$tempWorkDir/${fileDir}.epub") {
    } elsif (-e "$inputdir/${fileDir}.zip") {
	system("mv $inputdir/${fileDir}.zip $tempWorkDir/${fileDir}.epub");
    }
    
    ##
    &writeToPopup("validating EPUB...");
    $epubcheck="java -jar \"".$epubCheckJar."\" \"$tempWorkDir/${fileDir}.epub\" >> ${Scriptlog} 2>"."\"$tempWorkDir/${fileDir}.log\"";
    system("$epubcheck");

    ## Print Log
    system("perl $scriptPath/printLog.pl \"$tempWorkDir\" $epubType \"${fileDir}.log\"");

    ## Make Archive
    system("cd $tempWorkDir && /usr/bin/zip -qr \"${fileDir}-epub\" ${fileDir}.epub ${fileDir}.log");
    system("mv $tempWorkDir/${fileDir}.epub $tempWorkDir/${fileDir}-epub.zip $tempWorkDir/${fileDir}.plg ${inputdir} && rm -r ${tempWorkDir} ${inputdir}/${fileDir}.zip");# ${inputdir}/${fileDir}.zip

    ## Transfer to Download
    system("mv ${inputdir}/${fileDir}.epub ${inputdir}/${fileDir}-epub.zip ${inputdir}/${fileDir}.plg ${outputdir}");

    ## Final Message
    print "<script language=\"JavaScript\" type=\"text\/javascript\">newWindow.document.write(\"<br/><br\/><span style='font-family:Calibri;font-size:13px;'><b>The Process has been completed successfully.</b><\/span>\")</script>";

    if (-e "$outputdir/${fileDir}.plg") {
   	# print "<script language=\"JavaScript\">errorWin = window.open(\"'http:\/\/sit6\/publish\/download\/$user\/${fileDir}.plg','','menubar=no,width=500,height=650,toolbar=no,resizable=1,scrollbars=1,top=100,left=200'\")\; errorWin.document.title=\"ePub Log\"\; errorWin.document.bgColor=\"#E0F5FF\";</script>"; ##F2F2F2
   }
}

## WRITE MESSAGES TO POP WINDOW
sub writeToPopup {
    my ($message) = @_;
    print "<script language=\"JavaScript\" type=\"text\/javascript\">newWindow.document.write(\"<br\/><span style='font-family:Calibri;font-size:13px;'>++ $message...<\/span>\")</script>\n";
}

## TYPE MESSAGES TO TERMINAL
sub TYPEOUT {
    my ($typemessage) = @_;
    TTY_TO_LOG("$typemessage");
    #print "\t** $typemessage\n";
}

##
sub TTY_TO_LOG {
    my ($message) = @_;
    open(LOGFILE,">>${Scriptlog}") || die("This file ($Scriptlog) doesn't open!");
    print LOGFILE "$message\n";
    close(LOGFILE);
}

__END__

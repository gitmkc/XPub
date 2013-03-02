#!/usr/bin/perl -w

## Use Pragma for restrictions
use strict;
use File::Copy;
use Roman;

my ($DirName,$subdir,$htmlfile,$configPath);
my (%filesHash,%chapNames,%bookComp,$BackComponents,%alphaNumHash);
my ($xmlLang,$xmlLangVal,$docTitle,$ISBN,$publisher,$contentLabel);
my ($prevCompName,$NCXflag);
$NCXflag=0;

## INITIALIZE
$xmlLang='en';
$docTitle='';
$ISBN='';
$publisher='';
$contentLabel=1;

$prevCompName='';

%alphaNumHash=(1=>'A',2=>'B',3=>'C',4=>'D',5=>'E',6=>'F',7=>'G',8=>'H',9=>'I',10=>'J',11=>'K',12=>'L',13=>'M',14=>'N',15=>'O',16=>'P',17=>'Q',18=>'R',19=>'S',20=>'T',21=>'U',22=>'V',23=>'W',24=>'X',25=>'Y',26=>'Z');

## Check the arguments
if (!$ARGV[0]) {
	print "Wrong Syntax!\n";
	print "******************************\n";
	print "Syntax: gentoc <archive_name>\n";
	print "******************************\n";
	exit(0);
} 

## Get EPUB Dir
$DirName=$ARGV[0];
# &DebugMessage("Dir. Name: $DirName\n");

## Config Path
$configPath="../webapp/scripts/language-config";

print "\nStaring Generating toc.ncx from ($DirName)...\n";

# Open directory
&DebugMessage("Pushing html files into hash");
opendir (DIR,"$DirName") || die "Couldn't open Dir!!!";  
my @currdirfilename = readdir(DIR);
closedir(DIR);

my $count=0;
while($count < @currdirfilename) {
    #my $filenamewithpath = $DirName . "\/" . $currdirfilename[$count];
    my $currfilename="$currdirfilename[$count]";
    if ($currfilename eq "." || $currfilename eq "..") {
	# print "Don't do anything as this is system directory\n";
    } else {
	if ((-e "$DirName/$currfilename") && ($currfilename=~/([A-Za-z0-9\_\-]+).(xhtml|html)$/)) {
	    $filesHash{"$1"}="$currfilename";
	    # print ">>>>>> Filename:=".$currfilename."\n";
	}
    }
    $count++;
}

## Document Title
&getMetadata("$DirName");#/$subdir

if ($xmlLangVal) {
    $xmlLang=$xmlLangVal;
    $xmlLang=~s/([A-Za-z]+)\-([A-Za-z]+)/$1/s;
} else {
    $xmlLangVal="en";
}

# $xmlLang="sw";
## Open Langauage Config and Store component's name
# ## Hash of book's sub component
my (%bookFrontComp,%bookBackComp);
my ($compname,$compVal);
if (-e "$configPath/$xmlLang.config") {
    my ($frontComp,$backComp);
    $frontComp=0;
    $backComp=0;
    #print "File Exist!+$xmlLang.config\n"; 
    &DebugMessage("Reading Langauge config");
    open(CONFIG,"$configPath/$xmlLang.config") || die "Doesn't open '$xmlLang.config'\n";
    while (my $line=<CONFIG>) {
	$line=~s/\s+$//s;
	
	if ($line=~/\[Front Components\]/s) {
	    $frontComp=1;
	}

	if ($line=~/\[Back Components\]/s) {
	    $frontComp=0;
	    $backComp=1;
	}

	if ($frontComp == 1) {
	    if ($line=~/^(.+?)\=(.+?)$/s) {
		$compname=$1;
		$compVal=$2;
		
		$compname=~s/\s+$//s;

		$compVal=~s/^\s+//s;
		$compVal=~s/\s+$//s;
		#print "F++ ($compname)=>($compVal)\n";
		$bookFrontComp{"$xmlLangVal"}{"$compname"}="$compVal";
	    }
	} 

	if ($backComp == 1) {
	    if ($line=~/^(.+?)\=(.+?)$/s) {
		$compname=$1;
		$compVal=$2;

		$compname=~s/\s+$//s;

		$compVal=~s/^\s+//s;
		$compVal=~s/\s+$//s;
		#print "B++ ($compname)=>($compVal)\n";
		$bookBackComp{"$xmlLangVal"}{"$compname"}="$compVal";
	    }
	} 

    }
    close(CONFIG);
}

#exit(0);

## print list of files
my ($chapCount,$itemCount);
my $filecontent='';

&DebugMessage("Adding metadata'");
$filecontent=<<EOF
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE ncx PUBLIC "-//NISO//DTD ncx 2005-1//EN" "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd">
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
<head>
<meta name="dtb:uid" content="$ISBN" />
<meta name="dtb:depth" content="$contentLabel"  />
<meta name="dtb:totalPageCount" content="0" />
<meta name="dtb:maxPageNumber" content="0" />
</head>
<docTitle><text>$docTitle</text></docTitle>
<navMap>
EOF
;

my (@filesequence,$fileseqCount,$tocfileName,$tocfilelink,$fileLabel,$navEntry,$navPointStart,$navPointEnd,$subitem,$labelfound);
my ($fileWithoutExt);
$navEntry='';
$navPointStart=0;
$navPointEnd=0;
$subitem=0;
$labelfound=0;
#$fileseqCount=1;

print "$DirName\n";

open(TOC,">$DirName/toc.ncx") || die ("Couldn't create toc.ncx");
print TOC $filecontent;

## Read toc.xml file
my $tocfile = $DirName."\/..\/"."toc.xml";
if (-e "$tocfile") {
    open(TOCTXT,"$tocfile") || die ("Couldn't open");
    while (my $line=<TOCTXT>) {
	if ($line=~/<item>/) {
	    $navPointStart=1;
	    $labelfound=0;
	    $fileseqCount++;
	    print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
	}

	if ($line=~/<label>(.+?)<\/label>/) {
	    $fileLabel=$1;
	    if ($subitem == 1) {
		$fileseqCount++;
		print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		print TOC "<navLabel><text>$fileLabel<\/text><\/navLabel>";
	    } else {
		if ($labelfound == 1) {
		    $fileseqCount++;
		    print TOC "<\/navPoint>\n<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		    print TOC "<navLabel><text>$fileLabel<\/text><\/navLabel>";
		} else {
		    print TOC "<navLabel><text>$fileLabel<\/text><\/navLabel>";
		}
	    }
	    $labelfound=1;
	}

	if ($line=~/<file>(.+?)<\/file>/) {
	    $tocfileName=$1;

	    if ((-e "$DirName\/$tocfileName") && ($tocfileName=~/\.(xhtml|html)$/s)) {
		if ($subitem == 1) {
		    print TOC "<content src=\"$tocfileName\"\/>\n<\/navPoint>\n";
		} else {
		    print TOC "<content src=\"$tocfileName\"\/>\n";
		}
	    } else {
		if ($subitem == 1) {
		    print TOC "<content src=\"????\"\/>\n<\/navPoint>\n";
		} else {
		    print TOC "<content src=\"????\"\/>\n";
		}
		print "\t** File ($tocfileName) doesn't exist! Please check.\n";
	    }
	}

	if ($line=~/<subitem>/) {
	    $subitem=1;
	}
	
	if ($line=~/<\/subitem>/) {
	    $subitem=0;
	}

	if ($line=~/<\/item>/) {
	    print TOC "<\/navPoint>\n" if ($navPointStart == 1);
	    $navPointStart=0;
	    $subitem=0;
	}
    }
    close(TOCTXT);
    $NCXflag=1;
} elsif ((-e "$DirName\/content.html") || (-e "$DirName\/content.xhtml")) {

    ## Adds Meta Components
    &AddMetaComponent('cover','title','copyright','ded','content');#'intro','prologue'

    ## Get components order
    my (@tocComponent,%navPoint,$compTocName,$nestFlag,$navCount,$partStart);
    $nestFlag=0;
    $navCount=0;
    $partStart=0;
    open(TOCHTML,"$DirName/content.html") || die ("Couldn't open 'content.html' file");
    while (my $line=<TOCHTML>) {##id01
	if ($line=~/<p class="([A-Za-z0-9\_\-]+)"><a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)">(.+?)<\/a>/s) {
	    $tocfileName="$2.$3";
	    $compTocName="$4";
	    $fileWithoutExt=$tocfileName;
	    $fileWithoutExt=~s/\.(xhtml|html)//s;
	    $fileseqCount++;
	    $navCount++;

	    ## Remove Format Tags
	    $compTocName=~s/<i>//g if ($compTocName=~s/<\/i>//g);
	    $compTocName=~s/<b>//g if ($compTocName=~s/<\/b>//g);
	    $compTocName=~s/<em>//g if ($compTocName=~s/<\/em>//g);
	    $compTocName=~s/<small>//g if ($compTocName=~s/<\/small>//g);
	    $compTocName=~s/<strong>//g if ($compTocName=~s/<\/strong>//g);
	    $compTocName=~s/<span class="([A-Za-z0-9\_\-]+)">(.+?)<\/span>/$2/g;

	    #print $tocfileName."\n";

	    ## Close navPoint...
	    if ($nestFlag == 1) {
		print TOC "<\/navPoint>\n";
		$nestFlag=0;
	    } elsif ($prevCompName=~/^part([0-9]+)/) {
		
	    } elsif (($prevCompName ne $tocfileName) && ($navCount > 1)) {
		print TOC "<\/navPoint>\n";
	    }
	    
	    ## Part
	    if ($tocfileName=~/^part([0-9]+)/) {
		if ($partStart == 1) {
		    print TOC "<\/navPoint>\n";
		}
		$partStart=1;
	    }  elsif ((!($tocfileName=~/^(chapter|chap|ch)([0-9]+)/)) && ($partStart == 1)) {
	     	    print TOC "<\/navPoint>\n";
		    $partStart=0;
	    } 
	    
	    ## Insert NavPoint and NavLabel
	    print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
	    print TOC "<navLabel><text>$compTocName<\/text><\/navLabel><content src=\"$tocfileName\"\/>\n";

	    $prevCompName=$tocfileName;
	    $NCXflag=1;
	} elsif ($line=~/<p class="([A-Za-z0-9\_\-]+)"><a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)([#]?[A-Za-z0-9\.\_\-]+)">(.+?)<\/a>/s) {
	    $tocfileName="$2.$3";
	    $tocfilelink="$2.$3$4";
	    $compTocName="$5";
	    #$fileWithoutExt=$tocfileName;
	    #$fileWithoutExt=~s/\.(xhtml|html)//s;
	    $fileseqCount++;

	    ## Remove Format Tags
	    $compTocName=~s/<i>//g if ($compTocName=~s/<\/i>//g);
	    $compTocName=~s/<b>//g if ($compTocName=~s/<\/b>//g);
	    $compTocName=~s/<em>//g if ($compTocName=~s/<\/em>//g);
	    $compTocName=~s/<small>//g if ($compTocName=~s/<\/small>//g);
	    $compTocName=~s/<strong>//g if ($compTocName=~s/<\/strong>//g);
	    $compTocName=~s/<span class="([A-Za-z0-9\_\-]+)">(.+?)<\/span>/$2/g;

	    print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
	    print TOC "<navLabel><text>$compTocName<\/text><\/navLabel><content src=\"$tocfilelink\"\/>\n";
	    print TOC "<\/navPoint>\n";
	    $nestFlag=1;
	    $NCXflag=1;
	} 
    }
    ##Insert Last navPonit
    print TOC "<\/navPoint>" if ($navCount > 1);
    close(TOCHTML);
} elsif (-e "$DirName\/..\/toc.config") {
    #print "Exist: $DirName\/..\/toc.config\n";
    &DebugMessage("Generating NCX from toc.config");

    my ($partStart,$nestFlag,$navCount);
    $partStart=0;
    $nestFlag=0;
    $navCount=0;

    open(tocCONFIG,"$DirName\/..\/toc.config") || die ("Couldn't open 'toc.config' file");
    while (my $line=<tocCONFIG>) {#
	$line=~s/\s+$//s;
	#print $line."\n";
	if ($line=~/^(.+?)\=(.+?)$/s) {
	    $compVal=$1;
	    $compname=$2;
		
	    $compVal=~s/\s+$//s;
	    
	    $compname=~s/^\s+//s;
	    $compname=~s/\s+$//s;

	    if (($compVal ne "") && ($compVal ne "")) {
		$fileseqCount++;
		$navCount++;

		if ($compname=~/^([A-Za-z0-9\_\-]+)\.(xhtml|html)$/) {
		    ## Close navPoint...
		    # print "Name: ($compVal) => ($compname)+[$prevCompName]\n";   
		    #print "$prevCompName+++\n";
		    if ($nestFlag == 1) {
			print TOC "<\/navPoint>\n";
			$nestFlag=0;
		    } elsif ($prevCompName=~/^part([0-9]+)/) {
		    } elsif (($prevCompName ne $compname) && ($navCount > 1)) {#  && ($partStart == 0)
			print TOC "<\/navPoint>\n";
		    }

		    if ($compname=~/^part([0-9]+)/) {
			if ($partStart == 1) {
			    print TOC "<\/navPoint>\n";
			}
			$partStart=1;
		    } elsif ((!($compname=~/^(chapter|chap|ch)([0-9]+)/)) && ($partStart == 1)) {
			print TOC "<\/navPoint>\n";
			$partStart=0;
		    } 
		    
		    print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		    print TOC "<navLabel><text>$compVal<\/text><\/navLabel><content src=\"$compname\"\/>\n";
		    
		    $prevCompName=$compname;
		} elsif ($compname=~/^([A-Za-z0-9\_\-]+)\.(xhtml|html)([#]?[A-Za-z0-9\_\.-]+)$/) {
		    print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		    print TOC "<navLabel><text>$compVal<\/text><\/navLabel><content src=\"$compname\"\/>\n";
		    print TOC "<\/navPoint>\n";
		    $nestFlag=1;
		}
		$NCXflag=1;
	    }
	}
    }

    ##Insert Last navPonit
    print TOC "<\/navPoint>" if ($navCount > 1);
    close(tocCONFIG);
} else {
    print "\t** File toc.xml is not provided in the zip file. It is required to determine file sequence, please include the same and try again!\n";
    $NCXflag=0;
}

## CSS3 Coding
if ($NCXflag == 0) {
    &processCSS3toc;
}

print TOC "<\/navMap>\n<\/ncx>";
close(TOC);

exit(0);

## SUBROUTINES
## Document Title
sub getMetadata {
	my ($fileLocation) = @_;
	
# 	print ">> File Location: $fileLocation\n";
	##

	if (-e "$fileLocation/content.html") {
	    open(CONTENT,"$fileLocation/content.html");
	    while (my $line=<CONTENT>) {
		if ($line=~/<a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)\#([A-Za-z0-9\.\_\-]+)">/s) {#chapter001.html#sec-1
		    if ($contentLabel == 3) {
			$contentLabel=3;
		    } else {
			$contentLabel=2;
		    }
		}

		if ($line=~/<a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)\#([A-Za-z0-9\.\_\-]+)\#([A-Za-z0-9\.\_\-]+)">/s) {#chapter001.html#sec-1
		    $contentLabel=3;
		}
	    }
	    close(CONTENT);
	}	

	&DebugMessage("Getting book title from 'title.html'");
	if (-e "$fileLocation/title.html") {
		open(TITLE,"$fileLocation/title.html");
		while (my $line=<TITLE>) {
			if ($line=~/<title>(.+?)<\/title>/s) {
				$docTitle=$1;
				last;
			}
		}
		close(TITLE);
# 		print "$docTitle\n";		
	} elsif (-e "$fileLocation/cover.html") {
		open(TITLE,"$fileLocation/cover.html");
		while (my $line=<TITLE>) {
			if ($line=~/<title>(.+?)<\/title>/s) {
				$docTitle=$1;
				last;
			}
		}
		close(TITLE);
# 		print "$docTitle\n";		
	} elsif (-e "$fileLocation/title.xhtml") {
		open(TITLE,"$fileLocation/title.xhtml");
		while (my $line=<TITLE>) {
			if ($line=~/<title>(.+?)<\/title>/s) {
				$docTitle=$1;
				last;
			}
		}
		close(TITLE);
		# print "$docTitle\n";
	} else {
		TYPEOUT("No title.html found! Please check.");
	}

	## ISBN
	if (-e "$fileLocation/copyright.html") {
		&DebugMessage("Getting ISBN  from 'copyright.html'");
		open(CPY,"$fileLocation/copyright.html");
		while (my $line=<CPY>) {
		    $line=~s/^\s+//g;
		    $line=~s/[\r|\n]$//g;

		    ## Langauage
		    if ($line=~/xml:lang="([a-zA-Z][a-zA-Z])([\-]?[a-zA-Z]?[a-zA-Z]?)"/) {
			$xmlLangVal="$1$2";
		    }

		    if ($line=~/^<p([A-Za-z0-9\=\s\"]+)>(.+?)Publishing<\/p>$/s) {
			$publisher="${2}Publishing";
		    }
		    
		    $line=~s/<small>ISBN<\/small>/ISBN:/s;
		    $line=~s/<p>ISBN:(.+?)<\/p>$/ISBN:$1/s;
		    $line=~s/<p class="([A-Za-z0-9\_\-]+)">EPUB:(.+?)<\/p>$/ISBN $2/s;
		    $line=~s/<p class="([A-Za-z0-9\_\-]+)">ISBNS<\/p>//s;
		    $line=~s/<p class="([A-Za-z0-9-]+)">ISBN:<\/p>/ISBN:XXXXXXXXXXXXX/s;
		    if ($line=~/ISBN([:]?)(.+?)$/s) {
			$ISBN=$2;
			$ISBN=~s/^\s//s;
			$ISBN=~s/\&\#x002D\;//g;
			$ISBN=~s/([0-9]+)\-/$1/g;
			$ISBN=~s/\Q¡V\E//g;
			$ISBN=~s/\s//g;
			if ($ISBN=~/(\d{13})(.*?)$/) {
			    $ISBN=$1;
			}
			#last;
			}
		}
		close(CPY); 
	}
	#print "$ISBN=$publisher\n";
	
}

## Adds Meta Components
sub AddMetaComponent () {
    my (@compArray) = @_;
    # print $xmlLangVal."\n";
    if (-e "$DirName/../fm.config") {
	
	open(fmConfig,"$DirName/../fm.config") || die ("Couldn't open 'toc.config' file");
	while (my $line=<fmConfig>) {
	    $line=~s/\s+$//s;
	    # print "($line)\n"; 
	    @compArray=split(/, /,$line);
	    #print @compArray;
	    foreach my $item (@compArray) {
		# print $item."   >>>>>>>..\n";
		$item=~s/\.(xhtml|html)$//s;
		if ($filesHash{$item}) {
		    $fileseqCount++;
		    # print $xmlLang.", ".$item.", $filesHash{$item}, $bookFrontComp{\"$xmlLangVal\"}{\"$item\"}\n";
		    
		    print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		    print TOC "<navLabel><text>$bookFrontComp{\"$xmlLangVal\"}{\"$item\"}<\/text><\/navLabel><content src=\"$filesHash{$item}\"\/>\n";
		    print TOC "<\/navPoint>\n";
		}
	    }
	}
	close(fmConfig);
    } else {
	foreach my $item (@compArray) {
	    if ($filesHash{$item}) {
		$fileseqCount++;
		# print $xmlLangVal.", ".$item.", $filesHash{$item}, $bookFrontComp{\"$xmlLangVal\"}{\"$item\"}\n";
		
		print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		print TOC "<navLabel><text>$bookFrontComp{\"$xmlLangVal\"}{\"$item\"}<\/text><\/navLabel><content src=\"$filesHash{$item}\"\/>\n";
		print TOC "<\/navPoint>\n";
	    }
	}
    }
}


##
sub makechapterNames () {
    my ($compName) = @_;

    ##
    if ($bookFrontComp{"$xmlLangVal"}{"$compName"}) {
	$compName=$bookFrontComp{"$xmlLangVal"}{"$compName"};
	return $compName;
    } elsif ($bookBackComp{"$xmlLangVal"}{"$compName"}) {
	$compName=$bookBackComp{"$xmlLangVal"}{"$compName"};
	return $compName;
    } elsif ($compName=~/^ch([0]*)([1-9]+)$/s) {
	return "Chapter $2"; 
    } elsif ($compName=~/^chap([0]*)([1-9]+)$/s) {
	return "Chapter $2"; 
    } elsif ($compName=~/^Chapter([0]*)([1-9]+)$/s) {
	return "Chapter $2"; 
    } elsif ($compName=~/^chapter([0]*)([1-9]+)$/s) {
	return "Chapter $2"; 
    } elsif ($compName=~/^part([0]*)([1-9]+)$/s) {
	return "Part $2"; 
    } else {
	$compName=~s/^([a-z])/\U$1/s;
	return "$compName"; 
    }
}

## Implement CSS3 Navigation
sub processCSS3toc () {
    my ($contents,@ContentArray,$compTocName,$TocCompCount,$listtype,$listStyle,$ListItemNum,$olFlag,$ulFlag);
    my ($listItemFlag,$nestFlag,$navCount);
    $listStyle='';
    $TocCompCount=0;
    $listtype='';
    $olFlag=0;
    $ulFlag=0;
    $navCount=0;
    $nestFlag=0;
    $listItemFlag=0;
    print "++ Creating NCX from CSS3 coding - Listing\n";
    #$fileseqCount=0;
    if ((-e "$DirName\/content.html") || (-e "$DirName\/content.xhtml")) {
	my ($cssContents,$cssStyleName);
	if (-e "$DirName/css/stylesheet.css") {
	    $cssStyleName="$DirName/css/stylesheet.css";
	} elsif (-e "$DirName/stylesheet.css") {
	    $cssStyleName="$DirName/stylesheet.css";
	# } else {
	#     $cssStyleName="$DirName/css/stylesheet.css";
	}

	if ($cssStyleName) {
	    open(CSSFile,"$cssStyleName") || die ("Couldn't open 'stylesheet.css' file");
	    {
		local $/ = undef;
		$cssContents = <CSSFile>;
	    }
	    close(CSSFile);
	
	    # print $cssContents."\n";

	    if ($cssContents=~/div\.toc ol[\n|\r|\s]+\{(.*?)\}/s) {
		my $cssline=$1;
		if ($cssline=~/list-style-type:(lower-alpha|upper-alpha|lower-roman|upper-roman);/s) {
		    $listStyle=$1;
		    # print $1."\n";
		}
	    }
	}

	## Get components order
	my (@tocComponent,%navPoint);
	open(TOCHTML,"$DirName/content.html") || die ("Couldn't open 'content.html' file");
	{
	    local $/ = undef;
	    $contents = <TOCHTML>;
	}
	close(TOCHTML);

	$contents=~s/<a id="page([0-9]+)" \/>//g;
	$contents=~s/<a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)([#]?[A-Za-z0-9\.\_\-]*)([#]?[A-Za-z0-9\.\_\-]*)">[\n|\r]*/<a href="$1.$2$3$4">/g;
	# $contents=~s/\n$/<MUKE>/g;
	$contents=~s/[\n|\r]+//g;
	#$contents=~s/\/>\s*/\/>\n/g;

	$contents=~s/<br \/>/ /g;
	$contents=~s/<br\/>//g;

	$contents=~s/\s+<li>/\n<li>/g;
	$contents=~s/\s+<ul>/\n<ul>/g;
	$contents=~s/\s+<\/ul>/\n<\/ul>/g;
	$contents=~s/<\/ul><\/li>/<\/ul>\n<\/li>/g;
	$contents=~s/<\/li><li>/<\/li>\n<li>/g;
	$contents=~s/<\/ul><ul>/<\/ul>\n<ul>/g;
	$contents=~s/<\/ol><ol>/<\/ol>\n<ol>/g;
	$contents=~s/<\/ul>[\n|\s]*<\/li>/<\/ul>\n<\/li>/g;
	
	## Merge component title with its name (e.g., chapter 1 This is an example of title) 
	$contents=~s/<\/a><\/li>[\n|\s]*<li class="title"><a href="([A-Za-z0-9\_\-]+)\.html">/ /g;#

	$contents=~s/<a id="page([0-9]+)"><\/a>//g;

	# $contents=~s/<\/a>[\n|\s]*<ul>/<\/a>\n<nestStart\/>\n<ul>/g;
	# $contents=~s/<\/ul>[\n|\s]*<\/li>/<\/ul>\n<nestEnd\/>\n<\/li>/g;

	$contents=~s/href="([A-Za-z0-9\_\-]+)\.(xhtml|html)">(.+?)<\/a><\/li>[\n|\s]*<li><a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)\#/href="$1\.$2">$3<\/a>\n<ul>\n<li><a href="$4\.$5\#/g;
	$contents=~s/href="([A-Za-z0-9\_\-]+)\.(xhtml|html)\#([A-Za-z0-9\.\_\-]+)">(.+?)<\/a><\/li>[\n|\s]*<li><a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)">/href="$1\.$2\#$3">$4<\/a><\/li>\n<\/ul>\n<\/li><li><a href="$5\.$6">/g;

	$contents=~s/<\/li><li>/<\/li>\n<li>/g;

	# print "\n".$contents."\n\n\n";
	open(TOCHTML,">$DirName/content-stg1.html") || die ("Couldn't open 'content.html' file");
	print TOCHTML $contents; 
	close(TOCHTML);

	my ($nestStart,$nestEnd);
	$nestStart=0;
	$nestEnd=0;
	$tocfileName='';
	open(TOCHTML,"$DirName/content-stg1.html") || die ("Couldn't open 'content.html' file");
	while (my $line=<TOCHTML>) {
	    ## 
	    #print $line."";

	    if ($line=~/<nestStart\/>/) {
		$nestStart=1;
	    }

	    if ($line=~/<nestEnd\/>/) {
		$nestEnd=1;
	    }

	    if ($line=~/<ul>/) {
		$listtype='UL';
		$ulFlag=1;
	    }
	    ##
	    if ($line=~/<\/ul>/) {
		$ulFlag=0;
		if ($olFlag == 1) {
		    $listtype='OL';
		}
	    }
	    ##
	    if ($line=~/<ol>/) {
		$listtype='OL';
		$olFlag=1;
	    }
	    ##
	    if ($line=~/<\/ol>/) {
		$olFlag=0;
	    }
	    ##

	    if ($line=~/<li>/) {#
		$navCount++;
	    	$fileseqCount++;

		if (($listtype eq "OL") && ($olFlag == 1)) {
		    $TocCompCount++;
		    
		    ## Number Conversion
		    if ($listStyle eq "upper-roman") {
			$ListItemNum=Roman($TocCompCount);
		    } elsif ($listStyle eq "lower-roman") {
			$ListItemNum=roman($TocCompCount);
		    } elsif ($listStyle eq "upper-alpha") {
			$ListItemNum=$alphaNumHash{"$TocCompCount"};
		    } elsif ($listStyle eq "lower-alpha") {
			$ListItemNum=$alphaNumHash{"$TocCompCount"};
			$ListItemNum=lc($ListItemNum);
		    } else {
			$ListItemNum=$TocCompCount;	
		    }
		}

	    	print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		$listItemFlag=0;
	    }
	    
	    #print $line."<<<<<<<<<<<<<<<<\n";
	    if ($line=~/<a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)">(.+?)<\/a>/) {#
	    	$tocfilelink="$1.$2";
	    	$tocfileName="$1.$2";
		$compTocName=$3;
		
		#print $line.">>>>>>>>>>>>>>>>>>>>>>>\n";
	    	$fileWithoutExt=$tocfileName;
	    	$fileWithoutExt=~s/\.(xhtml|html)//s;

		$compTocName=~s/\&nbsp\;//g;
		## Remove Format Tags
		$compTocName=~s/<i>//g if ($compTocName=~s/<\/i>//g);
		$compTocName=~s/<b>//g if ($compTocName=~s/<\/b>//g);
		$compTocName=~s/<em>//g if ($compTocName=~s/<\/em>//g);
		$compTocName=~s/<small>//g if ($compTocName=~s/<\/small>//g);
		$compTocName=~s/<strong>//g if ($compTocName=~s/<\/strong>//g);
		$compTocName=~s/<span class="([A-Za-z0-9\_\-]+)">(.+?)<\/span>/$2/g;

		#if (($prevCompName ne $tocfileName) && ($navCount > 1)) {
		#    print TOC "==<\/navPoint>\n";
		#}

	    	#my $compname=&makechapterNames("$fileWithoutExt");
	    	#print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		if (($listtype eq "OL") && ($olFlag == 1)) {
		    print TOC "<navLabel><text>$ListItemNum $compTocName<\/text><\/navLabel>";
		} else {
		    print TOC "<navLabel><text>$compTocName<\/text><\/navLabel>";
		}
	    	print TOC "<content src=\"$tocfilelink\"\/>\n";

		$prevCompName=$tocfileName;
	    } elsif ($line=~/<a href="([A-Za-z0-9\_\-]+)\.(xhtml|html)([#][A-Za-z0-9\.\_\-]+)">(.+?)<\/a>/) {#
		$tocfileName="$1.$2";
		$tocfilelink="$1.$2$3";
		$compTocName="$4";
		#$fileseqCount++;

		## Remove Format Tags
		$compTocName=~s/<i>//g if ($compTocName=~s/<\/i>//g);
		$compTocName=~s/<b>//g if ($compTocName=~s/<\/b>//g);
		$compTocName=~s/<em>//g if ($compTocName=~s/<\/em>//g);
		$compTocName=~s/<small>//g if ($compTocName=~s/<\/small>//g);
		$compTocName=~s/<strong>//g if ($compTocName=~s/<\/strong>//g);
		$compTocName=~s/<span class="([A-Za-z0-9\-\_]+)">(.+?)<\/span>/$2/g;

		#if ($nestStart == 1) {
		#    $nestStart=0;
		#} else {
		#    print TOC "MM <\/navPoint>\n";
		#}

	    	#print TOC "<navPoint id=\"navpoint-$fileseqCount\" playOrder=\"$fileseqCount\">\n";
		print TOC "<navLabel><text>$compTocName<\/text><\/navLabel>";
	    	print TOC "<content src=\"$tocfilelink\"\/>\n";
		#print TOC "<\/navPoint>\n";
		$nestFlag=1;
	    }
	    
	    if ($line=~/<\/li>/) {
		#if ($line<nestStart\/>)
		#if ($nestEnd == 1) {
		    print TOC "<\/navPoint>\n";  
		#    $nestEnd=0;
		#}
		$listItemFlag=1;
	    }
	}
	#print TOC "<\/navPoint>" if ($navCount > 1);
	close(TOCHTML);
    }

    ## Remove Temp. file
    unlink("$DirName/content-stg1.html");
}


## TYPE MESSAGES TO TERMINAL
sub TYPEOUT {
    my ($typemessage) = @_;
    # print "\t** $typemessage\n";
}

sub DebugMessage {
    my ($typemessage) = @_;
    print " ++ $typemessage\n";
}

__END__

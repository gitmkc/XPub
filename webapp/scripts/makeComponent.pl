#!/usr/bin/perl -w

## Use Pragma for restrictions
use strict;
use File::Copy;

my ($dirName,$fileName,$jobName,$FileExt);
my ($dos2unix);
my (%CompArray);
my ($header,$footer);
my ($xmlLang,$docTitle);

##
$xmlLang="en";
$docTitle="";

if (!$ARGV[0]) {
    print "Missing source directory and filename. Please check.\n";
    exit(0);
} else {
    $dirName=$ARGV[0];
    $fileName=$ARGV[1];
}

## Component Array
%CompArray = ('titlepage' => 'title',
    'copyright' => 'copyright',
    'toc' => 'content',
    'forord' => 'foreword',
    'chapter' => 'chapter',
    'social' => 'social',
    'litteratur' => 'literature',
    'index' => 'index');

##
$FileExt=$fileName;
$FileExt=~s/(.+?).(xhtml|html)$/$2/s;

##
$fileName=~s/.(xhtml|html)$//s;
$jobName=$fileName;

print "DIR: $dirName, F: $fileName.$FileExt, Job N: $jobName\n";

## Buffer
undef $/;

## OPEN FILE FOR READING
open(HTMLFILE,"$dirName/$fileName.$FileExt") || die ("Couldn't open '$fileName'!");
$_=<HTMLFILE>;
close(HTMLFILE);

##
&SplitComponents;

#print $_;

exit(0);


sub SplitComponents () {
    my ($JobDir);
    my ($compName,$compCount,$compData,$xmlwf);
    $JobDir="$dirName/$jobName";
    
    $compCount=0;

    ## Create Job Dir
    $xmlwf="xmlwf $dirName/$fileName.$FileExt > $dirName/$fileName-parse.log 2> $dirName/$fileName-error.log";
    system("$xmlwf");

    if (-s "$dirName/$fileName-parse.log") {
	print "File is not well formed!";
	exit(0);
    } elsif (-s "$dirName/$fileName-error.log") {
	print "Program error!";
	exit(0);
    } else {
	system("rm -r $dirName/$fileName-parse.log $dirName/$fileName-error.log");
    }

    ##
    system("mkdir -p $dirName/$jobName && cp -p $dirName/$fileName.$FileExt $dirName/$jobName");

    ## XML Langauage
    if (/<html (.*?)xml:lang="([A-Za-z\-]+)"(.*?)/) {
	$xmlLang=$2;
    }

    ## Doc Title
    if (/<head>[\n|\s]*<title>(.+?)<\/title>/s) {
	$docTitle=$1;
    }


$header=<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="$xmlLang">
<head>
<title>$docTitle</title>
<link rel="stylesheet" href="css/stylesheet.css" type="text/css" />
<link rel="stylesheet" type="application/vnd.adobe-page-template+xml" href="page-template.xpgt" />
</head>
<body>
EOF
;

$footer=<<EOF
</body>
</html>
EOF
;

    ##
    s/<\/div>[\n|\s]*<div class="(titlepage|copyright|toc|forord|chapter|social|litteratur|index)">/<\/endDiv>\n<startDiv class="$1">/g;

    ##
    s/<\/div>[\n|\s]*<\/body>/<\/endDiv>\n<\/body>/s;

    ## Read all main divs
    while (/<startDiv class="(titlepage|copyright|toc|forord|chapter|social|litteratur|index)">(.+?)<\/endDiv>/s) {
	$compName=$1;
	$compData=$2;

	print "************** $compName **************\n$compData\n__________________________END________________________\n";
	my ($spliFileName,$AltCompName);
	if ($compName eq "chapter") {
	    $compCount++;
	    $AltCompName=$compCount;
	    $AltCompName=$AltCompName<10?"00$AltCompName":"0$AltCompName";
	    $spliFileName=$CompArray{"$compName"};
	    $spliFileName="$spliFileName$AltCompName";
	} else {
	    $spliFileName=$CompArray{"$compName"};
	}
	open(ARTICLE,">$dirName/$jobName/$spliFileName.$FileExt") || die ("Couldn't crearte file '$spliFileName'!");
	print ARTICLE $header;
	print ARTICLE "<div class=\"$compName\">${compData}<\/div>";
	print ARTICLE "\n$footer";
	close(ARTICLE);
	
	s/<startDiv class="(titlepage|copyright|toc|forord|chapter|social|litteratur|index)">(.+?)<\/endDiv>//s;
    }

}

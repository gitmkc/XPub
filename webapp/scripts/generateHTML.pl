#!/usr/bin/perl -w

## Use Pragma for restrictions
use strict;
use File::Copy;

my ($dirName,$fileName);
my ($dos2unix);

if (!$ARGV[0]) {
    print "Missing source directory and filename. Please check.\n";
    exit(0);
} else {
    $dirName=$ARGV[0];
    $fileName=$ARGV[1];
}

# print "\n$dirName++$fileName\n";

## Check Processed File
my $processedFile=`fgrep -e '<?xml version="1.0"' '$dirName\/$fileName'`;
# print "($processedFile)===\n";
if ($processedFile) {
	## Check stylesheet dir
	if ((!(-d "$dirName/css")) && ((-e "$dirName/stylesheet.css"))) {
		system("mkdir $dirName/css && mv $dirName/stylesheet.css $dirName/css/stylesheet.css");
	}
    exit(0);
}

## Date and Time
my ($dirNamebyTime);
my @month_abbr = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year+=1900;

# print "$sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst\n";
$mon=$mon+1;
$mon=$mon<10?"0$mon":$mon;
$mday=$mday<10?"0$mday":$mday;
$dirNamebyTime="$year$mon$mday";

# print "++++$dirName + $fileName\n";

$fileName=~s/\.html$//s;

## Perform DOS2UNIX
$dos2unix="/usr/bin/dos2unix -ascii -437 \"$dirName/$fileName.html\" \"$dirName/$fileName.html\" && /usr/bin/tr \"\r\" \"\n\" < \"$dirName/$fileName.html\" > \"$dirName/${fileName}tmp.html\" && mv \"$dirName/${fileName}tmp.html\" \"$dirName/${fileName}.html\"";
system("$dos2unix");

##
my ($listStart,$listEnd);
$listStart=0;
$listEnd=0;
open(FILE,"<$dirName/$fileName.html") || die ("Couldn't open file");
open(TMPFILE,">$dirName/${fileName}tmp.html") || die ("Couldn't open file");
while (<FILE>) {
    if (s/>([ ]*)\n/>$1&LBRK;/o) {
    } else {
	s/^\n//g;
	s/\n$/<REMOVEBREAK\/>/g;
    }
    
    s/\&LBRK\;/\n/g;

    if (/<p class=ListStart>\&nbsp\;<\/p>/s) {
	if ($listStart == 1) {
	    s/<p class=ListStart>\&nbsp\;<\/p>/<ul>/s;
	    $listEnd=0;
	} else {
	    s/<p class=ListStart>\&nbsp\;<\/p>/<ol>/s;
	}
	$listStart=1;
    }


    if (/<p class=ListEnd>\&nbsp\;<\/p>/s) {
	if ($listEnd == 0 && $listStart == 1) {
	    s/<p class=ListEnd>\&nbsp\;<\/p>/<\/ul>/s;
	    $listEnd=1;
	} else {
	    s/<p class=ListEnd>\&nbsp\;<\/p>/<\/ol>/s;
	}
	$listEnd=1;
    }

    print TMPFILE $_;
}
close(TMPFILE);
close(FILE);


undef $/;

## READ FILE
open(FILE,"<$dirName/${fileName}tmp.html") || die ("Couldn't open file");
$_=<FILE>;
close(FILE);

##
&CreateCSS;

##
&NORMALIZE;

##
&Floats;

my $headerData=<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
EOF
;

## READ FILE
open(OUTFILE,">$dirName/${fileName}-out.html") || die ("Couldn't open file");
print OUTFILE $headerData;
print OUTFILE $_;
close(OUTFILE);

## MOVE AND CREATE DIR
if (-e "$dirName/${fileName}-out.html") {
    #system("mkdir -p $dirName/published-$dirNamebyTime && mv $dirName/${fileName}-out.html $dirName/published-$dirNamebyTime/${fileName}.html");
    system("cp -p $dirName/${fileName}-out.html $dirName/${fileName}.html");
    unlink("$dirName/${fileName}tmp.html");
    unlink("$dirName/${fileName}-out.html");
}

exit(0);

## Normalizes the HTML
sub NORMALIZE () {
    my ($blockquoteData);

    ##
    s/<REMOVEBREAK\/>/ /g;

    ##
    s/[\n]+<([\/]?)([A-Za-z]+)>/\n<$1$2>/g;
    s/[\n]+<([A-Za-z]+) /\n<$1 /g;

    ## Entities
    s/\&amp\;#x([A-Z0-9]+)\;/&#x$1;/g;
    
    ##
    s/<html>/<html xmlns="http:\/\/www.w3.org\/1999\/xhtml">/s;
    s/<head>/<head>\n<title><\/title>\n<link href="style.css" rel="stylesheet" type="text\/css"\/>\n<link rel="stylesheet" type="application\/vnd.adobe-page-template\+xml" href="page-template.xpgt"\/>/s;
    s/<body ([A-Za-z0-9\-:\=\'\s\"]+)>/<body>/s;
    s/class=([A-Za-z0-9-]+)>/class="$1">/g;

    ##
    #s/[\n]*<meta http-equiv=Content-Type content="text\/html; charset=(.+?)">//s;
    s/[\n]*<meta name=Generator content="(.+?)">//g;
    s/[\n]*<base target="\_self">//s;

    ##
    s/[\n]*<p class="MsoNormal">\&nbsp\;<\/p>//g;

    ##
    s/<\/h([0-9]+)>[\n]*<p class="para">/<\/h$1>\n<p class="noindent">/g;

    ## Headings
    s/<h1>(.+?)<\/h1>/<p class="h1">$1<\/p>/g;
    s/<h2>(.+?)<\/h2>/<p class="h2">$1<\/p>/g;
    s/<h3>(.+?)<\/h3>/<p class="h3">$1<\/p>/g;
    s/<h4>(.+?)<\/h4>/<p class="h4">$1<\/p>/g;
    s/<h5>(.+?)<\/h5>/<p class="h5">$1<\/p>/g;
    s/<h6>(.+?)<\/h6>/<p class="h6">$1<\/p>/g;

    ## Block Quote
    while (/<p class="blockquote">(.+?)<\/p>/s) {
	$blockquoteData=$1;
	s/<p class="blockquote">(.+?)<\/p>/<blockquote>\n<p class="noindent">$blockquoteData<\/p>\n<\/blockquote>/s;
    }

    ## Listings
    # s/<p class="ListStart">\&nbsp\;<\/p>/<HTMLli>/g;
    # s/<p class="ListEnd">\&nbsp\;<\/p>/<\/HTMLli>/g;

    # ##
    # my ($listData);
    # while (/<HTMLli>(.+?)<\/HTMLli>/s) {
    # 	$listData=$1;
    # 	s/<HTMLli>(.+?)<\/HTMLli>/<li>$listData<\/li>/s;
    # }

    s/<p class="MsoListParagraph">(.+?)<\/p>/<li>$1<\/li>/g;

    s/[\n]*<p class="tablestart">\&nbsp\;<\/p>//g;
    s/[\n]*<p class="tableend">\&nbsp\;<\/p>//g;
} 

##
sub CreateCSS {
    my ($cssStyle);
    if (/<style>(.+?)<\/style>/s) {
	$cssStyle=$1;
	$cssStyle=~s/^[\n]*//s;
	$cssStyle=~s/[\n]*$//s;
	$cssStyle=~s/^<\!--//s;
	$cssStyle=~s/\-->$//s;
	$cssStyle=~s/<REMOVEBREAK\/>/\n/g;
	#print $cssStyle;
	$cssStyle=~s/h([0-9]+)[\n\s]+\{/\n\.h$1 \{/g;

	open(CSS,">$dirName/style.css") || die ("Couldn't create CSS file");
	print CSS $cssStyle; 
	close(CSS);
	s/<style>(.+?)<\/style>//s;
    }
}

## 
sub Floats () {
    my ($tdData);
    #width=367 valign=top style='width:275.4pt;border:solid black 1.0pt;   padding:0in 5.4pt 0in 5.4pt'
    while (/<td([A-Za-z0-9-\'\"\+\;\:\=\.\s]*)>(.+?)<\/td>/s) {
	$tdData=$2;
	$tdData=~s/[\n ]*<p class="([A-Za-z0-9\-]+)">(.+?)<\/p>[\n ]*/$2/s;
	s/<td([A-Za-z0-9-\'\"\+\;\:\=\.\s]*)>(.+?)<\/td>/<Xtd>$tdData<\/Xtd>/s;
    }
    s/<Xtd>/<td>/g;
    s/<\/Xtd>/<\/td>/g;
}


__END__

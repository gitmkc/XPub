#!/usr/bin/perl -w
use strict;
use HTML::Entities;

# Set Lib Path
BEGIN {
    push @INC,"../webapp/scripts";
}

use mainFunction;

## binmode to see utf on stdout
#binmode(STDOUT, ':utf8');

## Create Object reference
our $pkg = eval { new mainFunction(); } or die ("Error: ".$@);

##
$pkg->LoadEntityDatabase("/var/www/SunXpublish/webapp/scripts","unicode.xml");

### example to pick up entity
## print $pkg->{entityHash}{'decimalToUnicode'}{'47'}."\n";
## print $pkg->{entityHash}{'unicodeToDecimal'}{'0002B'}."\n";
## print $pkg->{entityHash}{'unicodeToISO'}{"0002B"}."\n";
## print $pkg->{entityHash}{'IsoToUnicode'}{"plus"}."\n";

#exit(0);


# HTML Normalization
my ($filePath,$inputfile,$outputfile);
my ($targetFilePath);
my ($dos2unix,$entityType,$xmllang,$inserted_metatag,$entLength);

##
$entLength = 0;
$entityType = "utf8";
$xmllang = "en";

$filePath = $ARGV[0];
$inputfile = $ARGV[1];

$inputfile=~s/\.html$//s;
$inputfile=~s/\-stg2$//s;

system("cp -p $filePath/$inputfile-stg2.html $filePath/$inputfile-stg3.html");

#print "File Path: $filePath && INPUT File: $inputfile\n";

## 
open (XMLINFO,"$filePath/xmlinfo.txt") || die ("Couldn't open file");
while (my $line=<XMLINFO>) {
    if ($line=~/^unicode: ([0-9]+)$/) {
	$entLength = $1;
	$entityType="unicode";
    }
    
    if ($line=~/^iso$/) {
	$entityType="iso";
    }

    if ($line=~/^xmllang\: ([A-Za-z\-]+)$/) {
	$xmllang="$1";
    }

    if ($line=~/^metatag$/) {
	$inserted_metatag="metatag";
    }
}
close(XMLINFO);


## Perform DOS2UNIX
$dos2unix="/usr/bin/dos2unix -ascii \"$filePath/${inputfile}-stg2.html\" \"$filePath/${inputfile}-stg2.html\" && /usr/bin/tr \"\r\" \"\n\" < \"$filePath/${inputfile}-stg2.html\" > \"$filePath/${inputfile}tmp-stg2.html\" && mv \"$filePath/${inputfile}tmp-stg2.html\" \"$filePath/${inputfile}-stg2.html\"";
system("$dos2unix");

##
undef $/;
open (INFILE,"$filePath/${inputfile}-stg2.html") || die ("couldn't open file");
$_=<INFILE>;
close(INFILE);

##
while (/\&\#([0-9]+)\;/s) {
    my $html_ent = "$1";
    #$charcount++;
    #print "Converting...$charcount\n";
	if ($entityType eq "unicode" || $entityType eq "iso") {
		s/\&\#$html_ent\;/\&\#x$pkg->{entityHash}{'decimalToUnicode'}{"$html_ent"}\;/s;
		if ($entLength == 4 && $entityType eq "unicode") {
			s/\&\#x0([A-Za-z0-9]+)\;/\&\#X_$1\;/s;
		}
	} else {
		#$pkg->{entityHash}{'decimalToUnicode'}{'47'}
		$html_ent = "&#$html_ent;";
		my $utfchar = decode_entities($html_ent);
		s/$html_ent/$utfchar/s;
	}
}
s/\&\#X\_/\&\#x/g;

#UTF to Unicode;
#if ($entityType eq "unicode") {
#    &TransformCharacters;
#}

## Replace Unicode to ISO
## $entityType='iso'; # for entity conversion testing 
if ($entityType eq "iso") {
    &replaceEntity("unicodeToISO");
}

## Normalize Text
&normalizeText;

#print $_;

## Write buffer to output file
open (OUTFILE,">$filePath/${inputfile}-final.html") || die ("couldn't open file");
print OUTFILE $_."\n<\/body>\n<\/html>";
close(OUTFILE);

## Publish File
$targetFilePath=$filePath;
$targetFilePath=~s/\.\.\/unpublished\///s;

#print $targetFilePath."\n";

# system("mkdir -p \"../published/$targetFilePath\" && mv \"$filePath/${inputfile}-final.html\" \"../published/jobs/$targetFilePath/${inputfile}.html\"");
system("mv \"$filePath/${inputfile}-final.html\" \"$filePath/${inputfile}.html\"");

unlink("$filePath/${inputfile}-stg1.html");
unlink("$filePath/${inputfile}-stg2.html");

exit(0);

##
sub TransformCharacters {
    DebugMessage("TransformCharacters...");
    ## this function will convert utf 8 character set to unicode character set
    s/([\xC0-\xDF][\x80-\xFF])/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\xE0-\xEF][\x80-\xFF]{2})/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\xF0-\xF7][\x80-\xFF]{3})/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\xF8-\xFB][\x80-\xFF]{4})/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\xFC-\xFD][\x80-\xFF]{5})/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\x00-\x7f][\x80-\xbf]{5})/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\xc0-\xdf][\x00-\x7f\xc0-\xff]{5})/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\xc0-\xc1][\x80-\xbf]{2})/'&#'.(&UTF8Decode($1)).';'/ge;
    s/([\xfc-\xfd][\x80-\xbf]{0,4}[\x00-\x7f\xc0-\xff])/'&#'.(&UTF8Decode($1)).';'/ge;
    
    my $char_apos = "\x{00027}";
    my $decval = ord $char_apos;
    
    ## The below code truncates unicode entity exactly to five digit after "#" excluding ";"
    s/$char_apos/sprintf("&#x%.4x;", $decval)/ge;

    ##
    s/\&\#X/\&#x/g;
}

## UTF8
sub UTF8Decode {
    # UTF 8 Decoder
    DebugMessage("UTF 8 Decoder...$_[0]");
    my ( $chars ) = $_[0];
    my $factor = 1;
    my $charval;
    my $char;
    
    my @GLOBAL_NUM_ARRAY = ( 128+64, 128+64+32, 128+64+32+16, 128+64+32+16+8, 128+64+32+16+8+4 );
    
    my $slen = length( $_[0] );
    while ( $char = chop( $chars ) ) {
	if ( length( $chars ) ) {
	    $charval += ( ord( $char ) - 128 ) * $factor;
	    $factor *= 64;
	}
    }
 
    ## Now do the first character
    $_[0] =~ /^(.)/s;
    $charval += ( ord( $1 ) - $GLOBAL_NUM_ARRAY[$slen-2] ) * $factor;
    
    
    ## The below code truncates unicode entity exactly to five digit after "#" excluding ";"
    $charval = sprintf("x%.4x", $charval);

    return uc($charval);
}

##
sub replaceEntity () {
    my ($entType) = @_;
    my ($entCode);

    if ($entType eq "unicodeToISO") {
	while (/\&\#x([A-Z0-9]+)\;/s) {
	    $entCode=$1;

	    #print "-> $entCode, $pkg->{entityHash}{$entType}{\"0$entCode\"}+\n";

	    if (length($entCode) < 5) {
		s/\&\#x$entCode\;/\&$pkg->{entityHash}{$entType}{"0$entCode"}\;/g;
	    } else {
		s/\&\#x$entCode\;/\&$pkg->{entityHash}{$entType}{"$entCode"}\;/g;
	    }
	}
    } elsif ($entType eq "IsoToUnicode") {
	while (/\&([A-Za-z]+)\;/s) {
	    $entCode=$1;
	    s/\&$entCode\;/\&\#x$pkg->{entityHash}{"$entType"}{"$entCode"};/g;
	}
    }
}


##
sub normalizeText() {
    my ($headercontent,$stylesheet,$DocTitle,$metatag);
    DebugMessage("Normalizing HTML tags...");

    $stylesheet='';
    $metatag='';

    ## Remove blank lines
    s/[\n]+/\n/g;

    ## Get Title
    if (/<title>(.*?)<\/title>/s) {
    	s/[\n ]*<title>(.*?)<\/title>//s;
    	$DocTitle="<title>$1<\/title>";
    }

    ## Get Link1
    if (/<link href="([A-Za-z]+).css" rel="stylesheet" type="text\/css" \/>/) {
    	s/[\n ]*<link href="([A-Za-z]+).css" rel="stylesheet" type="text\/css" \/>//s;
    	$stylesheet=qq(<link href="$1.css" rel="stylesheet" type="text\/css"\/>);
    }

    ## Get Link1
    if (/<link rel="stylesheet" href="css\/([A-Za-z]+).css" type="text\/css" \/>/) {
    	my $cssFileName=$1;
    	s/[\n ]*<link rel="stylesheet" href="css\/([A-Za-z]+).css" type="text\/css" \/>//s;
    	$stylesheet=qq(<link rel="stylesheet" href="css\/$cssFileName.css" type="text\/css"\/>);
    }

    ## Get Link1
    if (/<link rel="stylesheet" type="text\/css" href="([A-Za-z]+).css" \/>/) {
    	my $cssFileName=$1;
    	s/[\n ]*<link rel="stylesheet" type="text\/css" href="([A-Za-z]+).css" \/>//s;
    	$stylesheet=qq(<link rel="stylesheet" href="$cssFileName.css" type="text\/css"\/>);
    }

    ## Get Link1
    if (/<link rel="stylesheet" type="text\/css" href="css\/([A-Za-z]+).css" \/>/) {
    	my $cssFileName=$1;
    	s/[\n ]*<link rel="stylesheet" type="text\/css" href="css\/([A-Za-z]+).css" \/>//s;
    	$stylesheet=qq(<link rel="stylesheet" type="text\/css" href="css\/$cssFileName.css"\/>);
    }

    ## Get Link1
    if (/<link rel="stylesheet" type="application\/vnd.adobe-page-template\+xml" href="page-template.xpgt" \/>/) {
    	s/[\n ]*<link rel="stylesheet" type="application\/vnd.adobe-page-template\+xml" href="page-template.xpgt" \/>//s;
    	$stylesheet="$stylesheet\n"."<link rel=\"stylesheet\" type=\"application\/vnd.adobe-page-template\+xml\" href=\"page-template.xpgt\"\/>";
    }

    ## meta
    if (/<meta http-equiv="content-type" content="text\/html\;charset=([A-Za-z0-9\-]+)"([\s]*)\/>/) {
    	$metatag=$1;
    	s/[\n ]*<meta http-equiv="content-type" content="text\/html\;charset=([A-Za-z0-9\-]+)"([\s]*)\/>//s;
    	$metatag="<meta http-equiv=\"content-type\" content=\"text\/html\;charset=$metatag\" \/>";
    } elsif (/<meta http-equiv="Content-Type" content="text\/html\;charset=([A-Za-z0-9\-]+)"([\s]*)\/>/) {
    	$metatag=$1;
    	s/[\n ]*<meta http-equiv="Content-Type" content="text\/html\;charset=([A-Za-z0-9\-]+)"([\s]*)\/>//s;
    	$metatag="<meta http-equiv=\"Content-Type\" content=\"text\/html\;charset=$metatag\" \/>";
    }

    ## Remove meta tag
    if ($inserted_metatag) {
	$metatag="";
    }

    ## Remove blank tags
    s/<strong>[\n ]*<\/strong>//g;

    ## Print Headers
    $headercontent=<<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xml:lang="$xmllang" xmlns="http://www.w3.org/1999/xhtml">
<head>
$DocTitle
$stylesheet
$metatag
</head>
<body>
EOF
;

    $headercontent=~s/\n$//s;
    s/<!--\?xml version="1.0" encoding="UTF-8"\?-->/<\?xml version="1.0" encoding="UTF-8"?>\n$headercontent/s;
    s/<!--\?xml version="1.0" encoding="utf-8"\?-->/<\?xml version="1.0" encoding="utf-8"?>\n$headercontent/s;

    ## Tags
    s/<em>/<i>/g;
    s/<\/em>/<\/i>/g;
    s/<strong>/<b>/g;
    s/<\/strong>/<\/b>/g;
    
    ## Put entites inside tags
    # s/<\/([a-zA-Z]+)>\&\#([A-Za-z0-9]+)\;<([a-zA-Z]+)>/\&\#$2\;/g;
    
    ##
    s/<\/p>[\n ]*<p>&nbsp;<\/p>[\n ]*<p /<\/p>\n<p /g; 
    s/<a id="page([0-9]+)">[\n]*<\/a>/<a id="page$1"\/>/g;
    s/<p class="([A-Za-z0-9-]+)">[\n]+<\/p>/<p class="$1" \/>/g;

    ##
    s/\&nbsp\;/\&\#x00A0\;/g;
    
    ##
    s/<span id="HtmlHyphenEntity"><\/span>-/&#x002D;/g;
    s/<span id="HtmlHyphenEntity"><\/span>//g;
    s/<span style="font-variant:small-caps;">(.+?)<\/span>/<small>$1<\/small>/g;

    s/<span id="U+([A-Za-z0-9]+)"><\/span>\@/&#x$1;/g;
    s/<span id="U+([A-Za-z0-9]+)"><\/span>//g;

    s/<a id="([A-Za-z0-9]+)">([A-Za-z0-9]+)<\/a>/<a id="$1" \/>/g;
    
    ##
    my ($pArgA,$pArgB);
    while (/<p class="([A-Za-z0-9]+)">([A-Za-z0-9]+)<\/p>/s) {
	$pArgA=$1;
	$pArgB=$2;
	if ("$pArgA" eq "$pArgB") {
	    s/<p class="([A-Za-z0-9]+)">([A-Za-z0-9]+)<\/p>/<p class="$1" \/>/g;
	} else {
	    s/<p class="([A-Za-z0-9]+)">([A-Za-z0-9]+)<\/p>/<HTmlp class="$1">$2<\/HTmlp>/g;
	}
	undef($pArgA);
	undef($pArgB);
    }
    s/<HTmlp /<p /g;
    s/<\/HTmlp>/<\/p>/g;

    ## Headings Div
    s/<\/div>[\n]*/<\/div>\n/g;

    s/<div>(.+?)<\/div>[\n]+/<p class="noindent">$1<\/p>\n/g;

    s/[\n]*<\/body>/\n<\/body>/s;

    ## Entities
    s/\&\#x00A0\;/&nbsp;/g;
    s/\&amp\;/&#x0026;/g;
    s/\&euro\;/&#x20AC;/g;

}

sub DebugMessage {
    my ($typemessage) = @_;
    print " ++ $typemessage\n";
}

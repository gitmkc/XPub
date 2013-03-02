#!/usr/bin/perl -w

use strict;
use File::Basename;

my ($inputfile,$outputfile,$filepath);
$inputfile=$ARGV[0];
$outputfile=$ARGV[1];

## 
$filepath=dirname $inputfile;

# print "$filepath++$inputfile++$outputfile\n";
#exit(0);

undef $/;
open (INFILE,"$inputfile") || die ("couldn't open file to read");
$_=<INFILE>;
close(INFILE);

## Add space in Ligature for PDF QA - When we copy text from pdf then it contains spaces in ligatures.
## Case 1 - fl
s/([A-Za-z])fl([A-Za-z])/${1}f l$2/g;
s/ Fl([A-Za-z])/F l$1/g;
s/([A-Za-z])fl /${1}f l /g;

## Case 2 - fi
s/([A-Za-z])fi([A-Za-z])/${1}f i$2/g;
s/ Fi([A-Za-z])/F i$1/g;
s/([A-Za-z])fi /${1}f i /g;

## Case 3 - ff
s/([A-Za-z])ff([A-Za-z])/${1}f f$2/g;
s/ Ff([A-Za-z])/F f$1/g;
s/([A-Za-z])ff /${1}f f /g;

## modify tags
s/\&\#x002D\;/<span id="HtmlHyphenEntity"><\/span>\&\#x002D\;/g;

s/<a id="([A-Za-z0-9]+)" \/>/<a id="$1">$1<\/a>/g;
s/<p class="([A-Za-z0-9]+)" \/>/<p class="$1">$1<\/p>/g;

## Quotes inside <span> tag
while (/<span style='(.+?)'>/s) {
    my $spanText=$1;
    $spanText=~s/\"//g;
    s/<span style='(.+?)'>/<HTMLspan Style="$spanText">/g;
}
s/<HTMLspan Style="(.+?)">/<span style="$1">/g;

#print "Modify HTML";

## find entity type
if (/\&\#x([0-9A-Z]+)\;/) {
    open(XMLINFO,">$filepath/xmlinfo.txt") || die ("Couldn't create xmlinfo file!");
    print XMLINFO "unicode\n";
    close(XMLINFO);
} elsif (/\&([a-z]+)\;/) {
    open(XMLINFO,">$filepath/xmlinfo.txt") || die ("Couldn't create xmlinfo file!");
    print XMLINFO "iso\n";
    close(XMLINFO);
} else {
    open(XMLINFO,">$filepath/xmlinfo.txt") || die ("Couldn't create xmlinfo file!");
    print XMLINFO "utf8\n";
    close(XMLINFO);
}

##
my ($xmllang);
if (/xml:lang="([A-Za-z\-]+)"/) {
    $xmllang=$1;
    open(XMLINFO,">>$filepath/xmlinfo.txt") || die ("Couldn't create xmlinfo file!");
    print XMLINFO "xmllang: $xmllang\n";
    close(XMLINFO);
}


## Write buffer to output file
open (OUTFILE,">$outputfile") || die ("couldn't open file to write");
print OUTFILE $_;
close(OUTFILE);

exit(0);

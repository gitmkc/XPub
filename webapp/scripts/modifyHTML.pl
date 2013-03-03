#!/usr/bin/perl -w

use strict;
use File::Basename;

## main variables - inputfile and outputfile
my ($inputfile,$outputfile,$filepath);
$inputfile=$ARGV[0];
$outputfile=$ARGV[1];

## get filepath
$filepath=dirname $inputfile;

undef $/;
open (INFILE,"$inputfile") || die ("couldn't open file to read");
$_=<INFILE>;
close(INFILE);

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

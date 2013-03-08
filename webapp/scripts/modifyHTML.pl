#!/usr/bin/perl -w

use strict;
use File::Basename;

my ($inputfile,$outputfile,$filepath);
my ($metatag,$charset);
##
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
	my $entLength = length($1);
    $charset = "utf-8";
    open(XMLINFO,">$filepath/xmlinfo.txt") || die ("Couldn't create xmlinfo file!");
    print XMLINFO "unicode: $entLength\n";
    close(XMLINFO);
} elsif (/\&([a-z]+)\;/) {
    $charset = "iso-8859-1";
    open(XMLINFO,">$filepath/xmlinfo.txt") || die ("Couldn't create xmlinfo file!");
    print XMLINFO "iso\n";
    close(XMLINFO);
} else {
    $charset = "utf-8";
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

## meta
if (!(/<meta http-equiv="content-type" content="text\/html\;charset=(utf-8|iso-8859-1|UTF-8|ISO-8859-1)"([\s]*)\/>/s)) {
    $metatag=$1;
    $metatag="<meta http-equiv=\"content-type\" content=\"text\/html\;charset=iso-8859-1\" \/>";
} 

if (!$metatag) {
    if (!(/<meta http-equiv="Content-Type" content="text\/html\;charset=(utf-8|iso-8859-1|UTF-8|ISO-8859-1)"([\s]*)\/>/)) {
	$metatag=$1;
	$metatag="<meta http-equiv=\"Content-Type\" content=\"text\/html\;charset=iso-8859-1\" \/>";
    }
}

## Insert meta tag
if ($metatag) {
    s/<\/head>/${metatag}\n<\/head>/s;
    open(XMLINFO,">>$filepath/xmlinfo.txt") || die ("Couldn't create xmlinfo file!");
    print XMLINFO "metatag\n";
    close(XMLINFO);
}

## Write buffer to output file
open (OUTFILE,">$outputfile") || die ("couldn't open file to write");
print OUTFILE $_;
close(OUTFILE);

exit(0);

#!/usr/bin/perl -w

use strict;

## Main variables
my ($filepath,$fileName);
my ($fileExt,$searchStr,$replaceStr);
$fileName = $ARGV[0];
$searchStr = $ARGV[1];
$replaceStr = $ARGV[2];

##print "$fileName** $searchStr** $replaceStr**\n";

#
$fileExt = $fileName;
$fileExt =~ s/^(.+?)\.(xhtml|html)$/$2/s;
$fileName =~ s/\.html$//s;

## back up copy of original
system("cp -p $fileName.$fileExt $fileName.$fileExt.bak");

## Open file in buffer
undef $/;
open (INFILE,"<$fileName.$fileExt") || die ("couldn't open file to read");
$_=<INFILE>;
close(INFILE);

## Parse search and replace string and normalize

## Do search and replace
s/\Q$searchStr\E/$replaceStr/g;

## Write buffer to output file
open (OUTFILE,">${fileName}.$fileExt") || die ("couldn't open file to write");
print OUTFILE $_;
close(OUTFILE);

##
unlink("${fileName}.$fileExt.bak");

exit(0);

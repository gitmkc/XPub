#!/usr/bin/perl -w

## Use Pragma for restrictions
use strict;
use File::Copy;

my ($inputdir,$epubType,$logfile);

## Check the arguments
if (!$ARGV[0]) {
	print "Wrong Syntax!\n";
	print "******************************\n";
	print "Syntax: printLog.pl <input_dir> <filename>.log\n";
	print "******************************\n";
	exit(0);
} 

$inputdir=$ARGV[0];
$epubType=$ARGV[1];
$logfile=$ARGV[2];

$logfile=~s/.log$//s;

#print "$inputdir++$logfile\n";

##
my (@logWarray,@logEarray,$linecount,$logHeader,$errCount);
$linecount=0;

$logHeader=<<EOF
This is EpubCheck 3.0, Tool to validate IDPF EPUB files.
Copyright Suntec India 2012, Powered by Technoscore.
EOF
;

open(LOG,"<${inputdir}/${logfile}.log") || die ("Couldn't open file");
open(LOGOUT,">${inputdir}/${logfile}-val.log") || die ("Couldn't open file");

##
print LOGOUT $logHeader;

while (my $line=<LOG>) {
    if ($line=~/^WARNING: (.+?)$/) {
	my $warnText=$1;
	$warnText=~s/^..\/published\/upload\/(.+?): //s; 
	# print "++ WARNING:".$warnText."\n";
	push(@logWarray,"\nWarning: $warnText.");
    } elsif ($line=~/^ERROR: (.+?)$/) {
	$linecount++;
	my $errText=$1;
	#../published/upload/spx/.9789173892551temp/9789173892551.epub/OEBPS/chapter003.html(248,721)
	if ($errText=~/^..\/published\/upload\/(.+?)\/([A-Za-z0-9-\_]+)\.(xhtml|html)\(([0-9]+),([0-9]+)\): /s) {
	    $errText=~s/^..\/published\/upload\/(.+?)\/([A-Za-z0-9-\_]+)\.(xhtml|html)\(([0-9]+),([0-9]+)\): //s;
	    push(@logEarray,"\n++ LINE:$4, Col:$5 [$2\.$3]: $errText");
	} else {
	    if ($errText=~/^..\/published\/upload\/(.+?)\/([A-Za-z0-9-\.\_]+): /s) {
		$errText=~s/^..\/published\/upload\/(.+?)\/([A-Za-z0-9-\.\_]+): //s;
		push(@logEarray,"\n++ File [$2]: $errText");
	    }
	}
    }
}
#

if ($#logWarray > -1) {
    print LOGOUT "\nWarning Summary:\n";
    print LOGOUT @logWarray;
    print LOGOUT "\n";
}

#
if (-s "$inputdir/$epubType/NAV.log") {
    my $navLog = `cat $inputdir/NAV.log`;
    $linecount++;
    push(@logEarray,"\n$navLog");
}

if (-s "$inputdir/$epubType/OPF.log") {
    my $opfLog = `cat $inputdir/OPF.log`;
    $linecount++;
    push(@logEarray,"\n$opfLog");
}

print LOGOUT "\nError Summary:\n";
print LOGOUT @logEarray;


if ($linecount == 0) {
    if ($#logWarray > -1) {
	$errCount="\n\nThere were $#logWarray warning.";
    } else {
	$errCount="\n\nNo error found";
    }   
} elsif ($linecount == 1) {
    $errCount="\n\nThere was one error.";
} else {
    $errCount="\n\nThere were $linecount error.";
}

##
my $logFooter=<<EOF
$errCount
(For more information, see transcript file $logfile.log)
EOF
;

print LOGOUT $logFooter;
#
close(LOGOUT);
close(LOG);

system("mv $inputdir/${logfile}-val.log $inputdir/${logfile}.plg && cp -p $inputdir/${logfile}.plg $inputdir/${logfile}.log");

exit(0);


__END__

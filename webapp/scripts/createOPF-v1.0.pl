#!/usr/bin/perl -w

## Use Pragma for restrictions
use strict;
use File::Copy;

my ($DirName,$epubType,$subdir,$filename);
my (%filesHash,%chapNames,%bookComp,$tocFile);
my ($xmlLang,$xmlLangVal,$docTitle,$docCreator,$ISBN,$publisher);
my (%includedFile);
my ($manItemCount,$manFileArray);

## INITIALIZE
$xmlLangVal='en';
$docTitle='';
$docCreator='';
$ISBN='';
$publisher='';

$manItemCount=0;

## Hash of book's sub component
%bookComp = ('cover' => 'Cover Page',
'title' => 'Title Page',
'copyright' => 'Copyright',
'ded' => 'Dedication',
'ack' => 'Acknowledgment',
'intro' => 'Introduction',
'content' => 'Content',
'prologue' => 'Prologue');

## Check the arguments
if (!$ARGV[0]) {
	print "Wrong Syntax!\n";
	print "******************************\n";
	print "Syntax: genopf <archive_name>\n";
	print "******************************\n";
	exit(0);
} 

print "\nStarting Generating contents.opf...\n";

## Get EPUB Dir
$DirName=$ARGV[0];
$epubType=$DirName;
$epubType=~s/^(.+?)\/(OEBPS|OPS)$/$2/s;
#print "ePub Type: (".$epubType.")\n";
&DebugMessage("Dir. Name: $DirName\n");
#exit(0);

## Open EPUB Packet directory
&DebugMessage("Pushing html files into hash");
my ($imgfile,%imgfiles);
opendir (DIR,"$DirName") || die "Couldn't open Dir!!!";  
while (defined($filename = readdir(DIR))) {
    if ($filename=~/^([A-Za-z0-9-\_]+)\.(xhtml|html)$/) {
	#&TYPEOUT("Pushing file ($htmlfile) into hash");
	# print(".");
	$filesHash{$1}="$filename";#$htmlfile
    } elsif ($filename eq "Images" || $filename eq "images") {
	opendir(IMGDIR,"$DirName/$filename") || die "Couldn't open $filename Dir!!!";
	while (defined($imgfile = readdir(IMGDIR))) {
	    next if ($imgfile =~ m/^\./);
	    next if ($imgfile =~ m/\.db$/);
	    $imgfiles{"$imgfile"}="$imgfile";
	}
	closedir(IMGDIR);
    }
    # print "\n";
    
    ## Document Title
}
closedir(DIR);

## Get Metadata
&getMetadata("$DirName");

## Add all images
my ($imageArray,$imgcount);
$imageArray='';

if (scalar(keys(%imgfiles))) {
    foreach my $item (sort (keys %imgfiles)) {
	#print $item." ";
	&addManifestItem("images\/$item","image");
    }
} else {
    $manFileArray="";
}

## Print Metadata
my ($chapCount,$itemCount);
my $filecontent='';

&DebugMessage("Adding metadata'");
$filecontent=<<EOF
<?xml version="1.1" encoding="utf-8" ?>
<package xmlns="http://www.idpf.org/2007/opf" version="2.0" unique-identifier="p$ISBN">
<metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
<dc:title>$docTitle</dc:title>
<dc:creator>$docCreator</dc:creator>
<dc:identifier id="p$ISBN">$ISBN</dc:identifier>
<dc:language>$xmlLangVal</dc:language>
<dc:rights>$publisher</dc:rights>
<dc:publisher></dc:publisher>
<meta name="cover" content="cover"/>
</metadata>
<manifest>
<item href="toc.ncx" id="ncx" media-type="application/x-dtbncx+xml" />$manFileArray
<item href="css/stylesheet.css" id="style" media-type="text/css" />
<item href="page-template.xpgt" id="page-template" media-type="application/vnd.adobe-page-template+xml" />
EOF
;

print $DirName."\n";

#$imageArray
## Open content.opf 
open(OPFFILE,">$DirName/content.opf") || die "Couldn't create file";
print OPFFILE $filecontent;

## Book's Chapters
my ($chcount,$chNumberName,$ch);

## 
$manItemCount=0;
$manFileArray=();
&AddinManifest;

##
print OPFFILE "</manifest>\n<spine toc=\"ncx\">\n";

## Adds Meta Components into SPINE
# if (-e "$DirName/../toc.config") { ## Check if toc.config doesn't exist
# } else {
#     &AddMetaComponent('cover','title','copyright','ded','content');#,'intro','prologue'
# }
# print "\n";

&AddMainComponent;

# print "\n";
print OPFFILE "<\/spine>\n<\/package>\n";

## Close File Handle
close(OPFFILE);

exit(0);

## SUBROUTINES
## Document Title
sub getMetadata {
	my ($fileLocation) = @_;
	
# 	print ">> File Location: $fileLocation\n";
	##
	&DebugMessage("Getting book title from 'title.html'");
	if (-e "$fileLocation/title.html") {
		open(TITLE,"$fileLocation/title.html");
		while (my $line=<TITLE>) {
			if ($line=~/<title>(.+?)<\/title>/s) {
				$docTitle=$1;
				$docTitle=~s/<br \/>/ /g;
				$docTitle=~s/<br\/>//g;
				$docTitle=~s/<i>(.+?)<\/i>/$1/g;
				$docTitle=~s/<b>(.+?)<\/b>/$1/g;
				$docTitle=~s/<em>(.+?)<\/em>/$1/g;
				$docTitle=~s/<strong>(.+?)<\/strong>/$1/g;
				$docTitle=~s/<small>(.+?)<\/small>/$1/g;
				# last;
			}

			if ($line=~/<p class="author">(.+?)<\/p>/s) {
				$docCreator=$1;
				$docCreator=~s/<br \/>/ /g;
				$docCreator=~s/<br\/>//g;
				$docCreator=~s/<i>(.+?)<\/i>/$1/g;
				$docCreator=~s/<b>(.+?)<\/b>/$1/g;
				$docCreator=~s/<em>(.+?)<\/em>/$1/g;
				$docCreator=~s/<small>(.+?)<\/small>/$1/g;
				$docCreator=~s/<strong>(.+?)<\/strong>/$1/g;
				$docCreator=~s/\s+<span class="padding" \/>\s+/ /g;	
			}
		}
		close(TITLE);
# 		print "$docTitle\n";		
	} elsif (-e "$fileLocation/title.xhtml") {
		open(TITLE,"$fileLocation/title.xhtml");
		while (my $line=<TITLE>) {
			if ($line=~/<title>(.+?)<\/title>/s) {
				$docTitle=$1;
				$docTitle=~s/<br \/>/ /g;
				$docTitle=~s/<br\/>//g;
				$docTitle=~s/<i>(.+?)<\/i>/$1/g;
				$docTitle=~s/<b>(.+?)<\/b>/$1/g;
				$docTitle=~s/<em>(.+?)<\/em>/$1/g;
				$docTitle=~s/<strong>(.+?)<\/strong>/$1/g;
				$docTitle=~s/<small>(.+?)<\/small>/$1/g;
				last;
			}

			if ($line=~/<p class="author">(.+?)<\/p>/s) {
				$docCreator=$1;
				$docCreator=~s/<br \/>/ /g;
				$docCreator=~s/<br\/>//g;
				$docCreator=~s/<i>(.+?)<\/i>/$1/g;
				$docCreator=~s/<b>(.+?)<\/b>/$1/g;
				$docCreator=~s/<em>(.+?)<\/em>/$1/g;
				$docCreator=~s/<small>(.+?)<\/small>/$1/g;
				$docCreator=~s/<strong>(.+?)<\/strong>/$1/g;
				$docCreator=~s/\s+<span class="padding" \/>\s+/ /g;	
			}
		}
		close(TITLE);
		# print "$docTitle\n";
	} else {
		TYPEOUT("No title.html found! Please check.");
	}

	## ISBN
	$publisher='';
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
		    } elsif ($line=~/<p class="([A-Za-z0-9-]+)">\&\#x00A9\;(.+?)<\/p>/s) {
			$publisher="\&\#x00A9\;$2";
		    }
		    
		    $line=~s/<small>ISBN<\/small>/ISBN:/s;
		    $line=~s/<p>ISBN:(.+?)<\/p>$/ISBN:$1/s;
		    $line=~s/<p class="([A-Za-z0-9-]+)">EPUB:(.+?)<\/p>$/ISBN $2/s;
		    $line=~s/<p class="([A-Za-z0-9-]+)">ISBNS<\/p>//s;
		    $line=~s/<p class="([A-Za-z0-9-]+)">ISBN:<\/p>/ISBN:XXXXXXXXXXXXX/s;
		    if ($line=~/ISBN([:]?)(.+?)$/s) {
			$ISBN=$2;
			$ISBN=~s/^\s//s;
			$ISBN=~s/\&\#x002D\;//g;
			$ISBN=~s/([0-9]+)\-/$1/g;
			# $ISBN=~s/\Q¡V\E//g;
			$ISBN=~s/\s//g;
			if ($ISBN=~/(\d{13})(.*?)$/) {
			    $ISBN=$1;
			}
			#last;
		    }
		}
		close(CPY); 
	} elsif (-e "$fileLocation/copyright.xhtml") {
		&DebugMessage("Getting ISBN  from 'copyright.xhtml'");
		open(CPY,"$fileLocation/copyright.xhtml");
		while (my $line=<CPY>) {
			if ($line=~/^<p([A-Za-z0-9\=\s\"]+)>(.+?)Publishing<\/p>$/s) {
				$publisher="${2}Publishing";
			} elsif ($line=~/<p class="([A-Za-z0-9-]+)">\&\#x00A9\;(.+?)<\/p>/s) {
			    $publisher="\&\#x00A9\;$2";
			}

			$line=~s/<small>ISBN<\/small>/ISBN:/s;
			if ($line=~/ISBN:(.+?)$/s) {
				$ISBN=$1;
				$ISBN=~s/^\s//s;
				$ISBN=~s/\&\#x002D\;//g;
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

## Add Manifest Items
sub addManifestItem () {## #1: item, #2: filetype, #3: media-type  #("images\/$item","$imgcount","image\/jpeg");
    my ($itemHref,$filetype) = @_;
    my ($itemID,$itemMediaType);
    $manItemCount++;
    ##
    if (($filetype eq "image") && ($itemHref=~/cover\.(png|gif|jpg)$/)) {
	$itemID="cover";
	print "++ $filetype++$itemHref\n";
    } elsif ($filetype eq "image") {
	$itemID="img$manItemCount";
	print "== $filetype++$itemHref\n";
    }
    # print $manItemCount."=$itemID\n";

    ##
    if ($itemHref=~/\.(png|gif)$/) {
	$itemMediaType="image\/$1";
    } elsif ($itemHref=~/\.jpg$/) {
	$itemMediaType="image\/jpeg";
    } elsif ($itemHref=~/\.(xhtml|html)$/) {
	$itemMediaType="application\/xhtml\+xml";
    }
    $manFileArray=$manFileArray."\n<item href=\"$itemHref\" id=\"$itemID\" media-type=\"$itemMediaType\" \/>";
}

## Adds all components into Manifest
sub AddinManifest {
    my ($itemFile);
    TYPEOUT("Adds all components into OPF's Manifest.");
    foreach my $item (sort (keys %filesHash)) {
	$itemCount++;
	$chcount++;
	#print $chcount."->".$item."\n";
	$chapCount=$chcount;
	
	$itemFile=$filesHash{$item};
	if ($epubType eq "OPS") {#OEBPS | OPS
	    $itemFile=~s/\.(xhtml|html)$//s;
	}

	## Make Chapter Names
	# print ".";
	#&addManifestItem("images\/$item","image");
	print OPFFILE "<item href=\"$filesHash{$item}\" id=\"$itemFile\" media-type=\"application/xhtml+xml\" \/>\n";
    }
}

## Adds Meta Components
sub AddMetaComponent () {
    my (@compArray) = @_;
    my ($itemFile);
    if (-e "$DirName/../fm.config") {
	open(fmConfig,"$DirName/../fm.config") || die ("Couldn't open 'toc.config' file");
	while (my $line=<fmConfig>) {
	    $line=~s/\s+$//s;
	    # print "($line)\n"; 
	    @compArray=split(/, /,$line);
	    #print @compArray;
	    foreach my $item (@compArray) {
		# print $item."++";
		$item=~s/\.(xhtml|html)//s;
		if ($filesHash{$item}) {
		    #$includedFile{"$filesHash{$item}"}="$filesHash{$item}";
		    $itemFile="$filesHash{\"$item\"}";
		    ##
		    # print $itemFile."\n";
		    if ($epubType eq "OPS") {#OEBPS | OPS
			$itemFile=~s/\.(xhtml|html)$//s;
		    }
		    print OPFFILE "<itemref idref=\"$itemFile\" \/>\n";
		    delete $filesHash{$item};
		}
	    }
	}
	close(fmConfig);
    } else {
	foreach my $item (@compArray) {
	    # print $item."++";
	    if ($filesHash{$item}) {
		$includedFile{"$filesHash{$item}"}="$filesHash{$item}";
		$itemFile="$filesHash{\"$item\"}";
		##
		if ($epubType eq "OPS") {#OEBPS | OPS
		    $itemFile=~s/\.(xhtml|html)$//s;
		}
		print OPFFILE "<itemref idref=\"$itemFile\" \/>\n";
		delete $filesHash{$item};
	    }
	}
	
	## Delete index from hash
	delete $filesHash{'index'} if $filesHash{'index'};
    }
}

## Adds Main Component
sub AddMainComponent {
    my ($contentHTML,$itemFile);
    ## Get components order
    my (@tocComponent);

    if (-e "$DirName/../toc.config") {
	open(TOC,"$DirName/../toc.config") || die ("Couldn't open 'toc.config' file");
	while (my $line=<TOC>) {
	    $line=~s/\s+$//s;
	    #print $line."\n";
	    if ($line=~/^(.+?)\=(.+?)$/s) {
		my $toc_filename=$2;
		
		$toc_filename=~s/^\s+//s;
		$toc_filename=~s/\s+$//s;
		if (-e "$DirName/$toc_filename") {
		    push(@tocComponent,"$toc_filename");
		}
	    }	    
	}
	close(TOC);
    } elsif (-e "$DirName/../toc.xml") {
	open(TOC,"$DirName/../toc.xml") || die ("Couldn't open 'content.html' file");
	while (my $line=<TOC>) {
	    if ($line=~/<file>(.+?)<\/file>/s) {
		my $toc_filename=$1;
		if ($includedFile{"$toc_filename"}) {
		    #print "\n$toc_filename...\n";
		} else {
		    push(@tocComponent,"$toc_filename");
		}
	    }
	}
	close(TOC);
    } elsif (-e "$DirName/content.html") {
	&AddMetaComponent('cover','title','copyright','ded','content');#,'intro','prologue'
	# print "Exist.....+$DirName/content.html\n";
	open(TOC,"$DirName/content.html") || die ("Couldn't open 'content.html' file");
	while (my $line=<TOC>) {
	    $line=~s/<a id="page([0-9]+)" \/>//s;
	    $line=~s/<a id="page([0-9]+)"\/>//s;
	    if ($line=~/<p class="([A-Za-z0-9\-]+)"><a href="([A-Za-z0-9\-]+)\.(xhtml|html)">/s) {
		$tocFile="$2.$3";

		## Insert into Array
		if (-e "$DirName/$tocFile") {
		    push(@tocComponent,"$tocFile");
		} else {
		    print "\t** The File '$tocFile' doesn't exist!!!\n";
		}
	    # } elsif ($line=~/<a href="(.+?)\.(xhtml|html)">/s) {
	    # 	$tocFile="$1.$2";

	    # 	## Insert into Array
	    # 	if (-e "$DirName/$tocFile") {
	    # 	    push(@tocComponent,"$tocFile");
	    # 	} else {
	    # 	    print "\t** The File '$tocFile' doesn't exist!!!\n";
	    # 	}
	    } elsif ($line=~/<li><a href="([A-Za-z0-9\-]+)\.(xhtml|html)">/s) {
		$tocFile="$1.$2";
		
		## Insert into Array
		if (-e "$DirName/$tocFile") {
		    push(@tocComponent,"$tocFile");
		} else {
		    print "\t** The File '$tocFile' doesn't exist!!!\n";
		}
	    }
	}
	close(TOC);
    } elsif (-e "$DirName/content.xhtml") {
	&AddMetaComponent('cover','title','copyright','ded','content');#,'intro','prologue'
	# print "Exist.....\n";
	open(TOC,"$DirName/content.xhtml") || die ("Couldn't open 'content.html' file");
	while (my $line=<TOC>) {
	    if ($line=~/<p class="([A-Za-z0-9\-]+)"><a href="([A-Za-z0-9\-]+)\.(xhtml|html)">/s) {
		$tocFile="$2.$3";

		## Insert into Array
		if (-e "$DirName/$tocFile") {
		    push(@tocComponent,"$tocFile");
		} else {
		    print "\t** The File '$tocFile' doesn't exist!!!\n";
		}
	    } elsif ($line=~/<a href="(.+?)\.(xhtml|html)">/s) {
		$tocFile="$1.$2";

		## Insert into Array
		if (-e "$DirName/$tocFile") {
		    push(@tocComponent,"$tocFile");
		} else {
		    print "\t** The File '$tocFile' doesn't exist!!!\n";
		}
	    }
	}
	close(TOC);
    }

    ## Adds components into SPINE
    $chcount=0;
    $itemCount=0;
    if ($#tocComponent  > -1) {
	# print "Exist!!!@tocComponent\n";
	#%filesHash = @tocComponent;

	##
	foreach my $item (@tocComponent) {
	    $itemFile="$item";
	    ##
	    if ($epubType eq "OPS") {#OEBPS | OPS
		$itemFile=~s/\.(xhtml|html)$//s;
	    }

	    print OPFFILE "<itemref idref=\"$itemFile\" \/>\n";
	}
    } else {
	foreach my $item ((keys %filesHash)) {
	    $itemCount++;
	    $chcount++;
	    # print $chcount."=$itemCount->".$item."\n";
	    
	    $chapCount=$chcount;
	    
	    ## Make Chapter Names
	    # print ".";
	    $itemFile="$filesHash{\"$item\"}";
	    ##
	    if ($epubType eq "OPS") {#OEBPS | OPS
		$itemFile=~s/\.(xhtml|html)$//s;
	    }

	    print OPFFILE "<itemref idref=\"$itemFile\" \/>\n";
	}
    }
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

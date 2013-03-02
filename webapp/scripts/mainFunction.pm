#
# Common Subroutines and activities
# Developed by Mukesh Kumar
# Date: 31-07-2012

package mainFunction;
$VERSION = 1.0;

use strict;

use vars qw(%entityHash);

## DEFAULT CONSTRUCTOR
sub new {
    my ($class) = @_;
    my $self = {
	IDpatt => "\\w",
	IDpatt1 => "A-Za-z0-9-",
	attVal => "\\w\\|\\[\\]\\(\\)\\*\\^\\/\\#&\\.,:\\;\\?\\s\\+-",
	attType => "A-Za-z\\*-",
    };
    #
    #&DisplayMessage($self,"Constructor loading");
    #
    bless $self, $class;
    return $self; 
}


sub LoadEntityDatabase () {
    my ($self,$filePath,$filename) = @_;
    my ($entitymap,$unicode,$decimal,$isoent);
    $entitymap="$filePath/$filename";
    open(ENTMAP,"<$entitymap") || die ("Couldn't open entities database file");
    while(<ENTMAP>) {
	if (/<character id="U([A-Z0-9]+)" dec="([0-9]+)" /) {
	    $unicode=$1;
	    $decimal=$2;
	    # print "(".$1.") (".$2.") ";
	    $self->{entityHash}{'decimalToUnicode'}{"$decimal"}="$unicode";
	    $self->{entityHash}{'unicodeToDecimal'}{"$unicode"}="$decimal";
	}

	if (/<entity id="([A-Za-z]+)" set="([0-9a-z\-]+)"([\/]?)>/) {
	    $isoent=$1;
	    if ($unicode) {
		#print $isoent."+$unicode==";
		$self->{entityHash}{'unicodeToISO'}{"$unicode"}="$isoent";
		$self->{entityHash}{'IsoToUnicode'}{"$isoent"}="$unicode";
		undef ($unicode);
		undef ($decimal);
	    }
	    undef ($isoent);
	}
    }
    close(ENTMAP);
}


##
sub DisplayMessage () {
    my ($self,$msg) = @_;
    ##print "++ $msg...\n";
}

#!/usr/bin/perl

use Socket;

sub sendcmd {
$sockaddr = 'Sna4x8';
($name, $aliases, $proto) = getprotobyname('tcp');
($name, $aliases, $type, $len, $thisaddr) = gethostbyname($host);
$thisport = pack($sockaddr, &AF_INET, 0, $thisaddr);
$thatport = pack($sockaddr, &AF_INET, $port, $thisaddr);

socket(S, &PF_INET, &SOCK_STREAM, $proto) || die "cannot create socket\n";
if (connect(S,$thatport)) {
    connect(S,$thatport);
    print "\nSocket connected!\n";
} else {
    print "\nNo Socket connection!\n";
}
#	connect(S,$thatport) || die "cannot connect socket\n";

# Set socket to write after each print
select(S); $| = 1; select(STDOUT);
#
# Send command
#
#print "$user,$passwd,$command\n";
printf S "0\0%s\0%s\0%s\0",$user,$passwd,$command;
#
# Read responses from server and print them out 
#
while ( $_ = <S> ) {
    print "++ ";
    printf ("$_");
};
close(S);
};


#
# MAIN
#
#
#$port=512;
$port=22;#445 #49322;
$host="192.168.1.12";
$user="root";
$passwd="123456";

#$ClientIPAdd=$ARGV[0];
#$file=$ARGV[1];

$ClientIPAdd="192.168.1.57";
$file="mkc.txt";


print "$file+$ClientIPAdd\n";
#DISPLAY ${ClientIPAdd}:0.0 && 
$command="env DISPLAY=192.168.1.57:0.0 && /usr/bin/emacs";


print $command;

sendcmd;

exit 0;

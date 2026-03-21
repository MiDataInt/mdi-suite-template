use strict;
use warnings;

# developer script to mask server paths and user names from job report documentation files

my @maskPaths = (
    "/path/to/mask", # etc.
);
my @maskVals = (
    "text_to_mask", # etc.
);
my $pathMask = "/path/to";
my $valMask = "XXXXX";

while (my $line = <STDIN>) {
    if($line =~ m/\rProgress/){
        print "Progress: 100.00%\n";
        next;
    }
    if($line =~ m/\r/){
        next;
    }
    foreach my $path (@maskPaths) {
        $line =~ s|$path|$pathMask|g;
    }
    foreach my $val (@maskVals) {
        $line =~ s|$val|$valMask|g;
    }
    print $line;
}

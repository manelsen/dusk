#!/usr/bin/env perl
use strict;
use warnings;

my $docs_dir = ".docs/discord-api-docs/developers";
my @files = `find $docs_dir -name '*.mdx'`;
chomp @files;

my %endpoints;

foreach my $file (@files) {
    open my $fh, '<', $file or die "Cannot open $file: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    
    while ($content =~ /<Route\s*method="([A-Z]+)">\s*([^<]+?)\s*<\/Route>/g) {
        my $method = $1;
        my $raw_path = $2;
        
        # Clean up markdown links like [\{channel.id\}](/link) -> {channel.id}
        my $path = $raw_path;
        $path =~ s/\[([^\]]+)\]\([^)]+\)/$1/g;
        
        # Remove backslash escapes
        $path =~ s/\\//g;
        
        # Some paths might have asterisks
        $path =~ s/\*//g;
        
        $endpoints{"$method $path"}++;
    }
}

open my $out, '>', 'ENDPOINTS_COVERAGE.md' or die $!;
print $out "# Discord API v10 Endpoints Coverage Report\n\n";
print $out "| Endpoint | Implemented? | Tested? |\n";
print $out "|---|---|---|\n";

foreach my $ep (sort keys %endpoints) {
    print $out "| `$ep` | ❌ | ❌ |\n";
}
close $out;

print "Extracted " . scalar(keys %endpoints) . " endpoints.\n";

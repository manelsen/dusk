#!/usr/bin/env perl
use strict;
use warnings;

my $endpoints_file = "ENDPOINTS_COVERAGE.md";
open my $fh, '<', $endpoints_file or die $!;

my @routes;
while (<$fh>) {
    if (/\|\s*`([A-Z]+)\s+([^`]+)`\s*\|/) {
        push @routes, { verb => $1, path => $2 };
    }
}
close $fh;

sub generate_method_name {
    my ($verb, $path) = @_;
    my @parts = split '/', $path;
    my @name_parts = (lc($verb));
    
    for my $p (@parts) {
        next if $p eq '';
        if ($p =~ /^\{([^}]+)\}$/) {
            # it's a param, maybe skip or add "by_id" but typically Discord paths 
            # like /guilds/{guild.id}/members -> get-guilds-members
            # Let's just keep the static parts to form the name.
        } else {
            push @name_parts, $p;
        }
    }
    
    # Simple fix for collision (e.g., getting a single item vs getting collection)
    if ($path =~ /\}$/) {
        # if ends with a param, it's usually getting a singular item
        $name_parts[-1] =~ s/s$// if $verb eq 'GET' && $name_parts[-1] =~ /s$/;
    }
    
    my $name = join('-', @name_parts);
    # Edge cases
    $name =~ s/\@//g;
    $name =~ s/-original/original/g;
    $name =~ s/--/-/g;
    $name =~ s/-$//;
    
    return $name;
}

sub generate_params {
    my ($path) = @_;
    my @params;
    while ($path =~ /\{([^}]+)\}/g) {
        my $p = $1;
        $p =~ s/\./-/g;
        $p =~ s/_/-/g;
        push @params, $p;
    }
    return @params;
}

my %seen;
open my $out, '>', 't/02-endpoint-generated.t' or die $!;
print $out "use v6.d;\nuse Test;\n\nplan " . scalar(@routes) . ";\n\nuse Dusk::Rest::Endpoint;\n\n";

for my $r (@routes) {
    my $verb = $r->{verb};
    my $path = $r->{path};
    
    my $method = generate_method_name($verb, $path);
    
    # Handle collisions by appending an index
    if ($seen{$method}) {
        my $i = 2;
        while ($seen{"$method-$i"}) { $i++; }
        $method = "$method-$i";
    }
    $seen{$method} = 1;
    
    my @params = generate_params($path);
    my $args = "";
    if (@params) {
        $args = join(", ", map { "$_ => 'test-val'" } @params);
    }
    
    my $subtest_name = "Endpoint: $verb $path";
    
    print $out <<EOT;
subtest '$subtest_name' => {
    my \$route;
    lives-ok { \$route = Dusk::Rest::Endpoint.$method($args) }, 'Method $method exists and accepts parameters';
    
    if \$route {
        is \$route.method, '$verb', 'Method is $verb';
        is \$route.path, '$path', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

EOT
}
close $out;
print "Generated tests for " . scalar(@routes) . " endpoints in t/02-endpoint-generated.t\n";

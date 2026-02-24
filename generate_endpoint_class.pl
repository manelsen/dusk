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
            # Skip params
        } else {
            push @name_parts, $p;
        }
    }
    
    if ($path =~ /\}$/) {
        $name_parts[-1] =~ s/s$// if $verb eq 'GET' && $name_parts[-1] =~ /s$/;
    }
    
    my $name = join('-', @name_parts);
    $name =~ s/\@//g;
    $name =~ s/-original/original/g;
    $name =~ s/\.//g;
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
open my $out, '>', 'lib/Dusk/Rest/Endpoint.rakumod' or die $!;
print $out "use v6.d;\nuse Dusk::Rest::Route;\n\nunit class Dusk::Rest::Endpoint;\n\n";

for my $r (@routes) {
    my $verb = $r->{verb};
    my $path = $r->{path};
    
    my $method = generate_method_name($verb, $path);
    
    if ($seen{$method}) {
        my $i = 2;
        while ($seen{"$method-$i"}) { $i++; }
        $method = "$method-$i";
    }
    
    # Raku method names cannot end in numbers directly following a hypen if it looks like minus sign without spaces. 
    # To be safe, let's just make valid method names.
    $method =~ s/-(\d+)$/X$1/;
    
    $seen{$method} = 1;
    
    my @params = generate_params($path);
    my $args = "";
    if (@params) {
        $args = join(", ", map { ":\$$_\!" } @params);
    }
    
    # Optional body params for POST/PATCH/PUT
    if ($verb =~ /^(POST|PUT|PATCH)$/) {
        $args .= ", " if $args;
        $args .= "*\%body";
    }
    
    my $interpolated_path = $path;
    # Replace {application.id} with $application-id
    $interpolated_path =~ s/\{([^\}]+)\}/\$$1/g;
    $interpolated_path =~ s/\./-/g;
    $interpolated_path =~ s/_/-/g;
    
    # We use qq[] to cleanly interpolate
    print $out "method $method($args) returns Dusk::Rest::Route {\n";
    print $out "    return Dusk::Rest::Route.new(\n";
    print $out "        method => '$verb',\n";
    print $out "        path   => qq[$interpolated_path],\n";
    if ($verb =~ /^(POST|PUT|PATCH)$/) {
        print $out "        body   => \%body,\n";
    }
    print $out "    );\n";
    print $out "}\n\n";

}
close $out;
print "Generated lib/Dusk/Rest/Endpoint.rakumod with " . scalar(@routes) . " routes.\n";

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
        if ($p !~ /^\{/) {
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
sub get_unique_name {
    my ($method) = @_;
    my $original = $method;
    my $i = 2;
    while ($seen{$method}) {
        $method = "${original}X${i}";
        $i++;
    }
    $seen{$method} = 1;
    return $method;
}

open my $out_tests, '>', 't/02-endpoint-generated.t' or die $!;
open my $out_class, '>', 'lib/Dusk/Rest/Endpoint.rakumod' or die $!;

print $out_tests "use v6.d;\nuse Test;\n\nplan " . scalar(@routes) . ";\n\nuse Dusk::Rest::Endpoint;\n\n";
print $out_class "use v6.d;\nuse Dusk::Rest::Route;\n\nunit class Dusk::Rest::Endpoint;\n\n";

for my $r (@routes) {
    my $verb = $r->{verb};
    my $path = $r->{path};
    
    my $base_method = generate_method_name($verb, $path);
    my $method = get_unique_name($base_method);
    
    my @params = generate_params($path);
    
    # --- Generate Test Assertion ---
    my $test_args = "";
    if (@params) {
        $test_args = join(", ", map { "$_ => 'test-val'" } @params);
    }
    
    my $expected_path = $path;
    $expected_path =~ s/\{([^\}]+)\}/test-val/g;
    
    my $subtest_name = "Endpoint: $verb $path";
    print $out_tests <<EOT;
subtest '$subtest_name' => {
    my \$route;
    lives-ok { \$route = Dusk::Rest::Endpoint.$method($test_args) }, 'Method $method exists and accepts parameters';
    
    if \$route {
        is \$route.method, '$verb', 'Method is $verb';
        is \$route.path, '$expected_path', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

EOT

    # --- Generate Class Method ---
    my $class_args = "";
    if (@params) {
        $class_args = join(", ", map { ":\$$_\!" } @params);
    }
    
    if ($verb =~ /^(POST|PUT|PATCH)$/) {
        $class_args .= ", " if $class_args;
        $class_args .= "*\%body";
    }
    
    my $interpolated_path = $path;
    $interpolated_path =~ s/\{([^\}]+)\}/
        my $var = $1;
        $var =~ s{\.}{-}g;
        $var =~ s{_}{-}g;
        "\$$var"
    /eg;
    
    print $out_class "method $method($class_args) returns Dusk::Rest::Route {\n";
    print $out_class "    return Dusk::Rest::Route.new(\n";
    print $out_class "        method => '$verb',\n";
    print $out_class "        path   => qq[$interpolated_path],\n";
    if ($verb =~ /^(POST|PUT|PATCH)$/) {
        print $out_class "        body   => \%body,\n";
    }
    print $out_class "    );\n";
    print $out_class "}\n\n";
}

close $out_tests;
close $out_class;

print "Successfully synced generators for " . scalar(@routes) . " routes.\n";

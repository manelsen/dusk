use v6.d;

my $docs-dir = ".docs/discord-api-docs/developers";
my @files = qqx{find $docs-dir -name '*.mdx'}.lines;

my %endpoints;

for @files -> $file {
    my $content = $file.IO.slurp;
    # Regex to match <Route method="VERB">PATH</Route>
    for $content ~~ m:g/ '<Route method="' (<[A..Z]>+) '">' (<-[<]>+) '<\/Route>' / -> $match {
        my $method = $match[0].Str;
        my $raw-path = $match[1].Str;
        
        # Clean up markdown links like [\{channel.id\}](/link) -> {channel.id}
        my $path = $raw-path;
        $path ~~ s:g/ '[' (<-[\]]>+) ']' '(' <-[)]>+ ')' /$0/;
        
        # Remove backslash escapes
        $path ~~ s:g/ '\\' //;
        
        %endpoints{"$method $path"}++;
    }
}

my $out = open "ENDPOINTS_COVERAGE.md", :w;
$out.say("# Discord API v10 Endpoints Coverage Report\n");
$out.say("| Endpoint | Implemented? | Tested? |");
$out.say("|---|---|---|");

for %endpoints.keys.sort -> $ep {
    $out.say("| `$ep` | ❌ | ❌ |");
}
$out.close;

say "Extracted " ~ %endpoints.elems ~ " endpoints.";

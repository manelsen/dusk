#!/usr/bin/env raku
# ST-05: File upload and download (attachment) via multipart/form-data
use lib $*PROGRAM.parent.child('lib').absolute;
use JSON::Fast;
use Cro::HTTP::Client;

my $token      = %*ENV<DISCORD_BOT_TOKEN> or die "DISCORD_BOT_TOKEN missing";
my $channel-id = %*ENV<TEXT_CHANNEL_ID>   or die "TEXT_CHANNEL_ID missing";

# Temporary test file
my $f = $*TMPDIR.child("dusk-smoke-{now.Int}.txt");
$f.spurt("Dusk Smoke Test\nTimestamp: {DateTime.now}\n");
LEAVE { $f.unlink if $f.e }

my $filename = $f.basename;
my $content  = $f.slurp(:bin);

# Note: Using curl as a robust fallback for multipart/form-data
my $payload = to-json({
        content     => "🧪 ST-05 — File Upload",
        attachments => [ $( { id => 0, filename => $filename } ) ],
});

my $cmd = "curl -s -X POST "
~ "-H 'Authorization: Bot $token' "
~ "-F 'payload_json=$payload' "
~ "-F \"files[0]=\@{$f.absolute}\" "
~ "'https://discord.com/api/v10/channels/$channel-id/messages'";

my $proc = shell($cmd, :out);
my $output = $proc.out.slurp(:close);

if $proc.exitcode != 0 {
    die "Curl failed with exit code {$proc.exitcode}: $output";
}

my $body = from-json($output);

if $body<id> {
    say "ST-05 OK — '{$body<attachments>[0]<filename>}' ({$body<attachments>[0]<size>}B) sent";
} else {
    die "Upload Failed: " ~ $output;
}

exit 0;

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

# Note: Cro supports multipart/form-data via array of pairs
my $client = Cro::HTTP::Client.new(:http<1.1>,
    headers => [Authorization => "Bot $token"]);

my $resp = await $client.post(
    "https://discord.com/api/v10/channels/$channel-id/messages",
    content-type => 'multipart/form-data',
    body => [
        payload_json => to-json({
                content     => "🧪 ST-05 — File Upload",
                attachments => [{ id => 0, description => "smoke test file" }],
        }),
        "files[0]" => $content,   # Blob — Cro serializes as octet-stream
    ],
);

die "Upload failed: status {$resp.status}" unless $resp.status == 200;
my $body = from-json(await $resp.body-text);

die "id missing"          unless $body<id>;
die "attachments missing" unless $body<attachments> && $body<attachments>.elems;

my $att = $body<attachments>[0];
die "url missing" unless $att<url>;

# Download and verification
my $dl   = await Cro::HTTP::Client.new(:http<1.1>).get($att<url>);
my $data = await $dl.body-blob;
die "downloaded file is empty" unless $data.elems > 0;

say "ST-05 OK — '{$att<filename>}' ({$att<size>}B) sent and downloaded";
exit 0;

#!/usr/bin/env raku
# ST-01: Send and receive simple text message
use lib $*PROGRAM.parent.child('lib').absolute;
use SmokeHelper;

my $channel-id = %*ENV<TEXT_CHANNEL_ID> or die "TEXT_CHANNEL_ID missing";

my %body = content => "🧪 ST-01 — simple text [{DateTime.now.Str}]";
my $resp  = api-post("/channels/$channel-id/messages", %body);

die "id missing"      unless $resp<id>;
die "content missing" unless $resp<content>;

say "ST-01 OK — id=$resp<id>";
exit 0;

#!/usr/bin/env raku
# ST-04: Add and remove reactions on messages
use lib $*PROGRAM.parent.child('lib').absolute;
use SmokeHelper;

my $channel-id = %*ENV<TEXT_CHANNEL_ID> or die "TEXT_CHANNEL_ID missing";

# 1. Send base message
my $msg = api-post("/channels/$channel-id/messages",
    %( content => "🧪 ST-04 — Reactions" ));
my $msg-id = $msg<id> or die "Failed to create message";

# 2. Add reactions (PUT → 204)
for <👍 ❤️ 🚀> -> $emoji {
    my $status = api-put("/channels/$channel-id/messages/$msg-id/reactions/$emoji/\@me");
    say "  Reaction '$emoji': " ~ ($status == 204 ?? "✅" !! "⚠️ status=$status");
}

# 3. Remove all reactions (DELETE → 204)
my $del-status = api-delete("/channels/$channel-id/messages/$msg-id/reactions");
say "  Remove all reactions: " ~ ($del-status == 204 ?? "✅" !! "⚠️ status=$del-status");

say "ST-04 OK — msg-id=$msg-id";
exit 0;

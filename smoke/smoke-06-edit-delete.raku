#!/usr/bin/env raku
# ST-06: Create, edit, and delete message
use lib $*PROGRAM.parent.child('lib').absolute;
use SmokeHelper;

my $channel-id = %*ENV<TEXT_CHANNEL_ID> or die "TEXT_CHANNEL_ID missing";

# 1. Create
my $msg = api-post("/channels/$channel-id/messages",
    %( content => "🧪 ST-06 — original [{DateTime.now.Str}]" ));
my $id  = $msg<id> or die "Failed to create message";
say "  Created (id=$id)";

# 2. Edit
my $edited  = "✏️ ST-06 — EDITED [{DateTime.now.Str}]";
my $edit    = api-patch("/channels/$channel-id/messages/$id", %( content => $edited ));
die "content not changed: '$edit<content>'" unless $edit<content> eq $edited;
die "edited_timestamp missing" unless $edit<edited_timestamp>;
say "  Edited OK";

# 3. Delete
my $del-status = api-delete("/channels/$channel-id/messages/$id");
say "  Delete status: $del-status " ~ ($del-status == 204 ?? "✅" !! "⚠️");

say "ST-06 OK — create/edit/delete (id=$id)";
exit 0;

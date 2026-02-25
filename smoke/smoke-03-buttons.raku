#!/usr/bin/env raku
# ST-03: Send message with Buttons (Action Row + Button components)
use lib $*PROGRAM.parent.child('lib').absolute;
use SmokeHelper;
use lib $*PROGRAM.parent.parent.child('lib').absolute;
use Dusk::Component;

my $channel-id = %*ENV<TEXT_CHANNEL_ID> or die "TEXT_CHANNEL_ID missing";

my @buttons = (
    Dusk::Component.button(label => "✅ Confirm", style => STYLE_SUCCESS,   custom-id => "smoke-confirm"),
    Dusk::Component.button(label => "❌ Cancel",  style => STYLE_DANGER,    custom-id => "smoke-cancel"),
    Dusk::Component.button(label => "ℹ️ Info",      style => STYLE_SECONDARY, custom-id => "smoke-info"),
    Dusk::Component.link-button(label => "📖 Docs", url => "https://github.com/manelsen/dusk"),
);

my $row  = Dusk::Component.action-row(@buttons);
my $resp = api-post-json("/channels/$channel-id/messages", {
        content    => "🧪 ST-03 — Buttons via Dusk::Component",
        components => [$row],
});

die "id missing"          unless $resp<id>;
die "components missing"  unless $resp<components> && $resp<components>.elems;

my $row-resp = $resp<components>[0];
die "type != 1 (ActionRow)"           unless $row-resp<type> == 1;
die "expected 4 buttons, got {$row-resp<components>.elems}" unless $row-resp<components>.elems == 4;

say "ST-03 OK — {$row-resp<components>.elems} buttons (id=$resp<id>)";
exit 0;

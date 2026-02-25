#!/usr/bin/env raku
# ST-07: Query Guild, Channel, and User (@me) information
use lib $*PROGRAM.parent.child('lib').absolute;
use SmokeHelper;

my $guild-id   = %*ENV<GUILD_ID>        or die "GUILD_ID missing";
my $channel-id = %*ENV<TEXT_CHANNEL_ID> or die "TEXT_CHANNEL_ID missing";

# 1. Bot info
my $me = api-get('/users/@me');
die "username missing" unless $me<username>;
say "  Bot: $me<username> (id=$me<id>)";

# 2. Guild info
my $guild = api-get("/guilds/$guild-id");
die "guild.name missing"    unless $guild<name>;
die "guild.id does not match" unless $guild<id> eq $guild-id;
say "  Guild: '$guild<name>'";

# 3. Guild channels
my $channels = api-get("/guilds/$guild-id/channels");
die "channels is not a list" unless $channels ~~ Positional;
die "no channels"         unless $channels.elems > 0;
say "  {$channels.elems} channels";

# 4. Individual channel
my $ch = api-get("/channels/$channel-id");
die "channel.id does not match" unless $ch<id> eq $channel-id;
say "  Channel: #$ch<name> (type=$ch<type>)";

say "ST-07 OK — guild='$guild<name>', {$channels.elems} channels, bot=$me<username>";
exit 0;

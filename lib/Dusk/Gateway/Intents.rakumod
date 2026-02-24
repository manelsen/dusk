=begin pod
=head1 Dusk::Gateway::Intents

Bit flags for Discord Gateway Intents. Combine with C<+|> (bitwise OR).

=head2 Usage

    use Dusk::Gateway::Intents;
    my $intents = GUILDS +| GUILD_MESSAGES +| MESSAGE_CONTENT;

=end pod

unit module Dusk::Gateway::Intents;

# Non-privileged
our constant GUILDS                   is export = 1 +< 0;   # 1
our constant GUILD_MEMBERS            is export = 1 +< 1;   # 2     (Privileged)
our constant GUILD_MODERATION         is export = 1 +< 2;   # 4
our constant GUILD_EXPRESSIONS        is export = 1 +< 3;   # 8
our constant GUILD_INTEGRATIONS       is export = 1 +< 4;   # 16
our constant GUILD_WEBHOOKS           is export = 1 +< 5;   # 32
our constant GUILD_INVITES            is export = 1 +< 6;   # 64
our constant GUILD_VOICE_STATES       is export = 1 +< 7;   # 128
our constant GUILD_PRESENCES          is export = 1 +< 8;   # 256   (Privileged)
our constant GUILD_MESSAGES           is export = 1 +< 9;   # 512
our constant GUILD_MESSAGE_REACTIONS  is export = 1 +< 10;  # 1024
our constant GUILD_MESSAGE_TYPING     is export = 1 +< 11;  # 2048
our constant DIRECT_MESSAGES          is export = 1 +< 12;  # 4096
our constant DIRECT_MESSAGE_REACTIONS is export = 1 +< 13;  # 8192
our constant DIRECT_MESSAGE_TYPING    is export = 1 +< 14;  # 16384
our constant MESSAGE_CONTENT          is export = 1 +< 15;  # 32768 (Privileged)
our constant GUILD_SCHEDULED_EVENTS   is export = 1 +< 16;  # 65536
our constant AUTO_MODERATION          is export = 1 +< 20;  # 1048576
our constant GUILD_MESSAGE_POLLS      is export = 1 +< 24;  # 16777216
our constant DIRECT_MESSAGE_POLLS     is export = 1 +< 25;  # 33554432

# Common presets
our constant DEFAULT_INTENTS is export = GUILDS +| GUILD_MESSAGES +| DIRECT_MESSAGES;
our constant ALL_NON_PRIVILEGED is export =
    GUILDS +| GUILD_MODERATION +| GUILD_EXPRESSIONS +| GUILD_INTEGRATIONS +|
    GUILD_WEBHOOKS +| GUILD_INVITES +| GUILD_VOICE_STATES +| GUILD_MESSAGES +|
    GUILD_MESSAGE_REACTIONS +| GUILD_MESSAGE_TYPING +| DIRECT_MESSAGES +|
    DIRECT_MESSAGE_REACTIONS +| DIRECT_MESSAGE_TYPING +| GUILD_SCHEDULED_EVENTS +|
    AUTO_MODERATION +| GUILD_MESSAGE_POLLS +| DIRECT_MESSAGE_POLLS;

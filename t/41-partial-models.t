use v6.d;
use Test;
use Dusk::Model::PartialGuild;
use Dusk::Model::PartialChannel;
use Dusk::Model::PartialMember;
use Dusk::Model::AuditLogChange;

plan 6;

# PartialGuild tests
my $guild = Dusk::Model::PartialGuild.new(
    id => '123',
    name => 'Test Guild',
    description => 'A test guild',
);

is $guild.id, '123', 'PartialGuild id is correct';
is $guild.name, 'Test Guild', 'PartialGuild name is correct';

# PartialChannel tests
my $channel = Dusk::Model::PartialChannel.new(
    id => '456',
    name => 'general',
    type => 0,
);

is $channel.id, '456', 'PartialChannel id is correct';
is $channel.name, 'general', 'PartialChannel name is correct';

# PartialMember tests
my $member = Dusk::Model::PartialMember.new(
    id => '789',
    nick => 'TestUser',
);

is $member.nick, 'TestUser', 'PartialMember nick is correct';

# AuditLogChange tests
my $change = Dusk::Model::AuditLogChange.new(
    key => 'name',
    new-value => 'New Name',
    old-value => 'Old Name',
);

is $change.key, 'name', 'AuditLogChange key is correct';

say "✅ All partial model tests passed!";

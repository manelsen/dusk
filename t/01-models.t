use v6.d;
use Test;
use JSON::Fast;

plan 7;

use Dusk::Model::Message;
use Dusk::Model::Channel;
use Dusk::Model::User;
use Dusk::Model::Guild;
use Dusk::Model::Embed;
use Dusk::Model::Component;
use Dusk::Model::Overwrite;

subtest 'Message Parsing (rest_create_message.json)' => {
    my $msg-json = "t/fixtures/rest_create_message.json".IO.slurp;
    my $msg-data = from-json($msg-json);
    
    my $msg = Dusk::Model::Message.new(|$msg-data);
    
    isa-ok $msg, Dusk::Model::Message, 'Can instantiate a Message';
    is $msg.id, "1472053869558239494", 'Message ID parsed correctly';
    is $msg.content, "[Accord.jl integration test — this message will be deleted]", 'Message content parsed correctly';
    is $msg.channel-id, "1212124713271304246", 'Channel ID parsed correctly';
    
    isa-ok $msg.author, Dusk::Model::User, 'Author is parsed into User model';
    is $msg.author.id, "1470119116374282333", 'Author ID correct';
    is $msg.author.username, "Bellegendas Premium", 'Author username correct';
    is $msg.author.discriminator, "7281", 'Author discriminator correct';

    is $msg.embeds.elems, 1, 'Embeds list size correct';
    isa-ok $msg.embeds[0], Dusk::Model::Embed, 'First embed is correct type';
    is $msg.embeds[0].title, "Test Embed", 'Embed title parsed';

    is $msg.components.elems, 1, 'Components list size correct';
    isa-ok $msg.components[0], Dusk::Model::Component, 'First component is correct type (ActionRow)';
    is $msg.components[0].components.elems, 1, 'ActionRow nested components size correct';
    is $msg.components[0].components[0].label, 'Click Me', 'Button label parsed';
};

subtest 'Channel Parsing (rest_get_channel.json)' => {
    my $channel-json = "t/fixtures/rest_get_channel.json".IO.slurp;
    my $channel-data = from-json($channel-json);
    
    my $channel = Dusk::Model::Channel.new(|$channel-data);
    
    isa-ok $channel, Dusk::Model::Channel, 'Can instantiate a Channel';
    is $channel.id, "1212124713271304246", 'Channel ID parsed correctly';
    is $channel.name, "general", 'Channel name parsed correctly';
    is $channel.type, 0, 'Channel type parsed correctly (GUILD_TEXT)';
    is $channel.guild-id, "1212124712629440612", 'Guild ID parsed correctly';
    
    is $channel.permission-overwrites.elems, 1, 'Overwrites list size correct';
    isa-ok $channel.permission-overwrites[0], Dusk::Model::Overwrite, 'Overwrite is correct type';
    is $channel.permission-overwrites[0].id, "1212124712629440612", 'Overwrite ID parsed';
};

subtest 'Guild Parsing (rest_get_guild.json)' => {
    my $guild-json = "t/fixtures/rest_get_guild.json".IO.slurp;
    my $guild-data = from-json($guild-json);
    
    my $guild = Dusk::Model::Guild.new(|$guild-data);
    
    isa-ok $guild, Dusk::Model::Guild, 'Can instantiate a Guild';
    is $guild.id, "1212124712629440612", 'Guild ID parsed correctly';
    is $guild.name, "Test Server", 'Guild name parsed correctly';
    is $guild.owner-id, "383221796700291082", 'Guild owner ID parsed correctly';
    is $guild.verification-level, 0, 'Verification level parsed correctly';
};

# === DEFENSIVE PARSING TESTS ===

subtest 'Defensive: Channel with missing optional fields' => {
    lives-ok {
        my $ch = Dusk::Model::Channel.new(id => '1', name => 'test', type => 0);
        is $ch.guild-id, '', 'Missing guild-id defaults to empty string';
        isa-ok $ch.id, Str, 'id is typed as Str';
        isa-ok $ch.type, Int, 'type is typed as Int';
    }, 'Channel survives missing optional fields';
};

subtest 'Defensive: User with minimal data (only id)' => {
    lives-ok {
        my $user = Dusk::Model::User.new(id => '12345');
        is $user.username, '', 'Missing username defaults to empty string';
        is $user.discriminator, '', 'Missing discriminator defaults to empty string';
        is $user.bot, False, 'Missing bot defaults to False';
        isa-ok $user.id, Str, 'id is typed as Str';
    }, 'User survives minimal data';
};

subtest 'Defensive: Guild with null verification_level' => {
    lives-ok {
        my $guild = Dusk::Model::Guild.new(
            id => '1', name => 'Test', verification_level => Any
        );
        is $guild.verification-level, 0, 'Null verification_level coerced to 0';
        is $guild.owner-id, '', 'Missing owner-id defaults to empty string';
    }, 'Guild survives null fields';
};

subtest 'Defensive: Message without author' => {
    lives-ok {
        my $msg = Dusk::Model::Message.new(
            id => '1', channel_id => '2', content => 'test'
        );
        is $msg.content, 'test', 'Content parsed correctly';
        is $msg.channel-id, '2', 'Channel ID parsed correctly';
    }, 'Message survives missing author';
};

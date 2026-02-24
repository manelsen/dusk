use v6.d;
use Test;
use JSON::Fast;

plan 3;

use Dusk::Model::Message;
use Dusk::Model::Channel;
use Dusk::Model::User;
use Dusk::Model::Guild;

subtest 'Message Parsing (rest_create_message.json)' => {
    my $msg-json = "t/fixtures/rest_create_message.json".IO.slurp;
    my $msg-data = from-json($msg-json);
    
    my $msg = Dusk::Model::Message.new(
        id           => $msg-data[0]<id>,
        channel_id   => $msg-data[0]<channel_id>,
        content      => $msg-data[0]<content>,
        author       => $msg-data[0]<author>
    );
    
    isa-ok $msg, Dusk::Model::Message, 'Can instantiate a Message';
    is $msg.id, "1472053869558239494", 'Message ID parsed correctly';
    is $msg.content, "[Accord.jl integration test — this message will be deleted]", 'Message content parsed correctly';
    is $msg.channel-id, "1212124713271304246", 'Channel ID parsed correctly';
    
    isa-ok $msg.author, Dusk::Model::User, 'Author is parsed into User model';
    is $msg.author.id, "1470119116374282333", 'Author ID correct';
    is $msg.author.username, "Bellegendas Premium", 'Author username correct';
    is $msg.author.discriminator, "7281", 'Author discriminator correct';
};

subtest 'Channel Parsing (rest_get_channel.json)' => {
    my $channel-json = "t/fixtures/rest_get_channel.json".IO.slurp;
    my $channel-data = from-json($channel-json);
    
    my $channel = Dusk::Model::Channel.new(
        id        => $channel-data[0]<id>,
        name      => $channel-data[0]<name>,
        type      => $channel-data[0]<type> // 0,
        guild_id  => $channel-data[0]<guild_id> // ''
    );
    
    isa-ok $channel, Dusk::Model::Channel, 'Can instantiate a Channel';
    is $channel.id, "1212124713271304246", 'Channel ID parsed correctly';
    is $channel.name, "geral", 'Channel name parsed correctly';
    is $channel.type, 0, 'Channel type parsed correctly (GUILD_TEXT)';
    is $channel.guild-id, "1212124712629440612", 'Guild ID parsed correctly';
};

subtest 'Guild Parsing (rest_get_guild.json)' => {
    my $guild-json = "t/fixtures/rest_get_guild.json".IO.slurp;
    my $guild-data = from-json($guild-json);
    
    my $guild = Dusk::Model::Guild.new(
        id                 => $guild-data[0]<id>,
        name               => $guild-data[0]<name>,
        owner_id           => $guild-data[0]<owner_id> // '',
        verification_level => $guild-data[0]<verification_level> // 0
    );
    
    isa-ok $guild, Dusk::Model::Guild, 'Can instantiate a Guild';
    is $guild.id, "1212124712629440612", 'Guild ID parsed correctly';
    is $guild.name, "Server Teste", 'Guild name parsed correctly';
    is $guild.owner-id, "383221796700291082", 'Guild owner ID parsed correctly';
    is $guild.verification-level, 0, 'Verification level parsed correctly';
};

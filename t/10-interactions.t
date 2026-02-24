use v6.d;
use Test;
use JSON::Fast;

plan 5;

use Dusk::Interaction::Command;
use Dusk::Interaction::Response;
use Dusk::Component;

subtest 'Command builder: basic slash command' => {
    my $cmd = Dusk::Interaction::Command.new(
        name => 'ping',
        description => 'Check bot latency',
    );

    my %h = $cmd.to-hash;
    is %h<name>, 'ping', 'Name correct';
    is %h<description>, 'Check bot latency', 'Description correct';
    is %h<type>, 1, 'Default type is CHAT_INPUT (1)';
    nok %h<options>:exists, 'No options when empty';
};

subtest 'Command builder: with options and sub-commands' => {
    my $cmd = Dusk::Interaction::Command.new(
        name => 'config',
        description => 'Bot configuration',
    ).add-option(
        name => 'channel',
        description => 'Target channel',
        type => OPTION_CHANNEL,
        required => True,
    ).add-option(
        name => 'verbose',
        description => 'Verbose output',
        type => OPTION_BOOLEAN,
    );

    my %h = $cmd.to-hash;
    is %h<options>.elems, 2, 'Two options';
    is %h<options>[0]<name>, 'channel', 'First option name';
    is %h<options>[0]<type>, OPTION_CHANNEL, 'First option type is CHANNEL';
    ok %h<options>[0]<required>, 'First option is required';
    nok %h<options>[1]<required>, 'Second option is not required';
};

subtest 'Response builders' => {
    my %reply = Dusk::Interaction::Response.reply("Pong!");
    is %reply<type>, 4, 'Reply type is CHANNEL_MESSAGE (4)';
    is %reply<data><content>, 'Pong!', 'Content correct';

    my %eph = Dusk::Interaction::Response.ephemeral("Secret");
    is %eph<data><flags>, 64, 'Ephemeral flag is 64';

    my %defer = Dusk::Interaction::Response.defer;
    is %defer<type>, 5, 'Defer type is DEFERRED_MESSAGE (5)';

    my %modal = Dusk::Interaction::Response.modal(
        custom-id => 'feedback',
        title => 'Give Feedback',
        components => [Dusk::Component.action-row([
            Dusk::Component.text-input(custom-id => 'text', label => 'Your feedback', style => INPUT_PARAGRAPH)
        ])],
    );
    is %modal<type>, 9, 'Modal type is 9';
    is %modal<data><title>, 'Give Feedback', 'Modal title correct';
};

subtest 'Component builders: buttons and selects' => {
    my %btn = Dusk::Component.button(label => 'Click me', custom-id => 'btn1', style => STYLE_SUCCESS);
    is %btn<type>, 2, 'Button type is 2';
    is %btn<style>, STYLE_SUCCESS, 'Style is SUCCESS (3)';
    is %btn<label>, 'Click me', 'Label correct';

    my %link = Dusk::Component.link-button(label => 'Docs', url => 'https://example.com');
    is %link<style>, STYLE_LINK, 'Link button style is 5';
    is %link<url>, 'https://example.com', 'URL correct';

    my %sel = Dusk::Component.string-select(
        custom-id => 'color',
        placeholder => 'Pick a color',
        options => [
            Dusk::Component.select-option(label => 'Red', value => 'red'),
            Dusk::Component.select-option(label => 'Blue', value => 'blue', default => True),
        ],
    );
    is %sel<type>, 3, 'String select type is 3';
    is %sel<options>.elems, 2, 'Two options';
    ok %sel<options>[1]<default>, 'Second option is default';
};

subtest 'Parse interaction fixture (gateway_interaction_create.json)' => {
    my @data = from-json("t/fixtures/gateway_interaction_create.json".IO.slurp);

    is @data.elems, 2, 'Fixture has 2 interactions';

    my $first = @data[0]<d>;
    is $first<data><name>, 'ping', 'First command is /ping';
    is $first<data><type>, 1, 'Type is CHAT_INPUT';
    is $first<guild_id>, '1212124712629440612', 'Guild ID present';
    is $first<member><user><username>, 'voiddragon', 'Member user parsed';

    my $second = @data[1]<d>;
    is $second<data><name>, 'pingephemeral', 'Second command is /pingephemeral';
};

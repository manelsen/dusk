use v6.d;
use Test;
use JSON::Fast;

plan 3;

use Dusk::Event::Events;
use Dusk::Gateway::Payload;
use Dusk::Gateway::Dispatcher;

subtest 'Parse READY event model' => {
    my @data = from-json("t/fixtures/gateway_ready.json".IO.slurp);
    my $ready = Dusk::Event::Events::Ready.new(raw => @data[0]<d>);

    ok $ready ~~ Dusk::Event, 'Does the Dusk::Event role';
    is $ready.v, 10, 'Version is 10';
    is $ready.session-id, @data[0]<d><session_id>, 'session_id matches';
    is $ready.user.username, 'Bellegendas Premium', 'Typed User model works';
    is $ready.guilds.elems, 2, '2 guilds returned';
};

subtest 'Parse MESSAGE_CREATE event model' => {
    my @data = from-json("t/fixtures/gateway_message_create.json".IO.slurp);
    my $ev = Dusk::Event::Events::MessageCreate.new(raw => @data[0]<d>);

    ok $ev ~~ Dusk::Event, 'Does the Dusk::Event role';
    is $ev.guild-id, '1212124712629440612', 'guild-id parsed';

    my $msg = $ev.message;
    is $msg.^name, 'Dusk::Model::Message', 'Returns Dusk::Model::Message';
    is $msg.id, '1472053922800734339', 'Message ID correct';
    is $msg.author.username, 'voiddragon', 'Author username correct';
};

subtest 'Dispatcher emits strongly typed Events' => {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);

    my $received;
    my $tap = $dispatcher.on-interaction-create.tap: -> $ev {
        $received = $ev;
    };

    my @data = from-json("t/fixtures/gateway_interaction_create.json".IO.slurp);
    my $payload = Dusk::Gateway::Payload.from-json(@data[0]);
    $supplier.emit($payload);

    sleep 0.1;
    $tap.close;

    ok $received.defined, 'Received event';
    is $received.^name, 'Dusk::Event::Events::InteractionCreate', 'Emitted strong type';
    
    my $interaction = $received.interaction;
    is $interaction.data.name, 'ping', 'Interaction data name correct';
    is $interaction.user.username, 'voiddragon', 'User model correct';
};

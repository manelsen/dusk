use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Channel;
use Dusk::Model::AutoModRule;
use Dusk::Model::ScheduledEvent;

plan 3;

subtest 'Upgraded Channel Parsing' => {
    my $json = "t/fixtures/rest_get_channel.json".IO.slurp;
    my $data = from-json($json);
    
    my $ch = Dusk::Model::Channel.new(|$data[0]);
    
    is $ch.name, "general", 'Name parsed';
    is $ch.position, 0, 'Position parsed';
    is $ch.rate-limit-per-user, 0, 'Rate limit parsed';
    is $ch.parent-id, "1212124713271304243", 'Parent ID parsed';
};

subtest 'AutoMod Rule Parsing' => {
    my $json = "t/fixtures/rest_automod.json".IO.slurp;
    my $data = from-json($json);
    
    my $rule = Dusk::Model::AutoModRule.new(|$data[0]);
    
    is $rule.name, "Block Links", 'Name parsed';
    ok $rule.enabled, 'Enabled is true';
    is $rule.trigger-metadata<keyword_filter>[0], "http://*", 'Metadata parsed';
    is $rule.actions[0]<type>, 1, 'Action type parsed';
};

subtest 'Scheduled Event Parsing' => {
    my $json = "t/fixtures/rest_scheduled_event.json".IO.slurp;
    my $data = from-json($json);
    
    my $ev = Dusk::Model::ScheduledEvent.new(|$data[0]);
    
    is $ev.name, "Live Q&A", 'Name parsed';
    is $ev.scheduled-start-time, "2026-03-01T18:00:00.000000+00:00", 'Time parsed';
    is $ev.status, 1, 'Status parsed';
};

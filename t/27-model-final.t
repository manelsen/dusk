use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::VoiceState;
use Dusk::Model::Presence;
use Dusk::Model::Activity;

plan 2;

subtest 'Voice State Parsing' => {
    my $json = "t/fixtures/rest_voice_state.json".IO.slurp;
    my $data = from-json($json);
    
    my $vs = Dusk::Model::VoiceState.new(|$data[0]);
    
    is $vs.user-id, "383221796700291082", 'User ID parsed';
    ok $vs.self-deaf, 'Self deaf is true';
    is $vs.session-id, "a-voice-session-id", 'Session ID parsed';
};

subtest 'Presence & Activity Parsing' => {
    my $json = "t/fixtures/rest_presence.json".IO.slurp;
    my $data = from-json($json);
    
    my $presence = Dusk::Model::Presence.new(|$data[0]);
    
    is $presence.status, "online", 'Status parsed';
    is $presence.activities.elems, 1, 'Activities list size correct';
    isa-ok $presence.activities[0], Dusk::Model::Activity, 'Activity is correct type';
    is $presence.activities[0].name, "Dusk Development", 'Activity name parsed';
    is $presence.client-status<desktop>, "online", 'Client status parsed';
};

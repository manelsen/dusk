use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Invite;
use Dusk::Model::Webhook;
use Dusk::Model::Application;

plan 3;

subtest 'Invite Parsing' => {
    my $json = "t/fixtures/rest_invite.json".IO.slurp;
    my $data = from-json($json);
    
    my $invite = Dusk::Model::Invite.new(|$data[0]);
    
    is $invite.code, "dusk-test", 'Code parsed';
    is $invite.guild.name, "Test Server", 'Nested guild parsed';
    is $invite.channel.name, "general", 'Nested channel parsed';
};

subtest 'Webhook Parsing' => {
    my $json = "t/fixtures/rest_webhook.json".IO.slurp;
    my $data = from-json($json);
    
    my $webhook = Dusk::Model::Webhook.new(|$data[0]);
    
    is $webhook.name, "Test Webhook", 'Name parsed';
    is $webhook.token, "webhook-token-here", 'Token parsed';
    is $webhook.type, 1, 'Type parsed';
};

subtest 'Application Parsing' => {
    my $json = "t/fixtures/rest_application.json".IO.slurp;
    my $data = from-json($json);
    
    my $app = Dusk::Model::Application.new(|$data[0]);
    
    is $app.name, "Dusk Bot", 'Name parsed';
    ok $app.bot-public, 'Bot public is true';
    is $app.owner.username, "micelio", 'Owner parsed';
};

use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Interaction;
use Dusk::Model::InteractionData;
use Dusk::Model::Member;
use Dusk::Model::User;

plan 1;

subtest 'Interaction Parsing' => {
    my $json = "t/fixtures/rest_interaction.json".IO.slurp;
    my $data = from-json($json);
    
    my $interaction = Dusk::Model::Interaction.new(|$data[0]);
    
    isa-ok $interaction, Dusk::Model::Interaction, 'Correct type';
    is $interaction.id, "123456789012345678", 'ID parsed';
    is $interaction.type, 2, 'Type parsed (APPLICATION_COMMAND)';
    is $interaction.token, "a-very-long-interaction-token", 'Token parsed';
    
    isa-ok $interaction.data, Dusk::Model::InteractionData, 'Nested data is correct type';
    is $interaction.data.name, 'echo', 'Command name parsed';
    is $interaction.data.options[0]<value>, 'hello world', 'Command option value parsed';
    
    isa-ok $interaction.member, Dusk::Model::Member, 'Nested member is correct type';
    is $interaction.member.user.username, 'micelio', 'Member user username parsed';
    is $interaction.guild-id, "1212124712629440612", 'Guild ID parsed';
};

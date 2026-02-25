use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Role;

plan 1;

subtest 'Role Parsing' => {
    my $json = "t/fixtures/rest_role.json".IO.slurp;
    my $data = from-json($json);
    
    my $role = Dusk::Model::Role.new(|$data[0]);
    
    isa-ok $role, Dusk::Model::Role, 'Correct type';
    is $role.id, "1470125745056518333", 'ID parsed';
    is $role.name, "Moderator", 'Name parsed';
    is $role.color, 3447003, 'Color parsed';
    ok $role.hoist, 'Hoist is true';
    is $role.position, 10, 'Position parsed';
    is $role.permissions, "1071698660929", 'Permissions parsed';
    nok $role.managed, 'Managed is false';
    ok $role.mentionable, 'Mentionable is true';
};

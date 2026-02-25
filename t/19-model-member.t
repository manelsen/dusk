use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Member;
use Dusk::Model::User;

plan 1;

subtest 'Member Parsing' => {
    my $json = "t/fixtures/rest_member.json".IO.slurp;
    my $data = from-json($json);
    
    my $member = Dusk::Model::Member.new(|$data[0]);
    
    isa-ok $member, Dusk::Model::Member, 'Correct type';
    isa-ok $member.user, Dusk::Model::User, 'Nested user is correct type';
    is $member.user.username, 'micelio', 'Username parsed';
    is $member.nick, 'The Dev', 'Nick parsed';
    is $member.roles.elems, 2, 'Roles array size correct';
    is $member.roles[0], "1470125745056518333", 'First role correct';
    is $member.joined-at, "2026-02-01T12:00:00.000000+00:00", 'Joined at parsed';
    nok $member.deaf, 'Deaf is false';
    is $member.permissions, "2248473465835073", 'Permissions parsed';
};

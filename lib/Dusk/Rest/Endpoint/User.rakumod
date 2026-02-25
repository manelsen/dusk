use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::User does Dusk::Rest::Endpoint::Base;

method delete-lobbies-members(:$lobby-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/lobbies/$lobby-id/members/$user-id],
    );
}

method get-invites-target-users(:$invite-code!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/invites/$invite-code/target-users],
    );
}

method get-invites-target-users-job-status(:$invite-code!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/invites/$invite-code/target-users/job-status],
    );
}

method get-oauth2-me() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/oauth2/@me],
    );
}

method get-oauth2-applications-me() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/oauth2/applications/@me],
    );
}

method get-users-me() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me],
    );
}

method get-users-me-applications-role-connection(:$application-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me/applications/$application-id/role-connection],
    );
}

method get-users-me-connections() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me/connections],
    );
}

method get-user(:$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/$user-id],
    );
}

method patch-users-me(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/users/@me],
        body   => %body,
    );
}

method put-invites-target-users(:$invite-code!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/invites/$invite-code/target-users],
        body   => %body,
    );
}

method put-lobbies-members(:$lobby-id!, :$user-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/lobbies/$lobby-id/members/$user-id],
        body   => %body,
    );
}

method put-users-me-applications-role-connection(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/users/@me/applications/$application-id/role-connection],
        body   => %body,
    );
}
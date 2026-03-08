use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::User does Dusk::Rest::Endpoint::Base;

#| Returns the user object of the requester's account.
method get-users-me() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me],
    );
}

#| Returns a user object for a given user ID.
method get-user(:$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/$user-id],
    );
}

#| Modify the requester's user account settings.
method patch-users-me(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/users/@me],
        body   => %body,
    );
}

#| Returns a list of connection objects for the requester.
method get-users-me-connections() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me/connections],
    );
}

method get-users-me-applications-role-connection(:$application-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me/applications/$application-id/role-connection],
    );
}

method put-users-me-applications-role-connection(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/users/@me/applications/$application-id/role-connection],
        body   => %body,
    );
}
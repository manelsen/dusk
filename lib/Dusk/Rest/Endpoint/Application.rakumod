use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::Application does Dusk::Rest::Endpoint::Base;

method delete-applications-commands(:$application-id!, :$command-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/applications/$application-id/commands/$command-id],
    );
}

method delete-applications-emojis(:$application-id!, :$emoji-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/applications/$application-id/emojis/$emoji-id],
    );
}

method delete-applications-entitlements(:$application-id!, :$entitlement-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/applications/$application-id/entitlements/$entitlement-id],
    );
}

method get-applications-me() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/@me],
    );
}

method get-applications-activity-instance(:$application-id!, :$instance-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/activity-instances/$instance-id],
    );
}

method get-applications-commands(:$application-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/commands],
    );
}

method get-applications-command(:$application-id!, :$command-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/commands/$command-id],
    );
}

method get-applications-emojis(:$application-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/emojis],
    );
}

method get-applications-emoji(:$application-id!, :$emoji-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/emojis/$emoji-id],
    );
}

method get-applications-entitlements(:$application-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/entitlements],
    );
}

method get-applications-entitlement(:$application-id!, :$entitlement-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/entitlements/$entitlement-id],
    );
}

method get-applications-role-connections-metadata(:$application-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/role-connections/metadata],
    );
}

method get-applications-skus(:$application-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/skus],
    );
}

method get-skus-subscriptions(:$sku-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/skus/$sku-id/subscriptions],
    );
}

method get-skus-subscription(:$sku-id!, :$subscription-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/skus/$sku-id/subscriptions/$subscription-id],
    );
}

method patch-applications-me(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/applications/@me],
        body   => %body,
    );
}

method patch-applications-commands(:$application-id!, :$command-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/applications/$application-id/commands/$command-id],
        body   => %body,
    );
}

method patch-applications-emojis(:$application-id!, :$emoji-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/applications/$application-id/emojis/$emoji-id],
        body   => %body,
    );
}

method post-applications-commands(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/applications/$application-id/commands],
        body   => %body,
    );
}

method post-applications-emojis(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/applications/$application-id/emojis],
        body   => %body,
    );
}

method post-applications-entitlements(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/applications/$application-id/entitlements],
        body   => %body,
    );
}

method post-applications-entitlements-consume(:$application-id!, :$entitlement-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/applications/$application-id/entitlements/$entitlement-id/consume],
        body   => %body,
    );
}

method put-applications-commands(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/applications/$application-id/commands],
        body   => %body,
    );
}

method put-applications-role-connections-metadata(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/applications/$application-id/role-connections/metadata],
        body   => %body,
    );
}
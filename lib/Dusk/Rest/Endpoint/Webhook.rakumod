use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::Webhook does Dusk::Rest::Endpoint::Base;

method delete-webhooks-messagesoriginal(:$application-id!, :$interaction-token!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/webhooks/$application-id/$interaction-token/messages/@original],
    );
}

method delete-webhooks-messages(:$application-id!, :$interaction-token!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/webhooks/$application-id/$interaction-token/messages/$message-id],
    );
}

method delete-webhooks(:$webhook-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/webhooks/$webhook-id],
    );
}

method delete-webhooksX2(:$webhook-id!, :$webhook-token!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/webhooks/$webhook-id/$webhook-token],
    );
}

method delete-webhooks-messagesX2(:$webhook-id!, :$webhook-token!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/webhooks/$webhook-id/$webhook-token/messages/$message-id],
    );
}

method get-channels-webhooks(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/webhooks],
    );
}

method get-guilds-webhooks(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/webhooks],
    );
}

method get-webhooks-messagesoriginal(:$application-id!, :$interaction-token!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/webhooks/$application-id/$interaction-token/messages/@original],
    );
}

method get-webhooks-message(:$application-id!, :$interaction-token!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/webhooks/$application-id/$interaction-token/messages/$message-id],
    );
}

method get-webhook(:$webhook-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/webhooks/$webhook-id],
    );
}

method get-webhookX2(:$webhook-id!, :$webhook-token!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/webhooks/$webhook-id/$webhook-token],
    );
}

method get-webhooks-messageX2(:$webhook-id!, :$webhook-token!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/webhooks/$webhook-id/$webhook-token/messages/$message-id],
    );
}

method patch-webhooks-messagesoriginal(:$application-id!, :$interaction-token!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/webhooks/$application-id/$interaction-token/messages/@original],
        body   => %body,
    );
}

method patch-webhooks-messages(:$application-id!, :$interaction-token!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/webhooks/$application-id/$interaction-token/messages/$message-id],
        body   => %body,
    );
}

method patch-webhooks(:$webhook-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/webhooks/$webhook-id],
        body   => %body,
    );
}

method patch-webhooksX2(:$webhook-id!, :$webhook-token!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/webhooks/$webhook-id/$webhook-token],
        body   => %body,
    );
}

method patch-webhooks-messagesX2(:$webhook-id!, :$webhook-token!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/webhooks/$webhook-id/$webhook-token/messages/$message-id],
        body   => %body,
    );
}

method post-channels-webhooks(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/webhooks],
        body   => %body,
    );
}

method post-webhooks(:$application-id!, :$interaction-token!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/webhooks/$application-id/$interaction-token],
        body   => %body,
    );
}

method post-webhooksX2(:$webhook-id!, :$webhook-token!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/webhooks/$webhook-id/$webhook-token],
        body   => %body,
    );
}

method post-webhooks-github(:$webhook-id!, :$webhook-token!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/webhooks/$webhook-id/$webhook-token/github],
        body   => %body,
    );
}

method post-webhooks-slack(:$webhook-id!, :$webhook-token!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/webhooks/$webhook-id/$webhook-token/slack],
        body   => %body,
    );
}
use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::Misc does Dusk::Rest::Endpoint::Base;

method delete-invites(:$invite-code!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/invites/$invite-code],
    );
}

method delete-lobbies(:$lobby-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/lobbies/$lobby-id],
    );
}

method delete-lobbies-members-me(:$lobby-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/lobbies/$lobby-id/members/@me],
    );
}

method get-gateway() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/gateway],
    );
}

method get-gateway-bot() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/gateway/bot],
    );
}

method get-invite(:$invite-code!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/invites/$invite-code],
    );
}

method get-lobbie(:$lobby-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/lobbies/$lobby-id],
    );
}

method get-soundboard-default-sounds() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/soundboard-default-sounds],
    );
}

method get-sticker-packs() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/sticker-packs],
    );
}

method get-sticker-pack(:$pack-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/sticker-packs/$pack-id],
    );
}

method get-sticker(:$sticker-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/stickers/$sticker-id],
    );
}

method get-voice-regions() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/voice/regions],
    );
}

method patch-lobbies(:$lobby-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/lobbies/$lobby-id],
        body   => %body,
    );
}

method post-interactions-callback(:$interaction-id!, :$interaction-token!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/interactions/$interaction-id/$interaction-token/callback],
        body   => %body,
    );
}

method post-lobbies(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/lobbies],
        body   => %body,
    );
}

method post-stage-instances(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/stage-instances],
        body   => %body,
    );
}
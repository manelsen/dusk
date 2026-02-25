use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::Channel does Dusk::Rest::Endpoint::Base;

method delete-channels(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id],
    );
}

method delete-channels-messages-pins(:$channel-id!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/messages/pins/$message-id],
    );
}

method delete-channels-messages(:$channel-id!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/messages/$message-id],
    );
}

method delete-channels-messages-reactions(:$channel-id!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/messages/$message-id/reactions],
    );
}

method delete-channels-messages-reactionsX2(:$channel-id!, :$message-id!, :$emoji-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/messages/$message-id/reactions/$emoji-id],
    );
}

method delete-channels-messages-reactions-me(:$channel-id!, :$message-id!, :$emoji-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/messages/$message-id/reactions/$emoji-id/@me],
    );
}

method delete-channels-messages-reactionsX3(:$channel-id!, :$message-id!, :$emoji-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/messages/$message-id/reactions/$emoji-id/$user-id],
    );
}

method delete-channels-permissions(:$channel-id!, :$overwrite-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/permissions/$overwrite-id],
    );
}

method delete-channels-pins(:$channel-id!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/pins/$message-id],
    );
}

method delete-channels-recipients(:$channel-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/recipients/$user-id],
    );
}

method delete-channels-thread-members-me(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/thread-members/@me],
    );
}

method delete-channels-thread-members(:$channel-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/channels/$channel-id/thread-members/$user-id],
    );
}

method delete-stage-instances(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/stage-instances/$channel-id],
    );
}

method get-channel(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method       => 'GET',
        path         => qq[/channels/$channel-id],
        target-model => Dusk::Model::Channel,
    );
}

method get-channels-invites(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/invites],
    );
}

method get-channels-messages(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/messages],
    );
}

method get-channels-messages-pins(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/messages/pins],
    );
}

method get-channels-message(:$channel-id!, :$message-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/messages/$message-id],
    );
}

method get-channels-messages-reaction(:$channel-id!, :$message-id!, :$emoji-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/messages/$message-id/reactions/$emoji-id],
    );
}

method get-channels-pins(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/pins],
    );
}

method get-channels-polls-answer(:$channel-id!, :$message-id!, :$answer-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/polls/$message-id/answers/$answer-id],
    );
}

method get-channels-thread-members(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/thread-members],
    );
}

method get-channels-thread-member(:$channel-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/thread-members/$user-id],
    );
}

method get-channels-threads-archived-private(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/threads/archived/private],
    );
}

method get-channels-threads-archived-public(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/threads/archived/public],
    );
}

method get-channels-users-me-threads-archived-private(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/users/@me/threads/archived/private],
    );
}

method get-stage-instance(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/stage-instances/$channel-id],
    );
}

method patch-channels(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/channels/$channel-id],
        body   => %body,
    );
}

method patch-channels-messages(:$channel-id!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/channels/$channel-id/messages/$message-id],
        body   => %body,
    );
}

method patch-lobbies-channel-linking(:$lobby-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/lobbies/$lobby-id/channel-linking],
        body   => %body,
    );
}

method patch-stage-instances(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/stage-instances/$channel-id],
        body   => %body,
    );
}

method post-channels-followers(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/followers],
        body   => %body,
    );
}

method post-channels-invites(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/invites],
        body   => %body,
    );
}

method post-channels-messages(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method       => 'POST',
        path         => qq[/channels/$channel-id/messages],
        body         => %body,
        target-model => Dusk::Model::Message,
    );
}

method post-channels-messages-bulk-delete(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/messages/bulk-delete],
        body   => %body,
    );
}

method post-channels-messages-crosspost(:$channel-id!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/messages/$message-id/crosspost],
        body   => %body,
    );
}

method post-channels-messages-threads(:$channel-id!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/messages/$message-id/threads],
        body   => %body,
    );
}

method post-channels-polls-expire(:$channel-id!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/polls/$message-id/expire],
        body   => %body,
    );
}

method post-channels-send-soundboard-sound(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/send-soundboard-sound],
        body   => %body,
    );
}

method post-channels-threads(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/threads],
        body   => %body,
    );
}

method post-channels-typing(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/typing],
        body   => %body,
    );
}

method post-users-me-channels(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/users/@me/channels],
        body   => %body,
    );
}

method put-channels-messages-pins(:$channel-id!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/channels/$channel-id/messages/pins/$message-id],
        body   => %body,
    );
}

method put-channels-messages-reactions-me(:$channel-id!, :$message-id!, :$emoji-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/channels/$channel-id/messages/$message-id/reactions/$emoji-id/@me],
        body   => %body,
    );
}

method put-channels-permissions(:$channel-id!, :$overwrite-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/channels/$channel-id/permissions/$overwrite-id],
        body   => %body,
    );
}

method put-channels-pins(:$channel-id!, :$message-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/channels/$channel-id/pins/$message-id],
        body   => %body,
    );
}

method put-channels-recipients(:$channel-id!, :$user-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/channels/$channel-id/recipients/$user-id],
        body   => %body,
    );
}

method put-channels-thread-members-me(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/channels/$channel-id/thread-members/@me],
        body   => %body,
    );
}

method put-channels-thread-members(:$channel-id!, :$user-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/channels/$channel-id/thread-members/$user-id],
        body   => %body,
    );
}
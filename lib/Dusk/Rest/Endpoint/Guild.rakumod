use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::Guild does Dusk::Rest::Endpoint::Base;

method delete-applications-guilds-commands(:$application-id!, :$guild-id!, :$command-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/$command-id],
    );
}

method delete-guilds-auto-moderation-rules(:$guild-id!, :$auto-moderation-rule-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/auto-moderation/rules/$auto-moderation-rule-id],
    );
}

method delete-guilds-bans(:$guild-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/bans/$user-id],
    );
}

method delete-guilds-emojis(:$guild-id!, :$emoji-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/emojis/$emoji-id],
    );
}

method delete-guilds-integrations(:$guild-id!, :$integration-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/integrations/$integration-id],
    );
}

method delete-guilds-members(:$guild-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/members/$user-id],
    );
}

method delete-guilds-members-roles(:$guild-id!, :$user-id!, :$role-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/members/$user-id/roles/$role-id],
    );
}

method delete-guilds-roles(:$guild-id!, :$role-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/roles/$role-id],
    );
}

method delete-guilds-scheduled-events(:$guild-id!, :$guild-scheduled-event-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/scheduled-events/$guild-scheduled-event-id],
    );
}

method delete-guilds-soundboard-sounds(:$guild-id!, :$sound-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/soundboard-sounds/$sound-id],
    );
}

method delete-guilds-stickers(:$guild-id!, :$sticker-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/stickers/$sticker-id],
    );
}

method delete-guilds-templates(:$guild-id!, :$template-code!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/guilds/$guild-id/templates/$template-code],
    );
}

method delete-users-me-guilds(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/users/@me/guilds/$guild-id],
    );
}

method get-applications-guilds-commands(:$application-id!, :$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands],
    );
}

method get-applications-guilds-commands-permissions(:$application-id!, :$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/permissions],
    );
}

method get-applications-guilds-command(:$application-id!, :$guild-id!, :$command-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/$command-id],
    );
}

method get-applications-guilds-commands-permissionsX2(:$application-id!, :$guild-id!, :$command-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/$command-id/permissions],
    );
}

method get-guilds-template(:$template-code!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/templates/$template-code],
    );
}

method get-guild(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id],
    );
}

method get-guilds-audit-logs(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/audit-logs],
    );
}

method get-guilds-auto-moderation-rules(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/auto-moderation/rules],
    );
}

method get-guilds-auto-moderation-rule(:$guild-id!, :$auto-moderation-rule-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/auto-moderation/rules/$auto-moderation-rule-id],
    );
}

method get-guilds-bans(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/bans],
    );
}

method get-guilds-ban(:$guild-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/bans/$user-id],
    );
}

method get-guilds-channels(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/channels],
    );
}

method get-guilds-emojis(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/emojis],
    );
}

method get-guilds-emoji(:$guild-id!, :$emoji-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/emojis/$emoji-id],
    );
}

method get-guilds-integrations(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/integrations],
    );
}

method get-guilds-invites(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/invites],
    );
}

method get-guilds-members(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/members],
    );
}

method get-guilds-members-search(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/members/search],
    );
}

method get-guilds-member(:$guild-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/members/$user-id],
    );
}

method get-guilds-onboarding(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/onboarding],
    );
}

method get-guilds-preview(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/preview],
    );
}

method get-guilds-prune(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/prune],
    );
}

method get-guilds-regions(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/regions],
    );
}

method get-guilds-roles(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/roles],
    );
}

method get-guilds-roles-member-counts(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/roles/member-counts],
    );
}

method get-guilds-role(:$guild-id!, :$role-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/roles/$role-id],
    );
}

method get-guilds-scheduled-events(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/scheduled-events],
    );
}

method get-guilds-scheduled-event(:$guild-id!, :$guild-scheduled-event-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/scheduled-events/$guild-scheduled-event-id],
    );
}

method get-guilds-scheduled-events-users(:$guild-id!, :$guild-scheduled-event-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/scheduled-events/$guild-scheduled-event-id/users],
    );
}

method get-guilds-soundboard-sounds(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/soundboard-sounds],
    );
}

method get-guilds-soundboard-sound(:$guild-id!, :$sound-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/soundboard-sounds/$sound-id],
    );
}

method get-guilds-stickers(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/stickers],
    );
}

method get-guilds-sticker(:$guild-id!, :$sticker-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/stickers/$sticker-id],
    );
}

method get-guilds-templates(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/templates],
    );
}

method get-guilds-threads-active(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/threads/active],
    );
}

method get-guilds-vanity-url(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/vanity-url],
    );
}

method get-guilds-voice-states-me(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/voice-states/@me],
    );
}

method get-guilds-voice-state(:$guild-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/voice-states/$user-id],
    );
}

method get-guilds-welcome-screen(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/welcome-screen],
    );
}

method get-guilds-widget(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/widget],
    );
}

method get-guilds-widgetjson(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/widget.json],
    );
}

method get-guilds-widgetpng(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/widget.png],
    );
}

method get-users-me-guilds() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me/guilds],
    );
}

method get-users-me-guilds-member(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/@me/guilds/$guild-id/member],
    );
}

method patch-applications-guilds-commands(:$application-id!, :$guild-id!, :$command-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/$command-id],
        body   => %body,
    );
}

method patch-guilds(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id],
        body   => %body,
    );
}

method patch-guilds-auto-moderation-rules(:$guild-id!, :$auto-moderation-rule-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/auto-moderation/rules/$auto-moderation-rule-id],
        body   => %body,
    );
}

method patch-guilds-channels(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/channels],
        body   => %body,
    );
}

method patch-guilds-emojis(:$guild-id!, :$emoji-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/emojis/$emoji-id],
        body   => %body,
    );
}

method patch-guilds-members-me(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/members/@me],
        body   => %body,
    );
}

method patch-guilds-members-me-nick(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/members/@me/nick],
        body   => %body,
    );
}

method patch-guilds-members(:$guild-id!, :$user-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/members/$user-id],
        body   => %body,
    );
}

method patch-guilds-roles(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/roles],
        body   => %body,
    );
}

method patch-guilds-rolesX2(:$guild-id!, :$role-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/roles/$role-id],
        body   => %body,
    );
}

method patch-guilds-scheduled-events(:$guild-id!, :$guild-scheduled-event-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/scheduled-events/$guild-scheduled-event-id],
        body   => %body,
    );
}

method patch-guilds-soundboard-sounds(:$guild-id!, :$sound-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/soundboard-sounds/$sound-id],
        body   => %body,
    );
}

method patch-guilds-stickers(:$guild-id!, :$sticker-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/stickers/$sticker-id],
        body   => %body,
    );
}

method patch-guilds-templates(:$guild-id!, :$template-code!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/templates/$template-code],
        body   => %body,
    );
}

method patch-guilds-voice-states-me(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/voice-states/@me],
        body   => %body,
    );
}

method patch-guilds-voice-states(:$guild-id!, :$user-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/voice-states/$user-id],
        body   => %body,
    );
}

method patch-guilds-welcome-screen(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/welcome-screen],
        body   => %body,
    );
}

method patch-guilds-widget(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/guilds/$guild-id/widget],
        body   => %body,
    );
}

method post-applications-guilds-commands(:$application-id!, :$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands],
        body   => %body,
    );
}

method post-guilds-auto-moderation-rules(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/auto-moderation/rules],
        body   => %body,
    );
}

method post-guilds-bulk-ban(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/bulk-ban],
        body   => %body,
    );
}

method post-guilds-channels(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/channels],
        body   => %body,
    );
}

method post-guilds-emojis(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/emojis],
        body   => %body,
    );
}

method post-guilds-prune(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/prune],
        body   => %body,
    );
}

method post-guilds-roles(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/roles],
        body   => %body,
    );
}

method post-guilds-scheduled-events(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/scheduled-events],
        body   => %body,
    );
}

method post-guilds-soundboard-sounds(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/soundboard-sounds],
        body   => %body,
    );
}

method post-guilds-stickers(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/stickers],
        body   => %body,
    );
}

method post-guilds-templates(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/guilds/$guild-id/templates],
        body   => %body,
    );
}

method put-applications-guilds-commands(:$application-id!, :$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands],
        body   => %body,
    );
}

method put-applications-guilds-commands-permissions(:$application-id!, :$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/permissions],
        body   => %body,
    );
}

method put-applications-guilds-commands-permissionsX2(:$application-id!, :$guild-id!, :$command-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/$command-id/permissions],
        body   => %body,
    );
}

method put-guilds-bans(:$guild-id!, :$user-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/guilds/$guild-id/bans/$user-id],
        body   => %body,
    );
}

method put-guilds-incident-actions(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/guilds/$guild-id/incident-actions],
        body   => %body,
    );
}

method put-guilds-members(:$guild-id!, :$user-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/guilds/$guild-id/members/$user-id],
        body   => %body,
    );
}

method put-guilds-members-roles(:$guild-id!, :$user-id!, :$role-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/guilds/$guild-id/members/$user-id/roles/$role-id],
        body   => %body,
    );
}

method put-guilds-onboarding(:$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/guilds/$guild-id/onboarding],
        body   => %body,
    );
}

method put-guilds-templates(:$guild-id!, :$template-code!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/guilds/$guild-id/templates/$template-code],
        body   => %body,
    );
}
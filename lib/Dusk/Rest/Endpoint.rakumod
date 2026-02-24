use v6.d;
use Dusk::Rest::Route;

unit class Dusk::Rest::Endpoint;

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

method delete-applications-guilds-commands(:$application-id!, :$guild-id!, :$command-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/$command-id],
    );
}

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

method delete-lobbies-members(:$lobby-id!, :$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/lobbies/$lobby-id/members/$user-id],
    );
}

method delete-stage-instances(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/stage-instances/$channel-id],
    );
}

method delete-users-me-guilds(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'DELETE',
        path   => qq[/users/@me/guilds/$guild-id],
    );
}

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

method get-channel(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id],
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

method get-channels-webhooks(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/channels/$channel-id/webhooks],
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

method get-guilds-webhooks(:$guild-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/guilds/$guild-id/webhooks],
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

method get-invite(:$invite-code!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/invites/$invite-code],
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

method get-lobbie(:$lobby-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/lobbies/$lobby-id],
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

method get-soundboard-default-sounds() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/soundboard-default-sounds],
    );
}

method get-stage-instance(:$channel-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/stage-instances/$channel-id],
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

method get-user(:$user-id!) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/users/$user-id],
    );
}

method get-voice-regions() returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'GET',
        path   => qq[/voice/regions],
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

method patch-applications-guilds-commands(:$application-id!, :$guild-id!, :$command-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands/$command-id],
        body   => %body,
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

method patch-lobbies(:$lobby-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/lobbies/$lobby-id],
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

method patch-users-me(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PATCH',
        path   => qq[/users/@me],
        body   => %body,
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

method post-applications-guilds-commands(:$application-id!, :$guild-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/applications/$application-id/guilds/$guild-id/commands],
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
        method => 'POST',
        path   => qq[/channels/$channel-id/messages],
        body   => %body,
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

method post-channels-webhooks(:$channel-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/channels/$channel-id/webhooks],
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

method post-users-me-channels(*%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'POST',
        path   => qq[/users/@me/channels],
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

method put-applications-commands(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/applications/$application-id/commands],
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

method put-applications-role-connections-metadata(:$application-id!, *%body) returns Dusk::Rest::Route {
    return Dusk::Rest::Route.new(
        method => 'PUT',
        path   => qq[/applications/$application-id/role-connections/metadata],
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


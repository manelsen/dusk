use v6.d;
use Test;

plan 219;

use Dusk::Rest::Endpoint;

subtest 'Endpoint: DELETE /applications/{application.id}/commands/{command.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-applications-commands(application-id => 'test-val', command-id => 'test-val') }, 'Method delete-applications-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/applications/test-val/commands/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /applications/{application.id}/emojis/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-applications-emojis(application-id => 'test-val', emoji-id => 'test-val') }, 'Method delete-applications-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/applications/test-val/emojis/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /applications/{application.id}/entitlements/{entitlement.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-applications-entitlements(application-id => 'test-val', entitlement-id => 'test-val') }, 'Method delete-applications-entitlements exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/applications/test-val/entitlements/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /applications/{application.id}/guilds/{guild.id}/commands/{command.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-applications-guilds-commands(application-id => 'test-val', guild-id => 'test-val', command-id => 'test-val') }, 'Method delete-applications-guilds-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/applications/test-val/guilds/test-val/commands/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels(channel-id => 'test-val') }, 'Method delete-channels exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/messages/pins/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-messages-pins(channel-id => 'test-val', message-id => 'test-val') }, 'Method delete-channels-messages-pins exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/messages/pins/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-messages(channel-id => 'test-val', message-id => 'test-val') }, 'Method delete-channels-messages exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/messages/{message.id}/reactions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-messages-reactions(channel-id => 'test-val', message-id => 'test-val') }, 'Method delete-channels-messages-reactions exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/messages/test-val/reactions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-messages-reactionsX2(channel-id => 'test-val', message-id => 'test-val', emoji-id => 'test-val') }, 'Method delete-channels-messages-reactionsX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/messages/test-val/reactions/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-messages-reactions-me(channel-id => 'test-val', message-id => 'test-val', emoji-id => 'test-val') }, 'Method delete-channels-messages-reactions-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/messages/test-val/reactions/test-val/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-messages-reactionsX3(channel-id => 'test-val', message-id => 'test-val', emoji-id => 'test-val', user-id => 'test-val') }, 'Method delete-channels-messages-reactionsX3 exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/messages/test-val/reactions/test-val/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/permissions/{overwrite.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-permissions(channel-id => 'test-val', overwrite-id => 'test-val') }, 'Method delete-channels-permissions exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/permissions/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/pins/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-pins(channel-id => 'test-val', message-id => 'test-val') }, 'Method delete-channels-pins exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/pins/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/recipients/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-recipients(channel-id => 'test-val', user-id => 'test-val') }, 'Method delete-channels-recipients exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/recipients/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/thread-members/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-thread-members-me(channel-id => 'test-val') }, 'Method delete-channels-thread-members-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/thread-members/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /channels/{channel.id}/thread-members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-channels-thread-members(channel-id => 'test-val', user-id => 'test-val') }, 'Method delete-channels-thread-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/channels/test-val/thread-members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-auto-moderation-rules(guild-id => 'test-val', auto-moderation-rule-id => 'test-val') }, 'Method delete-guilds-auto-moderation-rules exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/auto-moderation/rules/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/bans/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-bans(guild-id => 'test-val', user-id => 'test-val') }, 'Method delete-guilds-bans exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/bans/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/emojis/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-emojis(guild-id => 'test-val', emoji-id => 'test-val') }, 'Method delete-guilds-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/emojis/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/integrations/{integration.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-integrations(guild-id => 'test-val', integration-id => 'test-val') }, 'Method delete-guilds-integrations exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/integrations/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-members(guild-id => 'test-val', user-id => 'test-val') }, 'Method delete-guilds-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/members/{user.id}/roles/{role.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-members-roles(guild-id => 'test-val', user-id => 'test-val', role-id => 'test-val') }, 'Method delete-guilds-members-roles exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/members/test-val/roles/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/roles/{role.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-roles(guild-id => 'test-val', role-id => 'test-val') }, 'Method delete-guilds-roles exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/roles/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-scheduled-events(guild-id => 'test-val', guild-scheduled-event-id => 'test-val') }, 'Method delete-guilds-scheduled-events exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/scheduled-events/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/soundboard-sounds/{sound.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-soundboard-sounds(guild-id => 'test-val', sound-id => 'test-val') }, 'Method delete-guilds-soundboard-sounds exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/soundboard-sounds/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/stickers/{sticker.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-stickers(guild-id => 'test-val', sticker-id => 'test-val') }, 'Method delete-guilds-stickers exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/stickers/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /guilds/{guild.id}/templates/{template.code}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-guilds-templates(guild-id => 'test-val', template-code => 'test-val') }, 'Method delete-guilds-templates exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/guilds/test-val/templates/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /invites/{invite.code}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-invites(invite-code => 'test-val') }, 'Method delete-invites exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/invites/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /lobbies/{lobby.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-lobbies(lobby-id => 'test-val') }, 'Method delete-lobbies exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/lobbies/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /lobbies/{lobby.id}/members/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-lobbies-members-me(lobby-id => 'test-val') }, 'Method delete-lobbies-members-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/lobbies/test-val/members/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /lobbies/{lobby.id}/members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-lobbies-members(lobby-id => 'test-val', user-id => 'test-val') }, 'Method delete-lobbies-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/lobbies/test-val/members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /stage-instances/{channel.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-stage-instances(channel-id => 'test-val') }, 'Method delete-stage-instances exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/stage-instances/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /users/@me/guilds/{guild.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-users-me-guilds(guild-id => 'test-val') }, 'Method delete-users-me-guilds exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/users/@me/guilds/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /webhooks/{application.id}/{interaction.token}/messages/@original' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-webhooks-messagesoriginal(application-id => 'test-val', interaction-token => 'test-val') }, 'Method delete-webhooks-messagesoriginal exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/webhooks/test-val/test-val/messages/@original', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /webhooks/{application.id}/{interaction.token}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-webhooks-messages(application-id => 'test-val', interaction-token => 'test-val', message-id => 'test-val') }, 'Method delete-webhooks-messages exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/webhooks/test-val/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /webhooks/{webhook.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-webhooks(webhook-id => 'test-val') }, 'Method delete-webhooks exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/webhooks/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /webhooks/{webhook.id}/{webhook.token}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-webhooksX2(webhook-id => 'test-val', webhook-token => 'test-val') }, 'Method delete-webhooksX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/webhooks/test-val/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: DELETE /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.delete-webhooks-messagesX2(webhook-id => 'test-val', webhook-token => 'test-val', message-id => 'test-val') }, 'Method delete-webhooks-messagesX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'DELETE', 'Method is DELETE';
        is $route.path, '/webhooks/test-val/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-me() }, 'Method get-applications-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/activity-instances/{instance_id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-activity-instance(application-id => 'test-val', instance-id => 'test-val') }, 'Method get-applications-activity-instance exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/activity-instances/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/commands' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-commands(application-id => 'test-val') }, 'Method get-applications-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/commands', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/commands/{command.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-command(application-id => 'test-val', command-id => 'test-val') }, 'Method get-applications-command exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/commands/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/emojis' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-emojis(application-id => 'test-val') }, 'Method get-applications-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/emojis', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/emojis/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-emoji(application-id => 'test-val', emoji-id => 'test-val') }, 'Method get-applications-emoji exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/emojis/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/entitlements' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-entitlements(application-id => 'test-val') }, 'Method get-applications-entitlements exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/entitlements', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/entitlements/{entitlement.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-entitlement(application-id => 'test-val', entitlement-id => 'test-val') }, 'Method get-applications-entitlement exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/entitlements/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/guilds/{guild.id}/commands' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-guilds-commands(application-id => 'test-val', guild-id => 'test-val') }, 'Method get-applications-guilds-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/guilds/test-val/commands', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/guilds/{guild.id}/commands/permissions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-guilds-commands-permissions(application-id => 'test-val', guild-id => 'test-val') }, 'Method get-applications-guilds-commands-permissions exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/guilds/test-val/commands/permissions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/guilds/{guild.id}/commands/{command.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-guilds-command(application-id => 'test-val', guild-id => 'test-val', command-id => 'test-val') }, 'Method get-applications-guilds-command exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/guilds/test-val/commands/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/guilds/{guild.id}/commands/{command.id}/permissions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-guilds-commands-permissionsX2(application-id => 'test-val', guild-id => 'test-val', command-id => 'test-val') }, 'Method get-applications-guilds-commands-permissionsX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/guilds/test-val/commands/test-val/permissions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/role-connections/metadata' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-role-connections-metadata(application-id => 'test-val') }, 'Method get-applications-role-connections-metadata exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/role-connections/metadata', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /applications/{application.id}/skus' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-applications-skus(application-id => 'test-val') }, 'Method get-applications-skus exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/applications/test-val/skus', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channel(channel-id => 'test-val') }, 'Method get-channel exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/invites' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-invites(channel-id => 'test-val') }, 'Method get-channels-invites exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/invites', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/messages' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-messages(channel-id => 'test-val') }, 'Method get-channels-messages exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/messages', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/messages/pins' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-messages-pins(channel-id => 'test-val') }, 'Method get-channels-messages-pins exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/messages/pins', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-message(channel-id => 'test-val', message-id => 'test-val') }, 'Method get-channels-message exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-messages-reaction(channel-id => 'test-val', message-id => 'test-val', emoji-id => 'test-val') }, 'Method get-channels-messages-reaction exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/messages/test-val/reactions/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/pins' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-pins(channel-id => 'test-val') }, 'Method get-channels-pins exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/pins', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/polls/{message.id}/answers/{answer_id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-polls-answer(channel-id => 'test-val', message-id => 'test-val', answer-id => 'test-val') }, 'Method get-channels-polls-answer exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/polls/test-val/answers/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/thread-members' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-thread-members(channel-id => 'test-val') }, 'Method get-channels-thread-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/thread-members', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/thread-members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-thread-member(channel-id => 'test-val', user-id => 'test-val') }, 'Method get-channels-thread-member exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/thread-members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/threads/archived/private' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-threads-archived-private(channel-id => 'test-val') }, 'Method get-channels-threads-archived-private exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/threads/archived/private', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/threads/archived/public' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-threads-archived-public(channel-id => 'test-val') }, 'Method get-channels-threads-archived-public exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/threads/archived/public', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/users/@me/threads/archived/private' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-users-me-threads-archived-private(channel-id => 'test-val') }, 'Method get-channels-users-me-threads-archived-private exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/users/@me/threads/archived/private', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /channels/{channel.id}/webhooks' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-channels-webhooks(channel-id => 'test-val') }, 'Method get-channels-webhooks exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/channels/test-val/webhooks', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /gateway' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-gateway() }, 'Method get-gateway exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/gateway', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /gateway/bot' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-gateway-bot() }, 'Method get-gateway-bot exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/gateway/bot', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/templates/{template.code}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-template(template-code => 'test-val') }, 'Method get-guilds-template exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/templates/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guild(guild-id => 'test-val') }, 'Method get-guild exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/audit-logs' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-audit-logs(guild-id => 'test-val') }, 'Method get-guilds-audit-logs exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/audit-logs', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/auto-moderation/rules' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-auto-moderation-rules(guild-id => 'test-val') }, 'Method get-guilds-auto-moderation-rules exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/auto-moderation/rules', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-auto-moderation-rule(guild-id => 'test-val', auto-moderation-rule-id => 'test-val') }, 'Method get-guilds-auto-moderation-rule exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/auto-moderation/rules/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/bans' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-bans(guild-id => 'test-val') }, 'Method get-guilds-bans exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/bans', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/bans/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-ban(guild-id => 'test-val', user-id => 'test-val') }, 'Method get-guilds-ban exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/bans/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/channels' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-channels(guild-id => 'test-val') }, 'Method get-guilds-channels exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/channels', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/emojis' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-emojis(guild-id => 'test-val') }, 'Method get-guilds-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/emojis', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/emojis/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-emoji(guild-id => 'test-val', emoji-id => 'test-val') }, 'Method get-guilds-emoji exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/emojis/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/integrations' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-integrations(guild-id => 'test-val') }, 'Method get-guilds-integrations exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/integrations', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/invites' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-invites(guild-id => 'test-val') }, 'Method get-guilds-invites exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/invites', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/members' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-members(guild-id => 'test-val') }, 'Method get-guilds-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/members', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/members/search' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-members-search(guild-id => 'test-val') }, 'Method get-guilds-members-search exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/members/search', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-member(guild-id => 'test-val', user-id => 'test-val') }, 'Method get-guilds-member exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/onboarding' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-onboarding(guild-id => 'test-val') }, 'Method get-guilds-onboarding exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/onboarding', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/preview' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-preview(guild-id => 'test-val') }, 'Method get-guilds-preview exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/preview', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/prune' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-prune(guild-id => 'test-val') }, 'Method get-guilds-prune exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/prune', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/regions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-regions(guild-id => 'test-val') }, 'Method get-guilds-regions exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/regions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/roles' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-roles(guild-id => 'test-val') }, 'Method get-guilds-roles exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/roles', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/roles/member-counts' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-roles-member-counts(guild-id => 'test-val') }, 'Method get-guilds-roles-member-counts exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/roles/member-counts', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/roles/{role.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-role(guild-id => 'test-val', role-id => 'test-val') }, 'Method get-guilds-role exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/roles/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/scheduled-events' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-scheduled-events(guild-id => 'test-val') }, 'Method get-guilds-scheduled-events exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/scheduled-events', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-scheduled-event(guild-id => 'test-val', guild-scheduled-event-id => 'test-val') }, 'Method get-guilds-scheduled-event exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/scheduled-events/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}/users' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-scheduled-events-users(guild-id => 'test-val', guild-scheduled-event-id => 'test-val') }, 'Method get-guilds-scheduled-events-users exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/scheduled-events/test-val/users', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/soundboard-sounds' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-soundboard-sounds(guild-id => 'test-val') }, 'Method get-guilds-soundboard-sounds exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/soundboard-sounds', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/soundboard-sounds/{sound.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-soundboard-sound(guild-id => 'test-val', sound-id => 'test-val') }, 'Method get-guilds-soundboard-sound exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/soundboard-sounds/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/stickers' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-stickers(guild-id => 'test-val') }, 'Method get-guilds-stickers exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/stickers', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/stickers/{sticker.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-sticker(guild-id => 'test-val', sticker-id => 'test-val') }, 'Method get-guilds-sticker exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/stickers/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/templates' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-templates(guild-id => 'test-val') }, 'Method get-guilds-templates exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/templates', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/threads/active' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-threads-active(guild-id => 'test-val') }, 'Method get-guilds-threads-active exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/threads/active', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/vanity-url' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-vanity-url(guild-id => 'test-val') }, 'Method get-guilds-vanity-url exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/vanity-url', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/voice-states/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-voice-states-me(guild-id => 'test-val') }, 'Method get-guilds-voice-states-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/voice-states/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/voice-states/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-voice-state(guild-id => 'test-val', user-id => 'test-val') }, 'Method get-guilds-voice-state exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/voice-states/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/webhooks' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-webhooks(guild-id => 'test-val') }, 'Method get-guilds-webhooks exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/webhooks', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/welcome-screen' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-welcome-screen(guild-id => 'test-val') }, 'Method get-guilds-welcome-screen exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/welcome-screen', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/widget' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-widget(guild-id => 'test-val') }, 'Method get-guilds-widget exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/widget', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/widget.json' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-widgetjson(guild-id => 'test-val') }, 'Method get-guilds-widgetjson exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/widget.json', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /guilds/{guild.id}/widget.png' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-guilds-widgetpng(guild-id => 'test-val') }, 'Method get-guilds-widgetpng exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/guilds/test-val/widget.png', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /invites/{invite.code}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-invite(invite-code => 'test-val') }, 'Method get-invite exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/invites/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /invites/{invite.code}/target-users' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-invites-target-users(invite-code => 'test-val') }, 'Method get-invites-target-users exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/invites/test-val/target-users', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /invites/{invite.code}/target-users/job-status' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-invites-target-users-job-status(invite-code => 'test-val') }, 'Method get-invites-target-users-job-status exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/invites/test-val/target-users/job-status', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /lobbies/{lobby.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-lobbie(lobby-id => 'test-val') }, 'Method get-lobbie exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/lobbies/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /oauth2/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-oauth2-me() }, 'Method get-oauth2-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/oauth2/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /oauth2/applications/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-oauth2-applications-me() }, 'Method get-oauth2-applications-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/oauth2/applications/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /skus/{sku.id}/subscriptions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-skus-subscriptions(sku-id => 'test-val') }, 'Method get-skus-subscriptions exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/skus/test-val/subscriptions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /skus/{sku.id}/subscriptions/{subscription.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-skus-subscription(sku-id => 'test-val', subscription-id => 'test-val') }, 'Method get-skus-subscription exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/skus/test-val/subscriptions/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /soundboard-default-sounds' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-soundboard-default-sounds() }, 'Method get-soundboard-default-sounds exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/soundboard-default-sounds', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /stage-instances/{channel.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-stage-instance(channel-id => 'test-val') }, 'Method get-stage-instance exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/stage-instances/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /sticker-packs' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-sticker-packs() }, 'Method get-sticker-packs exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/sticker-packs', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /sticker-packs/{pack.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-sticker-pack(pack-id => 'test-val') }, 'Method get-sticker-pack exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/sticker-packs/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /stickers/{sticker.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-sticker(sticker-id => 'test-val') }, 'Method get-sticker exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/stickers/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /users/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-users-me() }, 'Method get-users-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/users/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /users/@me/applications/{application.id}/role-connection' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-users-me-applications-role-connection(application-id => 'test-val') }, 'Method get-users-me-applications-role-connection exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/users/@me/applications/test-val/role-connection', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /users/@me/connections' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-users-me-connections() }, 'Method get-users-me-connections exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/users/@me/connections', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /users/@me/guilds' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-users-me-guilds() }, 'Method get-users-me-guilds exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/users/@me/guilds', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /users/@me/guilds/{guild.id}/member' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-users-me-guilds-member(guild-id => 'test-val') }, 'Method get-users-me-guilds-member exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/users/@me/guilds/test-val/member', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /users/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-user(user-id => 'test-val') }, 'Method get-user exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/users/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /voice/regions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-voice-regions() }, 'Method get-voice-regions exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/voice/regions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /webhooks/{application.id}/{interaction.token}/messages/@original' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-webhooks-messagesoriginal(application-id => 'test-val', interaction-token => 'test-val') }, 'Method get-webhooks-messagesoriginal exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/webhooks/test-val/test-val/messages/@original', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /webhooks/{application.id}/{interaction.token}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-webhooks-message(application-id => 'test-val', interaction-token => 'test-val', message-id => 'test-val') }, 'Method get-webhooks-message exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/webhooks/test-val/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /webhooks/{webhook.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-webhook(webhook-id => 'test-val') }, 'Method get-webhook exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/webhooks/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /webhooks/{webhook.id}/{webhook.token}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-webhookX2(webhook-id => 'test-val', webhook-token => 'test-val') }, 'Method get-webhookX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/webhooks/test-val/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: GET /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.get-webhooks-messageX2(webhook-id => 'test-val', webhook-token => 'test-val', message-id => 'test-val') }, 'Method get-webhooks-messageX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'GET', 'Method is GET';
        is $route.path, '/webhooks/test-val/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /applications/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-applications-me() }, 'Method patch-applications-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/applications/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /applications/{application.id}/commands/{command.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-applications-commands(application-id => 'test-val', command-id => 'test-val') }, 'Method patch-applications-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/applications/test-val/commands/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /applications/{application.id}/emojis/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-applications-emojis(application-id => 'test-val', emoji-id => 'test-val') }, 'Method patch-applications-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/applications/test-val/emojis/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /applications/{application.id}/guilds/{guild.id}/commands/{command.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-applications-guilds-commands(application-id => 'test-val', guild-id => 'test-val', command-id => 'test-val') }, 'Method patch-applications-guilds-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/applications/test-val/guilds/test-val/commands/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /channels/{channel.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-channels(channel-id => 'test-val') }, 'Method patch-channels exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/channels/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /channels/{channel.id}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-channels-messages(channel-id => 'test-val', message-id => 'test-val') }, 'Method patch-channels-messages exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/channels/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds(guild-id => 'test-val') }, 'Method patch-guilds exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-auto-moderation-rules(guild-id => 'test-val', auto-moderation-rule-id => 'test-val') }, 'Method patch-guilds-auto-moderation-rules exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/auto-moderation/rules/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/channels' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-channels(guild-id => 'test-val') }, 'Method patch-guilds-channels exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/channels', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/emojis/{emoji.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-emojis(guild-id => 'test-val', emoji-id => 'test-val') }, 'Method patch-guilds-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/emojis/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/members/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-members-me(guild-id => 'test-val') }, 'Method patch-guilds-members-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/members/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/members/@me/nick' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-members-me-nick(guild-id => 'test-val') }, 'Method patch-guilds-members-me-nick exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/members/@me/nick', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-members(guild-id => 'test-val', user-id => 'test-val') }, 'Method patch-guilds-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/roles' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-roles(guild-id => 'test-val') }, 'Method patch-guilds-roles exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/roles', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/roles/{role.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-rolesX2(guild-id => 'test-val', role-id => 'test-val') }, 'Method patch-guilds-rolesX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/roles/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-scheduled-events(guild-id => 'test-val', guild-scheduled-event-id => 'test-val') }, 'Method patch-guilds-scheduled-events exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/scheduled-events/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/soundboard-sounds/{sound.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-soundboard-sounds(guild-id => 'test-val', sound-id => 'test-val') }, 'Method patch-guilds-soundboard-sounds exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/soundboard-sounds/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/stickers/{sticker.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-stickers(guild-id => 'test-val', sticker-id => 'test-val') }, 'Method patch-guilds-stickers exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/stickers/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/templates/{template.code}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-templates(guild-id => 'test-val', template-code => 'test-val') }, 'Method patch-guilds-templates exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/templates/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/voice-states/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-voice-states-me(guild-id => 'test-val') }, 'Method patch-guilds-voice-states-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/voice-states/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/voice-states/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-voice-states(guild-id => 'test-val', user-id => 'test-val') }, 'Method patch-guilds-voice-states exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/voice-states/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/welcome-screen' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-welcome-screen(guild-id => 'test-val') }, 'Method patch-guilds-welcome-screen exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/welcome-screen', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /guilds/{guild.id}/widget' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-guilds-widget(guild-id => 'test-val') }, 'Method patch-guilds-widget exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/guilds/test-val/widget', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /lobbies/{lobby.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-lobbies(lobby-id => 'test-val') }, 'Method patch-lobbies exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/lobbies/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /lobbies/{lobby.id}/channel-linking' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-lobbies-channel-linking(lobby-id => 'test-val') }, 'Method patch-lobbies-channel-linking exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/lobbies/test-val/channel-linking', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /stage-instances/{channel.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-stage-instances(channel-id => 'test-val') }, 'Method patch-stage-instances exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/stage-instances/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /users/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-users-me() }, 'Method patch-users-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/users/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /webhooks/{application.id}/{interaction.token}/messages/@original' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-webhooks-messagesoriginal(application-id => 'test-val', interaction-token => 'test-val') }, 'Method patch-webhooks-messagesoriginal exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/webhooks/test-val/test-val/messages/@original', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /webhooks/{application.id}/{interaction.token}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-webhooks-messages(application-id => 'test-val', interaction-token => 'test-val', message-id => 'test-val') }, 'Method patch-webhooks-messages exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/webhooks/test-val/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /webhooks/{webhook.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-webhooks(webhook-id => 'test-val') }, 'Method patch-webhooks exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/webhooks/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /webhooks/{webhook.id}/{webhook.token}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-webhooksX2(webhook-id => 'test-val', webhook-token => 'test-val') }, 'Method patch-webhooksX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/webhooks/test-val/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PATCH /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.patch-webhooks-messagesX2(webhook-id => 'test-val', webhook-token => 'test-val', message-id => 'test-val') }, 'Method patch-webhooks-messagesX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'PATCH', 'Method is PATCH';
        is $route.path, '/webhooks/test-val/test-val/messages/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /applications/{application.id}/commands' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-applications-commands(application-id => 'test-val') }, 'Method post-applications-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/applications/test-val/commands', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /applications/{application.id}/emojis' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-applications-emojis(application-id => 'test-val') }, 'Method post-applications-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/applications/test-val/emojis', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /applications/{application.id}/entitlements' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-applications-entitlements(application-id => 'test-val') }, 'Method post-applications-entitlements exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/applications/test-val/entitlements', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /applications/{application.id}/entitlements/{entitlement.id}/consume' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-applications-entitlements-consume(application-id => 'test-val', entitlement-id => 'test-val') }, 'Method post-applications-entitlements-consume exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/applications/test-val/entitlements/test-val/consume', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /applications/{application.id}/guilds/{guild.id}/commands' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-applications-guilds-commands(application-id => 'test-val', guild-id => 'test-val') }, 'Method post-applications-guilds-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/applications/test-val/guilds/test-val/commands', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/followers' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-followers(channel-id => 'test-val') }, 'Method post-channels-followers exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/followers', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/invites' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-invites(channel-id => 'test-val') }, 'Method post-channels-invites exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/invites', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/messages' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-messages(channel-id => 'test-val') }, 'Method post-channels-messages exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/messages', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/messages/bulk-delete' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-messages-bulk-delete(channel-id => 'test-val') }, 'Method post-channels-messages-bulk-delete exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/messages/bulk-delete', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/messages/{message.id}/crosspost' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-messages-crosspost(channel-id => 'test-val', message-id => 'test-val') }, 'Method post-channels-messages-crosspost exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/messages/test-val/crosspost', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/messages/{message.id}/threads' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-messages-threads(channel-id => 'test-val', message-id => 'test-val') }, 'Method post-channels-messages-threads exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/messages/test-val/threads', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/polls/{message.id}/expire' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-polls-expire(channel-id => 'test-val', message-id => 'test-val') }, 'Method post-channels-polls-expire exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/polls/test-val/expire', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/send-soundboard-sound' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-send-soundboard-sound(channel-id => 'test-val') }, 'Method post-channels-send-soundboard-sound exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/send-soundboard-sound', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/threads' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-threads(channel-id => 'test-val') }, 'Method post-channels-threads exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/threads', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/typing' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-typing(channel-id => 'test-val') }, 'Method post-channels-typing exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/typing', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /channels/{channel.id}/webhooks' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-channels-webhooks(channel-id => 'test-val') }, 'Method post-channels-webhooks exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/channels/test-val/webhooks', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/auto-moderation/rules' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-auto-moderation-rules(guild-id => 'test-val') }, 'Method post-guilds-auto-moderation-rules exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/auto-moderation/rules', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/bulk-ban' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-bulk-ban(guild-id => 'test-val') }, 'Method post-guilds-bulk-ban exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/bulk-ban', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/channels' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-channels(guild-id => 'test-val') }, 'Method post-guilds-channels exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/channels', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/emojis' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-emojis(guild-id => 'test-val') }, 'Method post-guilds-emojis exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/emojis', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/prune' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-prune(guild-id => 'test-val') }, 'Method post-guilds-prune exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/prune', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/roles' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-roles(guild-id => 'test-val') }, 'Method post-guilds-roles exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/roles', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/scheduled-events' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-scheduled-events(guild-id => 'test-val') }, 'Method post-guilds-scheduled-events exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/scheduled-events', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/soundboard-sounds' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-soundboard-sounds(guild-id => 'test-val') }, 'Method post-guilds-soundboard-sounds exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/soundboard-sounds', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/stickers' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-stickers(guild-id => 'test-val') }, 'Method post-guilds-stickers exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/stickers', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /guilds/{guild.id}/templates' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-guilds-templates(guild-id => 'test-val') }, 'Method post-guilds-templates exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/guilds/test-val/templates', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /interactions/{interaction.id}/{interaction.token}/callback' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-interactions-callback(interaction-id => 'test-val', interaction-token => 'test-val') }, 'Method post-interactions-callback exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/interactions/test-val/test-val/callback', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /lobbies' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-lobbies() }, 'Method post-lobbies exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/lobbies', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /stage-instances' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-stage-instances() }, 'Method post-stage-instances exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/stage-instances', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /users/@me/channels' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-users-me-channels() }, 'Method post-users-me-channels exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/users/@me/channels', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /webhooks/{application.id}/{interaction.token}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-webhooks(application-id => 'test-val', interaction-token => 'test-val') }, 'Method post-webhooks exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/webhooks/test-val/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /webhooks/{webhook.id}/{webhook.token}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-webhooksX2(webhook-id => 'test-val', webhook-token => 'test-val') }, 'Method post-webhooksX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/webhooks/test-val/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /webhooks/{webhook.id}/{webhook.token}/github' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-webhooks-github(webhook-id => 'test-val', webhook-token => 'test-val') }, 'Method post-webhooks-github exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/webhooks/test-val/test-val/github', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: POST /webhooks/{webhook.id}/{webhook.token}/slack' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.post-webhooks-slack(webhook-id => 'test-val', webhook-token => 'test-val') }, 'Method post-webhooks-slack exists and accepts parameters';
    
    if $route {
        is $route.method, 'POST', 'Method is POST';
        is $route.path, '/webhooks/test-val/test-val/slack', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /applications/{application.id}/commands' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-applications-commands(application-id => 'test-val') }, 'Method put-applications-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/applications/test-val/commands', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /applications/{application.id}/guilds/{guild.id}/commands' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-applications-guilds-commands(application-id => 'test-val', guild-id => 'test-val') }, 'Method put-applications-guilds-commands exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/applications/test-val/guilds/test-val/commands', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /applications/{application.id}/guilds/{guild.id}/commands/permissions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-applications-guilds-commands-permissions(application-id => 'test-val', guild-id => 'test-val') }, 'Method put-applications-guilds-commands-permissions exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/applications/test-val/guilds/test-val/commands/permissions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /applications/{application.id}/guilds/{guild.id}/commands/{command.id}/permissions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-applications-guilds-commands-permissionsX2(application-id => 'test-val', guild-id => 'test-val', command-id => 'test-val') }, 'Method put-applications-guilds-commands-permissionsX2 exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/applications/test-val/guilds/test-val/commands/test-val/permissions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /applications/{application.id}/role-connections/metadata' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-applications-role-connections-metadata(application-id => 'test-val') }, 'Method put-applications-role-connections-metadata exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/applications/test-val/role-connections/metadata', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /channels/{channel.id}/messages/pins/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-channels-messages-pins(channel-id => 'test-val', message-id => 'test-val') }, 'Method put-channels-messages-pins exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/channels/test-val/messages/pins/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-channels-messages-reactions-me(channel-id => 'test-val', message-id => 'test-val', emoji-id => 'test-val') }, 'Method put-channels-messages-reactions-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/channels/test-val/messages/test-val/reactions/test-val/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /channels/{channel.id}/permissions/{overwrite.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-channels-permissions(channel-id => 'test-val', overwrite-id => 'test-val') }, 'Method put-channels-permissions exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/channels/test-val/permissions/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /channels/{channel.id}/pins/{message.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-channels-pins(channel-id => 'test-val', message-id => 'test-val') }, 'Method put-channels-pins exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/channels/test-val/pins/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /channels/{channel.id}/recipients/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-channels-recipients(channel-id => 'test-val', user-id => 'test-val') }, 'Method put-channels-recipients exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/channels/test-val/recipients/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /channels/{channel.id}/thread-members/@me' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-channels-thread-members-me(channel-id => 'test-val') }, 'Method put-channels-thread-members-me exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/channels/test-val/thread-members/@me', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /channels/{channel.id}/thread-members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-channels-thread-members(channel-id => 'test-val', user-id => 'test-val') }, 'Method put-channels-thread-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/channels/test-val/thread-members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /guilds/{guild.id}/bans/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-guilds-bans(guild-id => 'test-val', user-id => 'test-val') }, 'Method put-guilds-bans exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/guilds/test-val/bans/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /guilds/{guild.id}/incident-actions' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-guilds-incident-actions(guild-id => 'test-val') }, 'Method put-guilds-incident-actions exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/guilds/test-val/incident-actions', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /guilds/{guild.id}/members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-guilds-members(guild-id => 'test-val', user-id => 'test-val') }, 'Method put-guilds-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/guilds/test-val/members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /guilds/{guild.id}/members/{user.id}/roles/{role.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-guilds-members-roles(guild-id => 'test-val', user-id => 'test-val', role-id => 'test-val') }, 'Method put-guilds-members-roles exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/guilds/test-val/members/test-val/roles/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /guilds/{guild.id}/onboarding' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-guilds-onboarding(guild-id => 'test-val') }, 'Method put-guilds-onboarding exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/guilds/test-val/onboarding', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /guilds/{guild.id}/templates/{template.code}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-guilds-templates(guild-id => 'test-val', template-code => 'test-val') }, 'Method put-guilds-templates exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/guilds/test-val/templates/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /invites/{invite.code}/target-users' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-invites-target-users(invite-code => 'test-val') }, 'Method put-invites-target-users exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/invites/test-val/target-users', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /lobbies/{lobby.id}/members/{user.id}' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-lobbies-members(lobby-id => 'test-val', user-id => 'test-val') }, 'Method put-lobbies-members exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/lobbies/test-val/members/test-val', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};

subtest 'Endpoint: PUT /users/@me/applications/{application.id}/role-connection' => {
    my $route;
    lives-ok { $route = Dusk::Rest::Endpoint.put-users-me-applications-role-connection(application-id => 'test-val') }, 'Method put-users-me-applications-role-connection exists and accepts parameters';
    
    if $route {
        is $route.method, 'PUT', 'Method is PUT';
        is $route.path, '/users/@me/applications/test-val/role-connection', 'Path structure is mostly correct';
    } else {
        skip 'Route generation failed, skipping assertions', 2;
    }
};


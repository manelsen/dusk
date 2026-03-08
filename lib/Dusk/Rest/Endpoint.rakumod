use v6.d;
use Dusk::Rest::Endpoint::Channel;
use Dusk::Rest::Endpoint::Guild;
use Dusk::Rest::Endpoint::User;
use Dusk::Rest::Endpoint::Webhook;
use Dusk::Rest::Endpoint::Application;
use Dusk::Rest::Endpoint::Misc;
use Dusk::Rest::Endpoint::AutoModeration;
use Dusk::Rest::Endpoint::ScheduledEvent;
use Dusk::Rest::Endpoint::StageInstance;
use Dusk::Rest::Endpoint::Entitlement;

unit class Dusk::Rest::Endpoint
    does Dusk::Rest::Endpoint::Channel
    does Dusk::Rest::Endpoint::Guild
    does Dusk::Rest::Endpoint::User
    does Dusk::Rest::Endpoint::Webhook
    does Dusk::Rest::Endpoint::Application
    does Dusk::Rest::Endpoint::Misc
    does Dusk::Rest::Endpoint::AutoModeration
    does Dusk::Rest::Endpoint::ScheduledEvent
    does Dusk::Rest::Endpoint::StageInstance
    does Dusk::Rest::Endpoint::Entitlement;

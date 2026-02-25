use v6.d;
use Dusk::Rest::Endpoint::Channel;
use Dusk::Rest::Endpoint::Guild;
use Dusk::Rest::Endpoint::User;
use Dusk::Rest::Endpoint::Webhook;
use Dusk::Rest::Endpoint::Application;
use Dusk::Rest::Endpoint::Misc;

unit class Dusk::Rest::Endpoint
    does Dusk::Rest::Endpoint::Channel
    does Dusk::Rest::Endpoint::Guild
    does Dusk::Rest::Endpoint::User
    does Dusk::Rest::Endpoint::Webhook
    does Dusk::Rest::Endpoint::Application
    does Dusk::Rest::Endpoint::Misc;

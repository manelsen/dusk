use v6.d;
use Dusk::Rest::Route;
use Dusk::Model::Channel;
use Dusk::Model::Guild;
use Dusk::Model::Message;
use Dusk::Model::User;
use Dusk::Model::Role;
use Dusk::Model::Member;
use Dusk::Model::Emoji;
use Dusk::Model::Sticker;
use Dusk::Model::Invite;
use Dusk::Model::Webhook;
use Dusk::Model::AutoModRule;
use Dusk::Model::ScheduledEvent;
use Dusk::Model::StageInstance;
use Dusk::Model::Integration;
use Dusk::Model::Application;

unit role Dusk::Rest::Endpoint::Base;

method !route(Str $method, Str $path, :$target-model = Any, *%body) {
    return Dusk::Rest::Route.new(
        :$method,
        :$path,
        :$target-model,
        body => %body
    );
}

use v6.d;

unit class Dusk::Model::Activity;

has Str $.name         is required;
has Int $.type         is required;
has Str $.url;
has Str $.created-at;
has %.timestamps;
has Str $.application-id;
has Str $.details;
has Str $.state;
has %.emoji;
has %.party;
has %.assets;
has %.secrets;
has Bool $.instance;
has Int $.flags;
has @.buttons;

method new(*%args) {
    self.bless(
        name           => ~(%args<name> // ''),
        type           => (%args<type> // 0).Int,
        url            => %args<url> // '',
        created-at     => ~(%args<created_at> // ''),
        timestamps     => %args<timestamps> // {},
        application-id => %args<application_id> // '',
        details        => %args<details> // '',
        state          => %args<state> // '',
        emoji          => %args<emoji> // {},
        party          => %args<party> // {},
        assets         => %args<assets> // {},
        secrets        => %args<secrets> // {},
        instance       => ?%args<instance>,
        flags          => (%args<flags> // 0).Int,
        buttons        => @(%args<buttons> // []),
    )
}

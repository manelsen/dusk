=begin pod
=head1 Dusk::Interaction::Response

Builders for Interaction Response payloads. Used to reply to slash commands,
button clicks, and modal submissions.

=head2 Usage

    use Dusk::Interaction::Response;

    # Simple reply
    my $resp = Dusk::Interaction::Response.reply("Pong!");

    # Ephemeral reply
    my $resp = Dusk::Interaction::Response.ephemeral("Only you can see this");

    # Deferred reply (shows "Bot is thinking...")
    my $resp = Dusk::Interaction::Response.defer;

=end pod

unit class Dusk::Interaction::Response;

# Interaction Callback Types
our constant TYPE_PONG                    is export = 1;
our constant TYPE_CHANNEL_MESSAGE        is export = 4;
our constant TYPE_DEFERRED_MESSAGE       is export = 5;
our constant TYPE_DEFERRED_UPDATE        is export = 6;
our constant TYPE_UPDATE_MESSAGE         is export = 7;
our constant TYPE_AUTOCOMPLETE           is export = 8;
our constant TYPE_MODAL                  is export = 9;

our constant FLAG_EPHEMERAL is export = 64;

method reply(Str $content, :@components, :@embeds --> Hash) {
    my %data = ( content => $content );
    %data<components> = @components if @components;
    %data<embeds>     = @embeds     if @embeds;
    { type => TYPE_CHANNEL_MESSAGE, data => %data };
}

method ephemeral(Str $content, :@components --> Hash) {
    my %data = ( content => $content, flags => FLAG_EPHEMERAL );
    %data<components> = @components if @components;
    { type => TYPE_CHANNEL_MESSAGE, data => %data };
}

method defer(Bool :$ephemeral = False --> Hash) {
    my %data;
    %data<flags> = FLAG_EPHEMERAL if $ephemeral;
    { type => TYPE_DEFERRED_MESSAGE, data => %data };
}

method defer-update(--> Hash) {
    { type => TYPE_DEFERRED_UPDATE };
}

method update(Str $content, :@components --> Hash) {
    my %data = ( content => $content );
    %data<components> = @components if @components;
    { type => TYPE_UPDATE_MESSAGE, data => %data };
}

method modal(Str :$custom-id!, Str :$title!, :@components! --> Hash) {
    { type => TYPE_MODAL, data => { custom_id => $custom-id, title => $title, components => @components } };
}

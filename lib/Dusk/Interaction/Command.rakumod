=begin pod
=head1 Dusk::Interaction::Command

Builder for Discord Application Commands (slash commands).

=head2 Usage

    use Dusk::Interaction::Command;

    my $cmd = Dusk::Interaction::Command.new(
        name        => 'greet',
        description => 'Say hello to someone',
    ).add-option(
        name        => 'user',
        description => 'Who to greet',
        type        => OPTION_USER,
        required    => True,
    ).add-option(
        name        => 'message',
        description => 'Custom greeting',
        type        => OPTION_STRING,
    );

    # Register via REST
    my $route = Dusk::Rest::Endpoint.post-applications-commands(
        application-id => $app-id,
        body => $cmd.to-hash,
    );

=end pod

unit class Dusk::Interaction::Command;

# Application Command Types
our constant TYPE_CHAT_INPUT is export = 1;
our constant TYPE_USER       is export = 2;
our constant TYPE_MESSAGE    is export = 3;

# Option Types
our constant OPTION_SUB_COMMAND       is export = 1;
our constant OPTION_SUB_COMMAND_GROUP is export = 2;
our constant OPTION_STRING            is export = 3;
our constant OPTION_INTEGER           is export = 4;
our constant OPTION_BOOLEAN           is export = 5;
our constant OPTION_USER              is export = 6;
our constant OPTION_CHANNEL           is export = 7;
our constant OPTION_ROLE              is export = 8;
our constant OPTION_MENTIONABLE       is export = 9;
our constant OPTION_NUMBER            is export = 10;
our constant OPTION_ATTACHMENT        is export = 11;

has Str $.name        is required;
has Str $.description is required;
has Int $.type = TYPE_CHAT_INPUT;
has     @.options;

method add-option(Str :$name!, Str :$description = '', Int :$type = OPTION_STRING,
                  Bool :$required = False, :@choices --> Dusk::Interaction::Command) {
    my %opt = (
        name        => $name,
        description => $description,
        type        => $type,
        required    => $required,
    );
    %opt<choices> = @choices if @choices;
    @!options.push(%opt);
    self;
}

method add-sub-command(Str :$name!, Str :$description = '', :@options --> Dusk::Interaction::Command) {
    @!options.push({
        name        => $name,
        description => $description,
        type        => OPTION_SUB_COMMAND,
        options     => @options,
    });
    self;
}

method to-hash(--> Hash) {
    my %h = (
        name        => $!name,
        description => $!description,
        type        => $!type,
    );
    %h<options> = @!options if @!options;
    %h;
}

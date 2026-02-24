=begin pod
=head1 Dusk::Component

Builders for Discord Message Components: Buttons, Select Menus, Action Rows, Modals.

=head2 Usage

    use Dusk::Component;

    my @row = Dusk::Component.action-row([
        Dusk::Component.button(label => 'Accept', style => STYLE_SUCCESS, custom-id => 'accept'),
        Dusk::Component.button(label => 'Deny', style => STYLE_DANGER, custom-id => 'deny'),
        Dusk::Component.link-button(label => 'Docs', url => 'https://example.com'),
    ]);

=end pod

unit class Dusk::Component;

# Component Types
our constant COMP_ACTION_ROW  is export = 1;
our constant COMP_BUTTON      is export = 2;
our constant COMP_STRING_SELECT is export = 3;
our constant COMP_TEXT_INPUT   is export = 4;
our constant COMP_USER_SELECT  is export = 5;
our constant COMP_ROLE_SELECT  is export = 6;
our constant COMP_MENTIONABLE_SELECT is export = 7;
our constant COMP_CHANNEL_SELECT is export = 8;

# Button Styles
our constant STYLE_PRIMARY   is export = 1;
our constant STYLE_SECONDARY is export = 2;
our constant STYLE_SUCCESS   is export = 3;
our constant STYLE_DANGER    is export = 4;
our constant STYLE_LINK      is export = 5;

# Text Input Styles
our constant INPUT_SHORT     is export = 1;
our constant INPUT_PARAGRAPH is export = 2;

method action-row(@components --> Hash) {
    { type => COMP_ACTION_ROW, components => @components };
}

method button(Str :$label!, Int :$style = STYLE_PRIMARY, Str :$custom-id!,
              Str :$emoji, Bool :$disabled = False --> Hash) {
    my %btn = (
        type      => COMP_BUTTON,
        label     => $label,
        style     => $style,
        custom_id => $custom-id,
    );
    %btn<emoji>    = { name => $emoji } if $emoji;
    %btn<disabled> = True if $disabled;
    %btn;
}

method link-button(Str :$label!, Str :$url!, Str :$emoji --> Hash) {
    my %btn = (
        type  => COMP_BUTTON,
        label => $label,
        style => STYLE_LINK,
        url   => $url,
    );
    %btn<emoji> = { name => $emoji } if $emoji;
    %btn;
}

method string-select(Str :$custom-id!, :@options!, Str :$placeholder,
                     Int :$min-values = 1, Int :$max-values = 1 --> Hash) {
    my %sel = (
        type       => COMP_STRING_SELECT,
        custom_id  => $custom-id,
        options    => @options,
        min_values => $min-values,
        max_values => $max-values,
    );
    %sel<placeholder> = $placeholder if $placeholder;
    %sel;
}

method select-option(Str :$label!, Str :$value!, Str :$description,
                     Bool :$default = False --> Hash) {
    my %opt = ( label => $label, value => $value );
    %opt<description> = $description if $description;
    %opt<default>     = True if $default;
    %opt;
}

method text-input(Str :$custom-id!, Str :$label!, Int :$style = INPUT_SHORT,
                  Str :$placeholder, Str :$value, Bool :$required = True,
                  Int :$min-length, Int :$max-length --> Hash) {
    my %inp = (
        type      => COMP_TEXT_INPUT,
        custom_id => $custom-id,
        label     => $label,
        style     => $style,
        required  => $required,
    );
    %inp<placeholder> = $placeholder if $placeholder;
    %inp<value>       = $value if $value;
    %inp<min_length>  = $min-length if $min-length.defined;
    %inp<max_length>  = $max-length if $max-length.defined;
    %inp;
}

method user-select(Str :$custom-id!, Str :$placeholder, Int :$min-values = 1, Int :$max-values = 1 --> Hash) {
    my %sel = ( type => COMP_USER_SELECT, custom_id => $custom-id, min_values => $min-values, max_values => $max-values );
    %sel<placeholder> = $placeholder if $placeholder;
    %sel;
}

method role-select(Str :$custom-id!, Str :$placeholder, Int :$min-values = 1, Int :$max-values = 1 --> Hash) {
    my %sel = ( type => COMP_ROLE_SELECT, custom_id => $custom-id, min_values => $min-values, max_values => $max-values );
    %sel<placeholder> = $placeholder if $placeholder;
    %sel;
}

method channel-select(Str :$custom-id!, Str :$placeholder, Int :$min-values = 1, Int :$max-values = 1 --> Hash) {
    my %sel = ( type => COMP_CHANNEL_SELECT, custom_id => $custom-id, min_values => $min-values, max_values => $max-values );
    %sel<placeholder> = $placeholder if $placeholder;
    %sel;
}

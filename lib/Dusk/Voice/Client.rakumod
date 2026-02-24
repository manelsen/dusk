=begin pod
=head1 Dusk::Voice::Client

B<Experimental stub> for Discord Voice Gateway connection.
This module provides the structural foundation for voice support
but does not implement audio encoding/transmission.

=head2 Status

This is a placeholder for v0.3.x. The Voice Gateway requires:
- UDP socket management
- Opus audio encoding
- IP discovery
- Encryption (xsalsa20_poly1305)

=end pod

unit class Dusk::Voice::Client;

has Str $.guild-id   is required;
has Str $.channel-id is required;
has Str $.session-id = '';
has Str $.token      = '';
has Str $.endpoint   = '';
has Bool $.connected = False;

method connect() {
    die "Dusk::Voice::Client is an experimental stub. Voice support is planned for v0.3.x.";
}

method disconnect() {
    $!connected = False;
}

method is-connected(--> Bool) { $!connected }

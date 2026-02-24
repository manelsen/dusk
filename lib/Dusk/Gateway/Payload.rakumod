=begin pod
=head1 Dusk::Gateway::Payload

Parsed Gateway WebSocket payload. Every frame from Discord follows this structure.

=head2 Attributes

=item C<Int $.op> — Opcode (0=Dispatch, 1=Heartbeat, 2=Identify, 6=Resume, 7=Reconnect, 9=InvalidSession, 10=Hello, 11=HeartbeatACK)
=item C<$.d> — Event data (Hash or Nil)
=item C<Str $.t> — Event name (only present for op:0 Dispatch events)
=item C<Int $.s> — Sequence number (only present for op:0 Dispatch events)

=end pod

unit class Dusk::Gateway::Payload;

# Gateway Opcodes
our constant OP_DISPATCH         = 0;
our constant OP_HEARTBEAT        = 1;
our constant OP_IDENTIFY         = 2;
our constant OP_PRESENCE_UPDATE  = 3;
our constant OP_VOICE_STATE      = 4;
our constant OP_RESUME           = 6;
our constant OP_RECONNECT        = 7;
our constant OP_REQUEST_MEMBERS  = 8;
our constant OP_INVALID_SESSION  = 9;
our constant OP_HELLO            = 10;
our constant OP_HEARTBEAT_ACK    = 11;

has Int $.op is required;
has     $.d;
has Str $.t  = '';
has Int $.s  = 0;

method new(*%args) {
    self.bless(
        op => +(%args<op> // 0),
        d  => %args<d>,
        t  => ~(%args<t> // ''),
        s  => +(%args<s> // 0),
    )
}

method is-dispatch(--> Bool)       { $!op == OP_DISPATCH }
method is-hello(--> Bool)          { $!op == OP_HELLO }
method is-heartbeat-ack(--> Bool)  { $!op == OP_HEARTBEAT_ACK }
method is-reconnect(--> Bool)      { $!op == OP_RECONNECT }
method is-invalid-session(--> Bool){ $!op == OP_INVALID_SESSION }

method heartbeat-interval(--> Numeric) {
    die "Not a HELLO payload" unless self.is-hello;
    $!d<heartbeat_interval> // 41250;
}

multi method from-json(Hash $data --> Dusk::Gateway::Payload) {
    self.new(|$data);
}

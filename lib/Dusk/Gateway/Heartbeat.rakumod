=begin pod
=head1 Dusk::Gateway::Heartbeat

Manages periodic heartbeat cycle with the Discord Gateway.
Detects zombie connections when ACK is not received.

=end pod

unit class Dusk::Gateway::Heartbeat;

has Numeric $.interval is required;
has Bool    $.ack-received is rw = True;
has Int     $.sequence is rw = 0;
has         $!cancel-tap;
has         &.send-callback is required;  # Called to send heartbeat frame

method start() {
    $!ack-received = True;
    $!cancel-tap = Supply.interval($!interval / 1000).tap: {
        unless $!ack-received {
            # Zombie connection detected — no ACK for last heartbeat
            self.stop();
            die "Gateway zombie connection: no heartbeat ACK received";
        }
        $!ack-received = False;
        &!send-callback(self!heartbeat-payload);
    }
}

method stop() {
    $!cancel-tap.close if $!cancel-tap;
    $!cancel-tap = Nil;
}

method ack() {
    $!ack-received = True;
}

method !heartbeat-payload(--> Str) {
    use JSON::Fast;
    to-json({ op => 1, d => $!sequence || Nil });
}

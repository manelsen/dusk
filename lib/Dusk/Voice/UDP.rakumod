use Dusk::Error;

unit class Dusk::Voice::UDP;

#| IP/port of the Discord Voice server (from OP 2 READY).
has Str $.server-ip   is required;
has Int $.server-port is required;

#| The bot's SSRC assigned by Discord in OP 2.
has Int $.ssrc        is required;

#| Timeout in seconds for the IP Discovery handshake.
has Rat $.discovery-timeout = 5.0;

#| Optional mock socket callback: replaces actual UDP dispatch in tests.
has &!mock-socket;
has IO::Socket::INET $!socket;

#| Set a mock socket callback. Receives a Buf on each send-frame call.
method set-mock-socket(&cb) { &!mock-socket = &cb }

#| Build the 74-byte IP Discovery request packet per Discord Voice API spec.
method build-discovery-packet(--> Buf) {
    my $packet = Buf.new(0 xx 74);
    $packet[0] = 0x00; $packet[1] = 0x01;          # Type: Request
    $packet[2] = 0x00; $packet[3] = 70;             # Length: 70
    $packet[4] = ($!ssrc +> 24) +& 0xFF;
    $packet[5] = ($!ssrc +> 16) +& 0xFF;
    $packet[6] = ($!ssrc +>  8) +& 0xFF;
    $packet[7] =  $!ssrc        +& 0xFF;
    $packet;
}

#| Parse the public IP from bytes 8–71 (null-terminated ASCII string).
method parse-discovery-ip(Blob $response --> Str) {
    Buf.new($response[8..71].grep({ $_ != 0 }).list).decode('ascii');
}

#| Parse the public port from bytes 72–73 (big-endian UInt16).
method parse-discovery-port(Blob $response --> Int) {
    ($response[72] +< 8) +| $response[73];
}

#| Send the IP Discovery packet and await the response.
#| Returns a Promise that keeps with a Hash: { ip, port }.
method discover(--> Promise) {
    start {
        my $reply-channel = Channel.new;

        if &!mock-socket {
            # Mock mode: packet sent via callback; channel never receives — triggers timeout
            my $packet = self.build-discovery-packet();
            &!mock-socket($packet);
        } else {
            # Real UDP: create unconnected socket, send raw datagram, read response
            $!socket = IO::Socket::INET.new(:udp);
            my $packet = self.build-discovery-packet();

            # Send manually to target endpoint
            $!socket.send($packet, :host($!server-ip), :port($!server-port));

            # Read response in background
            start {
                try {
                    my $response = $!socket.recv(:bin, :bytes(74));
                    $reply-channel.send($response);
                }
            }
        }

        # Race: wait for response or timeout
        my $timeout    = Promise.in($!discovery-timeout);
        my $response-p = start { $reply-channel.receive };
        await Promise.anyof($response-p, $timeout);

        if $timeout.status == Kept {
            die Dusk::Error::VoiceUDPDiscoveryFailed.new();
        }

        my $response = await $response-p;
        {
            ip   => self.parse-discovery-ip($response),
            port => self.parse-discovery-port($response),
        };
    }
}

#| Send an encrypted RTP packet over UDP. Non-blocking.
method send-frame(Buf $packet) {
    if &!mock-socket {
        &!mock-socket($packet);
    } else {
        $!socket.send($packet, :host($!server-ip), :port($!server-port)) if $!socket;
    }
}

#| Close the UDP socket.
method close() {
    $!socket.close if $!socket;
    $!socket = Nil;
}

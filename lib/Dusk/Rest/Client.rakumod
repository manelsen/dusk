use Dusk::Rest::Route;
use Dusk::Model::Channel;
use JSON::Fast;
use Cro::HTTP::Client;

unit class Dusk::Rest::Client;

has Str $!token;
has Int $.api-version;
has Str $.base-url;
has &!mock-dispatcher;

method new(:$token!, :$api-version = 10) {
    self.bless(
        token       => $token,
        api-version => $api-version,
        base-url    => "https://discord.com/api/v$api-version"
    )
}

submethod TWEAK(:$token!) {
    $!token = $token;
}

# RNF-02: Security against Token leak
method gist() { "Dusk::Rest::Client<api-v$.api-version>" }
method Str()  { "Dusk::Rest::Client<api-v$.api-version>" }

method set-mock-dispatcher(&dispatcher) {
    &!mock-dispatcher = &dispatcher;
}

method request(Dusk::Rest::Route $route) {
    start {
        my $url = $.base-url ~ $route.path;
        my %headers = (
            'Authorization' => "Bot " ~ $!token,
            'Content-Type'  => 'application/json',
            'User-Agent'    => 'DiscordBot (https://github.com/micelio/Dusk, 0.1.0)'
        );

        my $res;
        if &!mock-dispatcher {
            $res = &!mock-dispatcher($route.method, $url, %headers, $route.has-body ?? $route.body !! Hash);
        } else {
            my $cro-client = Cro::HTTP::Client.new(
                headers => [
                    User-Agent    => %headers<User-Agent>,
                    Authorization => %headers<Authorization>,
                    Content-Type  => %headers<Content-Type>
                ]
            );
            
            my $response;
            my $retries_left = 3;
            my $success = False;

            while $retries_left > 0 && !$success {
                try {
                    if $route.has-body {
                        $response = await $cro-client.request($route.method, $url, body => $route.body);
                    } else {
                        $response = await $cro-client.request($route.method, $url);
                    }
                    $success = True;
                    
                    CATCH {
                        when X::Cro::HTTP::Error {
                            $response = .response;
                            if $response.status == 429 {
                                my $retry-after = $response.header('retry-after') // 1;
                                # Discord returns retry-after in seconds usually. 
                                # Fallback to 1 second if missing.
                                await Promise.in($retry-after.Numeric);
                                $retries_left--;
                            } else {
                                $success = True; # Not a retryable error, break loop
                            }
                        }
                    }
                }
            }
            
            my $body-text = await $response.body-text();
            my $parsed-body = $body-text ?? from-json($body-text) !! Hash;
            
            $res = {
                status => $response.status,
                body   => $parsed-body
            };
        }

        if $res<status> == 200 {
            # This routing to model is naive and hardcoded for the test. 
            # A robust solution needs an endpoint-to-model mapper or `Route` returning the Model type.
            if $route.path ~~ / ^ \/channels\/ \d+ $ / {
                my $content = $res<body> ~~ Positional ?? $res<body>[0] !! $res<body>;
                my $channel = Dusk::Model::Channel.new(
                    id       => $content<id>,
                    name     => $content<name>,
                    type     => $content<type> // 0,
                    guild_id => $content<guild_id> // ''
                );
                $channel;
            } else {
                $res<body>;
            }
        } else {
            die "HTTP Error: $res<status>";
        }
    }
}

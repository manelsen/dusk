use v6.d;
use Dusk::Rest::Route;
use Dusk::Rest::RateLimiter;
use Dusk::Internal::Parser;
use Dusk::Error;
use Cro::HTTP::Client;

unit class Dusk::Rest::Client;

has Str $!token;
has Int $.api-version;
has Str $.base-url;
has &!mock-dispatcher;
has Dusk::Rest::RateLimiter $!limiter = Dusk::Rest::RateLimiter.new;
has Dusk::Internal::Parser $!parser = Dusk::Internal::Parser.new;

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
            'User-Agent'    => 'DiscordBot (https://github.com/micelio/Dusk, 0.3.1)'
        );

        # Proactive Rate Limiting
        # Initial bucket ID is the path if we don't know the real bucket yet
        my $bucket-id = $route.path;

        my $res;
        if &!mock-dispatcher {
            my $retries_left = 3;
            my $done = False;
            while $retries_left > 0 && !$done {
                await $!limiter.acquire($bucket-id);
                $res = &!mock-dispatcher($route.method, $url, %headers, $route.has-body ?? $route.body !! Hash);
                
                # Update limiter state from mock headers if they exist
                if $res<headers> {
                    $!limiter.update($bucket-id, $res<headers>);
                    $bucket-id = $res<headers><x-ratelimit-bucket> // $bucket-id;
                }

                if $res<status> == 429 {
                    my $retry-after = $res<body><retry_after> // 1;
                    if $res<body><global> {
                        await $!limiter.global-wait($retry-after.Numeric);
                    } else {
                        # Should not happen often with proactive limiting, but handle it
                        await Promise.in($retry-after.Numeric);
                    }
                    $retries_left--;
                } else {
                    $done = True;
                }
            }
        } else {
            my $cro-client = Cro::HTTP::Client.new(
                :http<1.1>,
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
                    await $!limiter.acquire($bucket-id);

                    if $route.has-body {
                        $response = await $cro-client.request($route.method, $url, body => $route.body);
                    } else {
                        $response = await $cro-client.request($route.method, $url);
                    }
                    $success = True;

                    # Update limiter state
                    my %resp-headers = $response.headers.map({ .name.lc => .value.Str }).Hash;
                    $!limiter.update($bucket-id, %resp-headers);
                    $bucket-id = %resp-headers<x-ratelimit-bucket> // $bucket-id;
                    
                    CATCH {
                        when X::Cro::HTTP::Error {
                            $response = .response;
                            my %resp-headers = $response.headers.map({ .name.lc => .value.Str }).Hash;
                            $!limiter.update($bucket-id, %resp-headers);
                            $bucket-id = %resp-headers<x-ratelimit-bucket> // $bucket-id;

                            if $response.status == 429 {
                                my $retry-after = %resp-headers<retry-after> // 1;
                                # Check if it's a global rate limit (Cro doesn't parse body here easily)
                                # Discord v10 usually puts this in the body.
                                await Promise.in($retry-after.Numeric);
                                $retries_left--;
                            } else {
                                $success = True;
                            }
                        }
                    }
                }
            }
            
            my $body-text = await $response.body-text();
            $res = {
                status => $response.status,
                body   => $!parser.parse($body-text, model => $route.target-model)
            };
        }

        if $res<status> ~~ 200..299 {
            $res<body>;
        } elsif $res<status> == 401 {
            die Dusk::Error::Unauthorized.new();
        } elsif $res<status> == 403 {
            die Dusk::Error::Forbidden.new();
        } elsif $res<status> == 404 {
            die Dusk::Error::NotFound.new(path => $route.path);
        } else {
            note "API Error Body: " ~ $res<body>.perl if $res<body>;
            die Dusk::Error::APIError.new(status => $res<status>, body => $res<body>);
        }
    }
}

#| High-level helper to get the bot's user object.
method bot-user() {
    use Dusk::Model::User;
    my $route = Dusk::Rest::Route.new(
        method       => 'GET',
        path         => '/users/@me',
        target-model => Dusk::Model::User
    );
    return self.request($route);
}

#!/usr/bin/env raku
# Shared helper for Dusk text/UI smoke tests.
# Provides: api-get(), api-post(), api-patch(), api-delete(), api-put()
# Uses explicit HTTP/1.1 (Cro HTTP/2 times out with Discord CDN) and
# JSON body serialized as Blob (utf-8 encode) as required by Cro.

unit module SmokeHelper;

use Cro::HTTP::Client;
use JSON::Fast;

my $TOKEN = %*ENV<DISCORD_BOT_TOKEN> or die "DISCORD_BOT_TOKEN missing";
my constant BASE = 'https://discord.com/api/v10';

sub client(--> Cro::HTTP::Client) {
    Cro::HTTP::Client.new(
        :http<1.1>,
        headers => [Authorization => "Bot $TOKEN"],
    );
}

sub uri-encode(Str $str --> Str) is export {
    $str.encode('utf-8').list.map({
            my $c = .chr;
            $c ~~ /<[A..Za..z0..9\-\._~]>/ ?? $c !! sprintf("%%%02X", $_)
    }).join;
}

sub handle-response($r) {
    my $body-text = await $r.body-text;
    if $r.status >= 400 {
        note "DEBUG: API Error {$r.status} for {$r.request.method} {$r.request.target}";
        note "DEBUG: Response Body: $body-text";
    }
    return from-json($body-text);
}

sub api-get(Str $path --> Any) is export {
    my $r;
    try {
        $r = await client().get(BASE ~ $path);
        CATCH {
            when X::Cro::HTTP::Error {
                $r = .response;
            }
        }
    }
    handle-response($r);
}

sub api-post(Str $path, %body --> Any) is export {
    my $r;
    try {
        $r = await client().post(
            BASE ~ $path,
            body         => to-json(%body).encode('utf-8'),
            content-type => 'application/json',
        );
        CATCH {
            when X::Cro::HTTP::Error {
                $r = .response;
            }
        }
    }
    handle-response($r);
}

sub api-post-json(Str $path, $body --> Any) is export {
    my $r;
    try {
        $r = await client().post(
            BASE ~ $path,
            body         => to-json($body).encode('utf-8'),
            content-type => 'application/json',
        );
        CATCH {
            when X::Cro::HTTP::Error {
                $r = .response;
            }
        }
    }
    handle-response($r);
}

sub api-patch(Str $path, %body --> Any) is export {
    my $r;
    try {
        $r = await client().patch(
            BASE ~ $path,
            body         => to-json(%body).encode('utf-8'),
            content-type => 'application/json',
        );
        CATCH {
            when X::Cro::HTTP::Error {
                $r = .response;
            }
        }
    }
    handle-response($r);
}

sub api-delete(Str $path --> Int) is export {
    my $r;
    try {
        $r = await client().delete(BASE ~ $path);
        CATCH {
            when X::Cro::HTTP::Error {
                $r = .response;
            }
        }
    }
    if $r.status >= 400 {
        my $body-text = await $r.body-text;
        note "DEBUG: API Error {$r.status} for {$r.request.method} {$r.request.target}";
        note "DEBUG: Response Body: $body-text";
    }
    $r.status;
}

sub api-put(Str $path --> Int) is export {
    my $r;
    try {
        $r = await client().put(
            BASE ~ $path,
        );
        CATCH {
            when X::Cro::HTTP::Error {
                $r = .response;
            }
        }
    }
    # We only care about status for PUT in most tests, but lets see body if error
    if $r.status >= 400 {
        my $body-text = await $r.body-text;
        note "DEBUG: API Error {$r.status} for {$r.request.method} {$r.request.target}";
        note "DEBUG: Response Body: $body-text";
    }
    $r.status;
}

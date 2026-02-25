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

sub api-get(Str $path --> Any) is export {
    my $r = await client().get(BASE ~ $path);
    from-json(await $r.body-text);
}

sub api-post(Str $path, %body --> Any) is export {
    my $r = await client().post(
        BASE ~ $path,
        body         => to-json(%body).encode('utf-8'),
        content-type => 'application/json',
    );
    from-json(await $r.body-text);
}

sub api-post-json(Str $path, $body --> Any) is export {
    my $r = await client().post(
        BASE ~ $path,
        body         => to-json($body).encode('utf-8'),
        content-type => 'application/json',
    );
    from-json(await $r.body-text);
}

sub api-patch(Str $path, %body --> Any) is export {
    my $r = await client().patch(
        BASE ~ $path,
        body         => to-json(%body).encode('utf-8'),
        content-type => 'application/json',
    );
    from-json(await $r.body-text);
}

sub api-delete(Str $path --> Int) is export {
    my $r = await client().delete(BASE ~ $path);
    $r.status;
}

sub api-put(Str $path --> Int) is export {
    my $r = await client().put(
        BASE ~ $path,
        body         => '{}',
        content-type => 'application/json',
    );
    $r.status;
}

use v6.d;

unit class Dusk::Model::PartialChannel is export is export;

has Str $.id;
has Int $.type;
has Str $.guild-id;
has Int $.position;
has Str $.name;
has Str $.topic;
has Bool $.nsfw;
has Int $.bitrate;
has Int $.user-limit;
has Int $.rate-limit-per-user;
has Str $.parent-id;
has Str $.last-message-id;
has Int $.last-pin-timestamp;
has Str $.permission-overwrites;
has Str $.rtc-region;
has Int $.video-quality-mode;
has Int $.default-auto-archive-duration;
has Str $.permissions;
has Str $.flags;

method new(*%args) {
    self.bless(|%args);
}

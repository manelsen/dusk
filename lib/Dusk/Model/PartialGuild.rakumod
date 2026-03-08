use v6.d;

unit class Dusk::Model::PartialGuild is export is export;

has Str $.id;
has Str $.name;
has Str $.icon;
has Str $.splash;
has Str $.discovery-splash;
has Str $.owner-id;
has Str $.application-id;
has Str $.region;
has Str $.afk-channel-id;
has Int $.afk-timeout;
has Bool $.widget-enabled;
has Int $.widget-channel-id;
has Int $.verification-level;
has Int $.default-message-notifications;
has Int $.explicit-content-filter;
has Int $.mfa-level;
has Str $.system-channel-id;
has Str $.system-channel-flags;
has Int $.max-presences;
has Int $.max-members;
has Str $.vanity-url-code;
has Str $.description;
has Str $.banner;
has Str $.premium-tier;
has Int $.premium-subscription-count;
has Str $.preferred-locale;
has Str $.public-updates-channel-id;
has Int $.max-video-channel-users;
has Int $.approximate-member-count;
has Int $.approximate-presence-count;

method new(*%args) {
    self.bless(|%args);
}

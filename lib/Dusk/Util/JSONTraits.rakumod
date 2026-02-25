use v6.d;

unit module Dusk::Util::JSONTraits;

#| Maps a Discord JSON Hash (snake_case) to a Raku-friendly Hash (kebab-case).
#| Only maps keys that exist in the original data.
sub jmap(Hash $data) is export {
    my %mapped;
    for $data.kv -> $k, $v {
        my $new-k = $k.subst('_', '-', :g);
        
        # Color specific hex-to-int conversion
        if $k eq 'color' && $v ~~ Str && $v ~~ /:i ^ <[0..9a..f]>+ $/ {
            %mapped{$new-k} = :16($v);
        } else {
            %mapped{$new-k} = $v;
        }
    }
    return %mapped;
}

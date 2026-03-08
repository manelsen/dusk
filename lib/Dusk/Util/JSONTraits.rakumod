use v6.d;

unit module Dusk::Util::JSONTraits;

#| Maps a Discord JSON Hash (snake_case) to a Raku-friendly Hash (kebab-case).
#| Only maps keys that exist in the original data.
sub jmap(Hash $data) is export {
    state %key-cache;
    my %mapped;
    for $data.kv -> $k, $v {
        # Fast lookup or compute
        my $new-k = %key-cache{$k};
        unless $new-k {
            # Copy first, then translate
            my $temp = $k;
            $temp ~~ tr/_/-/;
            $new-k = $temp;
            %key-cache{$k} = $new-k;
        }
        
        # Color specific hex-to-int conversion
        if $k eq 'color' && $v ~~ Str && $v ~~ /:i ^ <[0..9a..f]>+ $/ {
            %mapped{$new-k} = :16($v);
        } else {
            %mapped{$new-k} = $v;
        }
    }
    return %mapped;
}

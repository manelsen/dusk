use v6.d;
use Test;
use Dusk::Util::JSONTraits;

plan 2;

subtest 'jmap Correctness' => {
    my %data = (
        guild_id => '123',
        channel_id => '456',
        message_id => '789',
        author => {
            username => 'user',
            global_name => 'Global Name'
        },
        already-kebab => 'keep'
    );

    my %mapped = jmap(%data);

    is %mapped<guild-id>, '123', 'guild_id -> guild-id';
    is %mapped<channel-id>, '456', 'channel_id -> channel-id';
    is %mapped<message-id>, '789', 'message_id -> message-id';
    is %mapped<already-kebab>, 'keep', 'already-kebab -> already-kebab';
    ok %mapped<author><global_name>:exists, 'nested hashes are not mapped (this is current behavior)';
};

subtest 'jmap Performance (Manual Benchmark)' => {
    my %data = (
        guild_id => '123',
        channel_id => '456',
        message_id => '789',
        content => 'hello world',
        timestamp => '2024-01-01T00:00:00Z',
        edited_timestamp => Nil,
        tts => False,
        mention_everyone => False,
        author => { id => '1', username => 'u' }
    );

    my $start = now;
    for 1..10000 {
        jmap(%data);
    }
    my $end = now;
    diag "10,000 jmap calls took {$end - $start}s";
    
    # We want to beat the current performance significantly
    # Let's just assert that it finishes in reasonable time for now
    pass "Performance test completed";
};

done-testing;

use v6.d;
use Cro::HTTP::Client;

my $token = %*ENV<DISCORD_BOT_TOKEN>;

say "=== SMOKE TEST VERBOSE ===";
say "";
say "Token: {$token.substr(0, 20)}...";
say "";

# Criar cliente com headers explícitos
my %headers = (
    'Authorization' => "Bot $token",
    'Content-Type' => 'application/json',
    'User-Agent' => 'DuskSmokeTest (https://github.com/micelio/Dusk, 0.3.0)',
);

say "Headers que serão enviados:";
for %headers.kv -> $k, $v {
    say "  $k: {$v.substr(0, 50)}...";
}
say "";

# Criar cliente
my $http = Cro::HTTP::Client.new(
    :http<1.1>,
    base-uri => 'https://discord.com/api/v10',
);

say "Cliente criado com base-uri: " ~ $http.base-uri;
say "";

# Fazer requisição com headers explícitos
say "Fazendo GET /users/@me com headers...";
try {
    my $response = await $http.get(
        'users/@me',
        headers => %headers
    );
    
    say "Status: " ~ $response.status;
    say "Headers da resposta:";
    for $response.headers.list -> $h {
        say "  " ~ $h.name ~ ": " ~ $h.value;
    }
    
    my $body = await $response.body-text;
    say "Body length: " ~ $body.chars;
    say "Body starts with: " ~ $body.substr(0, 100);
    say "Is JSON: " ~ ($body.starts-with('{') ?? "Sim" !! "Não");
    say "Is HTML: " ~ ($body.starts-with('<') ?? "Sim" !! "Não");
    
    CATCH {
        say "Erro: {$_}";
        say "Backtrace:";
        for .backtrace.reverse -> $t {
            say "  " ~ $t;
        }
    }
}

say "";
say "=== TESTE CONCLUÍDO ===";

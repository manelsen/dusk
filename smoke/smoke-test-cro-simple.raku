use v6.d;
use Cro::HTTP::Client;

my $token = %*ENV<DISCORD_BOT_TOKEN>;

say "=== SMOKE TEST SIMPLES COM Cro::HTTP::Client ===";
say "";
say "Token: {$token.substr(0, 20)}...";
say "";

# Criar cliente simples
my $http = Cro::HTTP::Client.new(
    base-uri => 'https://discord.com/api/v10',
    headers => [
        Authorization => "Bot $token",
        Content-Type => 'application/json',
        User-Agent => 'DuskSmokeTest/1.0'
    ]
);

say "Criando cliente Cro...";
say "Base URI: " ~ $http.base-uri;
say "";

# Teste simples: GET /users/@me
say "Teste: GET /users/@me...";
try {
    my $response = await $http.get('users/@me');
    say "  Status: " ~ $response.status;
    
    my $body = await $response.body-text;
    my $preview = $body.substr(0, 200);
    
    say "  Body preview: $preview";
    say "  Is JSON: " ~ ($body.starts-with('{') ?? "Sim" !! "Não");
    say "  Is HTML: " ~ ($body.starts-with('<') ?? "Sim" !! "Não");
    
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";
say "=== TESTE CONCLUÍDO ===";

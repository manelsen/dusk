use v6.d;
use Cro::HTTP::Client;

my $token = %*ENV<DISCORD_BOT_TOKEN>;

say "=== SMOKE TEST COM CORPO COMPLETO ===";
say "";
say "Token: {$token.substr(0, 20)}...";
say "";

# Criar cliente simples
my $http = Cro::HTTP::Client.new(
    :http<1.1>,
    base-uri => 'https://discord.com/api/v10',
    headers => [
        Authorization => "Bot $token",
        Content-Type => 'application/json',
        User-Agent => 'DuskSmokeTest/1.0 (Raku)'
    ]
);

say "Criando cliente Cro...";
say "";

# Teste simples: GET /users/@me
say "Teste: GET /users/@me...";
try {
    my $response = await $http.get('users/@me');
    say "Status: " ~ $response.status;
    say "Headers: " ~ $response.headers.raku;
    
    my $body = await $response.body-text;
    say "Body length: " ~ $body.chars;
    
    # Procurar por mensagens de erro no HTML
    if $body.contains('401') {
        say "❌ 401 Unauthorized detectado no HTML!";
    }
    if $body.contains('403') {
        say "❌ 403 Forbidden detectado no HTML!";
    }
    if $body.contains('Cloudflare') {
        say "❌ Cloudflare detectado!";
    }
    if $body.contains('rate limit') {
        say "❌ Rate limit detectado!";
    }
    
    # Mostrar primeiras 500 linhas do HTML
    my @lines = $body.lines;
    say "Primeiras 30 linhas do HTML:";
    for @lines.head(30) -> $line {
        say "  $line";
    }
    
    CATCH {
        say "Erro: {$_}";
    }
}

say "";
say "=== TESTE CONCLUÍDO ===";

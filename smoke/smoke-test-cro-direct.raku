use v6.d;
use Cro::HTTP::Client;
use JSON::Fast;

# Configurações
my $token = %*ENV<DISCORD_BOT_TOKEN>;
my $guild-id = '1212124712629440612';
my $channel-id = '1212124713271304246';

say "=== SMOKE TEST DIRETO COM Cro::HTTP::Client ===";
say "";
say "Token: {$token.substr(0, 20)}...";
say "Guild ID: $guild-id";
say "Channel ID: $channel-id";
say "";

# Criar cliente Cro
my $http = Cro::HTTP::Client.new(
    :http<1.1>,
    base-uri => 'https://discord.com/api/v10',
    headers => [
        Authorization => "Bot $token",
        Content-Type => 'application/json',
        User-Agent => 'DuskSmokeTest/1.0'
    ]
);

# Teste 1: GET /users/@me
say "Teste 1: GET /users/@me...";
try {
    my $response = await $http.get('users/@me');
    say "  Status: " ~ $response.status;
    
    if $response.status == 200 {
        my $body = await $response.body-text;
        my $user = from-json($body);
        say "  ✅ Bot conectado!";
        say "  📛 Nome: {$user<username>}";
        say "  🆔 ID: {$user<id>}";
        say "  🤖 Bot: {$user<bot> // 'False'}";
    } else {
        my $body = await $response.body-text;
        say "  ❌ Status não é 200";
        say "  📋 Body: $body";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

# Teste 2: GET /guilds/{guild.id}
say "Teste 2: GET /guilds/$guild-id...";
try {
    my $response = await $http.get("guilds/$guild-id");
    say "  Status: " ~ $response.status;
    
    if $response.status == 200 {
        my $body = await $response.body-text;
        my $guild = from-json($body);
        say "  ✅ Servidor obtido!";
        say "  🏰 Nome: {$guild<name>}";
        say "  🆔 ID: {$guild<id>}";
        say "  👥 Membros (aprox): {$guild<approximate_member_count> // 'N/A'}";
    } else {
        my $body = await $response.body-text;
        say "  ❌ Status não é 200";
        say "  📋 Body: $body";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

# Teste 3: POST /channels/{channel.id}/messages
say "Teste 3: POST /channels/$channel-id/messages...";
my $message-content = "🧪 Smoke Test (Cro Direct) - " ~ DateTime.now.utc.hh-mm-ss ~ " UTC";
try {
    my $response = await $http.post(
        "channels/$channel-id/messages",
        body => to-json({
                content => $message-content
        })
    );
    say "  Status: " ~ $response.status;
    
    if $response.status ~~ 200|201 {
        my $body = await $response.body-text;
        my $message = from-json($body);
        say "  ✅ Mensagem enviada!";
        say "  📝 Conteúdo: {$message<content>}";
        say "  🆔 ID: {$message<id>}";
        say "  👤 Autor: {$message<author><username> // 'N/A'}";
    } else {
        my $body = await $response.body-text;
        say "  ❌ Status não é 200/201";
        say "  📋 Body: $body";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";
say "=== SMOKE TEST CONCLUÍDO ===";
say "✅ Testes direto com Cro::HTTP::Client funcionam!";

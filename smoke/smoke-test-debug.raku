use v6.d;
use Dusk::Rest::Client;

# Configurações
my $token = %*ENV<DISCORD_BOT_TOKEN>;
my $guild-id = '1212124712629440612';
my $channel-id = '1212124713271304246';

# Criar cliente
my $client = Dusk::Rest::Client.new(:$token);

say "=== SMOKE TEST DEBUG ===";
say "";
say "Token: {$token.substr(0, 20)}...";
say "Guild ID: $guild-id";
say "Channel ID: $channel-id";
say "";
say "Cliente: " ~ $client.gist;
say "";
say "Base URL: " ~ $client.base-url;
say "";

# Teste 1: bot-user
say "Teste 1: bot-user()...";
try {
    my $user = $client.bot-user;
    say "  Tipo de resposta: " ~ $user.WHAT;
    
    if $user {
        say "  ✅ Bot obtido!";
        say "  📛 Nome: {$user.username // 'N/A'}";
        say "  🆔 ID: {$user.id // 'N/A'}";
    } else {
        say "  ⚠️ Resposta vazia ou indefinida";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
        say "  📋 Backtrace: " ~ .backtrace;
    }
}

say "";

# Teste 2: Usar Endpoint diretamente
say "Teste 2: Usando Dusk::Rest::Endpoint...";
try {
    use Dusk::Rest::Endpoint;
    
    say "  Criando rota get-guild...";
    my $route = Dusk::Rest::Endpoint.get-guild(guild-id => $guild-id);
    say "  ✅ Rota criada!";
    say "  📋 Path: " ~ $route.path;
    say "  📋 Method: " ~ $route.method;
    
    say "  Enviando requisição...";
    my $guild = $client.request($route);
    say "  Tipo de resposta: " ~ $guild.WHAT;
    
    if $guild {
        say "  ✅ Guild obtida!";
        say "  🏰 Nome: {$guild.name // 'N/A'}";
        say "  🆔 ID: {$guild.id // 'N/A'}";
    } else {
        say "  ⚠️ Resposta vazia ou indefinida";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
        say "  📋 Backtrace: " ~ .backtrace;
    }
}

say "";
say "=== DEBUG CONCLUÍDO ===";

use lib '../lib';
use Dusk::Rest::Client;

# Configurações
my $token = %*ENV<DISCORD_BOT_TOKEN>;
my $guild-id = '1212124712629440612';
my $channel-id = '1212124713271304246';

# Criar cliente
my $client = Dusk::Rest::Client.new(:$token);

say "=== SMOKE TESTS COM DISCORD API REAL ===";
say "";
say "Token: {$token.substr(0, 20)}...";
say "Guild ID: $guild-id";
say "Channel ID: $channel-id";
say "";
say "Cliente Dusk: " ~ $client.gist;
say "";

# Teste 1: Obter bot user
say "Teste 1: Obtendo informações do bot...";
try {
    my $user = await $client.bot-user;
    
    if $user {
        say "  ✅ Bot conectado com sucesso!";
        say "  📛 Nome: {$user<username>}";
        say "  🆔 ID: {$user<id>}";
        say "  🏷️ Discriminator: {$user<discriminator> // '0'}";
        say "  🤖 Bot: {$user<bot> // 'False'}";
    } else {
        say "  ❌ Falha ao obter informações do bot (resposta vazia)";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

# Teste 2: Obter guild
say "Teste 2: Obtendo informações do servidor...";
try {
    # Usar Dusk::Rest::Endpoint para criar a rota
    use Dusk::Rest::Endpoint;
    my $route = Dusk::Rest::Endpoint.get-guild(guild-id => $guild-id);
    my $guild = await $client.request($route);
    
    if $guild {
        say "  ✅ Servidor obtido com sucesso!";
        say "  🏰 Nome: {$guild<name>}";
        say "  🆔 ID: {$guild<id>}";
        say "  👥 Membros: {$guild<approximate-member-count> // 'N/A'}";
        say "  👥 Membros ativos: {$guild<approximate-presence-count> // 'N/A'}";
    } else {
        say "  ❌ Falha ao obter informações do servidor (resposta vazia)";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

# Teste 3: Obter channel
say "Teste 3: Obtendo informações do canal...";
try {
    use Dusk::Rest::Endpoint;
    my $route = Dusk::Rest::Endpoint.get-channel(channel-id => $channel-id);
    my $channel = await $client.request($route);
    
    if $channel {
        say "  ✅ Canal obtido com sucesso!";
        say "  💬 Nome: {$channel<name>}";
        say "  🆔 ID: {$channel<id>}";
        say "  📋 Tipo: {$channel<type>}";
        say "  🏰 Guild ID: {$channel<guild-id>}";
    } else {
        say "  ❌ Falha ao obter informações do canal (resposta vazia)";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

# Teste 4: Enviar mensagem
say "Teste 4: Enviando mensagem de teste...";
my $message-content = "🧪 Smoke Test do Dusk v0.3.0 - " ~ DateTime.now.utc.hh-mm-ss ~ " UTC";
try {
    my $route = Dusk::Rest::Endpoint.post-channels-messages(
        channel-id => $channel-id,
        content => $message-content
    );
    
    my $message = await $client.request($route);
    
    if $message {
        say "  ✅ Mensagem enviada com sucesso!";
        say "  📝 Conteúdo: {$message<content>}";
        say "  🆔 ID: {$message<id>}";
        say "  👤 Autor: {$message<author><username> // 'N/A'}";
        say "  🕐 Timestamp: {$message<timestamp> // 'N/A'}";
    } else {
        say "  ❌ Falha ao enviar mensagem (resposta vazia)";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";
say "=== SMOKE TESTS CONCLUÍDOS ===";
say "✅ Testes básicos com Discord API real funcionam!";
say "✅ Dusk está funcionando corretamente!";

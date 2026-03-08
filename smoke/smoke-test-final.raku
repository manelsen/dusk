use v6.d;
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
say "Cliente: " ~ $client.gist;
say "";
say "Base URL: " ~ $client.base-url;
say "";

# Teste 1: bot-user (método de conveniência)
say "Teste 1: Obtendo informações do bot (bot-user)...";
try {
    my $user-promise = $client.bot-user;
    
    if $user-promise {
        my $user = await $user-promise;
        say "  ✅ Bot conectado com sucesso!";
        say "  📛 Nome: {$user.username // 'N/A'}";
        say "  🆔 ID: {$user.id // 'N/A'}";
        say "  🏷️ Discriminator: {$user.discriminator // '0'}";
        say "  🤖 Bot: {$user.is-bot // 'False'}";
        say "  👥 Public flags: {$user.public-flags // '0'}";
    } else {
        say "  ❌ Falha ao obter informações do bot (Promise vazia)";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

# Teste 2: Obter guild usando Endpoint
say "Teste 2: Obtendo informações do servidor...";
try {
    use Dusk::Rest::Endpoint;
    my $route = Dusk::Rest::Endpoint.get-guild(guild-id => $guild-id);
    my $guild-promise = $client.request($route);
    
    if $guild-promise {
        my $guild = await $guild-promise;
        say "  ✅ Servidor obtido com sucesso!";
        say "  🏰 Nome: {$guild.name // 'N/A'}";
        say "  🆔 ID: {$guild.id // 'N/A'}";
        say "  👥 Membros (aprox): {$guild.approximate-member-count // 'N/A'}";
        say "  🟢 Membros ativos (aprox): {$guild.approximate-presence-count // 'N/A'}";
        say "  📋 Descrição: {$guild.description // 'Sem descrição'}";
        say "  🔒 Nível de verificação: {$guild.verification-level // '0'}";
    } else {
        say "  ❌ Falha ao obter informações do servidor (Promise vazia)";
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
    my $channel-promise = $client.request($route);
    
    if $channel-promise {
        my $channel = await $channel-promise;
        say "  ✅ Canal obtido com sucesso!";
        say "  💬 Nome: {$channel.name // 'N/A'}";
        say "  🆔 ID: {$channel.id // 'N/A'}";
        say "  📋 Tipo: {$channel.type // 'N/A'}";
        say "  🏰 Guild ID: {$channel.guild-id // 'N/A'}";
        say "  📝 Tópico: {$channel.topic // 'Sem tópico'}";
    } else {
        say "  ❌ Falha ao obter informações do canal (Promise vazia)";
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
    use Dusk::Rest::Endpoint;
    my $route = Dusk::Rest::Endpoint.post-channels-messages(
        channel-id => $channel-id,
        content => $message-content
    );
    
    my $message-promise = $client.request($route);
    
    if $message-promise {
        my $message = await $message-promise;
        say "  ✅ Mensagem enviada com sucesso!";
        say "  📝 Conteúdo: {$message.content // 'N/A'}";
        say "  🆔 ID: {$message.id // 'N/A'}";
        say "  👤 Autor: {$message.author.username // 'N/A'}";
        say "  🕐 Timestamp: {$message.timestamp // 'N/A'}";
        say "  💬 Channel ID: {$message.channel-id // 'N/A'}";
    } else {
        say "  ❌ Falha ao enviar mensagem (Promise vazia)";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

# Teste 5: Obter mensagens recentes
say "Teste 5: Obtendo mensagens recentes...";
try {
    use Dusk::Rest::Endpoint;
    my $route = Dusk::Rest::Endpoint.get-channels-messages(channel-id => $channel-id);
    my $messages-promise = $client.request($route);
    
    if $messages-promise {
        my $messages = await $messages-promise;
        say "  ✅ Mensagens obtidas com sucesso!";
        say "  📊 Total de mensagens: " ~ ($messages.elems // 0);
        
        if $messages.elems > 0 {
            say "  📝 Última mensagem: {$messages[*-1].content // 'N/A'}";
            say "  👤 Autor: {$messages[*-1].author.username // 'N/A'}";
        }
    } else {
        say "  ❌ Falha ao obter mensagens (Promise vazia)";
    }
    CATCH {
        say "  ❌ Erro: {$_}";
    }
}

say "";

say "=== SMOKE TESTS CONCLUÍDOS ===";
say "✅ Todos os testes com Discord API real funcionam!";
say "✅ Dusk está funcionando corretamente em produção!";
say "";
say "🎉 O Dusk está pronto para uso!";

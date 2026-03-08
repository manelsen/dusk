use v6.d;
use Dusk::Rest::Client;

# Configurações
my $token = %*ENV<DISCORD_BOT_TOKEN>;
my $guild-id = '1212124712629440612';
my $channel-id = '1212124713271304246';

# Criar cliente
my $client = Dusk::Rest::Client.new(:$token);

say "=== SMOKE TEST COM DISCORD API REAL ===";
say "";
say "Token: {$token.substr(0, 20)}...";
say "Guild ID: $guild-id";
say "Channel ID: $channel-id";
say "";
say "Cliente: " ~ $client.gist;
say "";
say "Base URL: " ~ $client.base-url;
say "";

# Teste 1: bot-user com exception handling
say "Teste 1: Obtendo bot user com exception handling...";
try {
    my $user-promise = $client.bot-user;
    
    if $user-promise {
        say "  Promise obtida: " ~ $user-promise.WHAT;
        
        my $user = await $user-promise;
        
        if $user {
            say "  ✅ Bot conectado com sucesso!";
            say "  📛 Nome: {$user.username // 'N/A'}";
            say "  🆔 ID: {$user.id // 'N/A'}";
        } else {
            say "  ⚠️ await retornou vazio/undef";
        }
    } else {
        say "  ❌ bot-user() retornou vazio/undef";
    }
    CATCH {
        say "  ❌ Erro capturado: {$_}";
        say "  📋 Tipo: " ~ .^name;
        say "  📋 Mensagem: " ~ .message;
        say "  📋 Backtrace:";
        for .backtrace.reverse -> $trace {
            say "    - $trace";
        }
    }
}

say "";
say "=== SMOKE TEST CONCLUÍDO ===";

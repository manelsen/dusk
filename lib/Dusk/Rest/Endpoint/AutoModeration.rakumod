use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::AutoModeration does Dusk::Rest::Endpoint::Base;

method get-guild-auto-moderation-rules(:$guild-id!) {
    self.route('GET', "/guilds/$guild-id/auto-moderation/rules")
}

method get-guild-auto-moderation-rule(:$guild-id!, :$rule-id!) {
    self.route('GET', "/guilds/$guild-id/auto-moderation/rules/$rule-id")
}

method post-guild-auto-moderation-rule(:$guild-id!, *%body) {
    self.route('POST', "/guilds/$guild-id/auto-moderation/rules", :%body)
}

method patch-guild-auto-moderation-rule(:$guild-id!, :$rule-id!, *%body) {
    self.route('PATCH', "/guilds/$guild-id/auto-moderation/rules/$rule-id", :%body)
}

method delete-guild-auto-moderation-rule(:$guild-id!, :$rule-id!) {
    self.route('DELETE', "/guilds/$guild-id/auto-moderation/rules/$rule-id")
}

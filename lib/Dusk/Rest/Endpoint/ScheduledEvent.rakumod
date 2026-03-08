use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::ScheduledEvent does Dusk::Rest::Endpoint::Base;

method get-guild-scheduled-events(:$guild-id!, :$with-user-count = False) {
    self.route('GET', "/guilds/$guild-id/scheduled-events", :query({ with_user_count => $with-user-count }))
}

method get-guild-scheduled-event(:$guild-id!, :$scheduled-event-id!, :$with-user-count = False) {
    self.route('GET', "/guilds/$guild-id/scheduled-events/$scheduled-event-id", :query({ with_user_count => $with-user-count }))
}

method post-guild-scheduled-event(:$guild-id!, *%body) {
    self.route('POST', "/guilds/$guild-id/scheduled-events", :%body)
}

method patch-guild-scheduled-event(:$guild-id!, :$scheduled-event-id!, *%body) {
    self.route('PATCH', "/guilds/$guild-id/scheduled-events/$scheduled-event-id", :%body)
}

method delete-guild-scheduled-event(:$guild-id!, :$scheduled-event-id!) {
    self.route('DELETE', "/guilds/$guild-id/scheduled-events/$scheduled-event-id")
}

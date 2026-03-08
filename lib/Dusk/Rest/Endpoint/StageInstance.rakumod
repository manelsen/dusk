use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::StageInstance does Dusk::Rest::Endpoint::Base;

method get-stage-instance(:$channel-id!) {
    self.route('GET', "/stage-instances/$channel-id")
}

method post-stage-instance(*%body) {
    self.route('POST', "/stage-instances", :%body)
}

method patch-stage-instance(:$channel-id!, *%body) {
    self.route('PATCH', "/stage-instances/$channel-id", :%body)
}

method delete-stage-instance(:$channel-id!) {
    self.route('DELETE', "/stage-instances/$channel-id")
}

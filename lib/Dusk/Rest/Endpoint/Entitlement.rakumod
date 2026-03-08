use Dusk::Rest::Endpoint::Base;

unit role Dusk::Rest::Endpoint::Entitlement does Dusk::Rest::Endpoint::Base;

method get-entitlements(:$application-id!, *%query) {
    self.route('GET', "/applications/$application-id/entitlements", :%query)
}

method post-entitlement(:$application-id!, *%body) {
    self.route('POST', "/applications/$application-id/entitlements", :%body)
}

method delete-entitlement(:$application-id!, :$entitlement-id!) {
    self.route('DELETE', "/applications/$application-id/entitlements/$entitlement-id")
}

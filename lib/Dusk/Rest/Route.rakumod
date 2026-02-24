unit class Dusk::Rest::Route;

has Str $.method is required;
has Str $.path   is required;
has %.body;

method has-body() returns Bool {
    return %!body.elems > 0;
}

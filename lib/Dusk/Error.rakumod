unit module Dusk::Error;

class RateLimit is Exception is export {
    has Int $.status = 429;
    has Numeric $.retry-after;
    method message() { "Discord Rate Limited: retry after $.retry-after seconds" }
}

class Unauthorized is Exception is export {
    has Int $.status = 401;
    method message() { "Discord API: Unauthorized (invalid or missing token)" }
}

class Forbidden is Exception is export {
    has Int $.status = 403;
    method message() { "Discord API: Forbidden (insufficient permissions)" }
}

class NotFound is Exception is export {
    has Int $.status = 404;
    has Str $.path;
    method message() { "Discord API: Not Found ($.path)" }
}

class APIError is Exception is export {
    has Int $.status;
    has $.body;
    method message() { "Discord API Error: HTTP $.status" }
}

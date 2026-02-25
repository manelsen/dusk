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

# --- Voice Errors ---

#| Raised when libsodium is not installed or cannot be loaded.
class LibsodiumNotFound is Exception is export {
    has Str $.hint = "Install libsodium-dev: apt install libsodium-dev (Debian/Ubuntu) or brew install libsodium (macOS)";
    method message() { "Dusk::Voice requires libsodium. $.hint" }
}

#| Raised when ffmpeg is not found on PATH.
class FfmpegNotFound is Exception is export {
    has Str $.hint = "Install ffmpeg: apt install ffmpeg (Debian/Ubuntu) or brew install ffmpeg (macOS)";
    method message() { "Dusk::Voice requires ffmpeg. $.hint" }
}

#| Raised when UDP IP Discovery does not receive a response within the timeout.
class VoiceUDPDiscoveryFailed is Exception is export {
    method message() { "Voice UDP IP Discovery timed out. Check firewall / NAT settings." }
}

#| Raised when the Voice Gateway session expires or is invalidated (e.g. WS close code 4006).
class VoiceSessionTimeout is Exception is export {
    has Int $.code = 4006;
    method message() { "Voice session timed out or was invalidated (close code: $.code). Re-joining is required." }
}

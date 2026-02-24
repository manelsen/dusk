# OBSERVABILITY AND METRICS
## Gate 10 - Operability Readiness

The `Dusk` Raku module is a library for bots, meaning the telemetry and observability stack heavily depends on the downstream implementation utilizing the models. However, the library provides boundaries where exceptions and logic hooks can be tied.

### 1. Operational Signals

#### A. Logs
- **Error Exceptions (`X::Cro::HTTP::Error`)**: Propagated upward whenever an unhandled generic HTTP failure occurs past the 3 allowed retry loops in rate-limiting.
- **Model Deserialization Failures (Type Checks)**: `Type Check Failed` exceptions happen fast-fail style upon mismatched properties bridging JSON into `Dusk::Model::*`. These serve as direct log signals that the Discord API has changed a payload signature.

#### B. Metrics
- Downstream bot architects should increment counters surrounding the `.request` Promise blocks exposed by `Dusk::Rest::Client`.
- High metrics on `HTTP 429` signals that `Retry-After` sleep intervals are being hit, directly degrading performance latency.

#### C. Traces
- All Raku network calls execute concurrently due to the `start {}` loop wrapper natively providing non-blocking asynchronous event chains. Trace IDs should be stitched externally before `await`.

### 2. Detectability 
By ensuring 100% encapsulation, `Dusk` guarantees that when a critical failure occurs (such as Discord going offline, or Discord banning the Token), it will hard-crash via explicit Exceptions rather than silently silencing null objects, triggering any configured PM2 or Docker heal-check logic instantly.

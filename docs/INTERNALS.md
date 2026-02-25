# Dusk Internal Architecture: JSON Mapping with Traits

Dusk uses a declarative, meta-programming approach to map Discord's `snake_case` JSON payloads to idiomatic Raku `kebab-case` attributes.

## Key Components

### 1. `Dusk::Util::JSONTraits`
This module provides the magic. It defines custom Raku traits that attach metadata to attributes at compile-time.

*   `is json-snake`: Applied to a **class**. Automatically maps all kebab-case attributes to snake_case JSON keys.
*   `is json-name('custom_key')`: Applied to an **attribute**. Overrides the automatic mapping for a specific field.
*   `jmap($type, %data)`: A factory function that uses the traits to instantiate `$type`.

## Standard Model Pattern

To implement a new model or refactor an existing one, follow this pattern:

```raku
use Dusk::Util::JSONTraits;
use Dusk::Model::OtherModel;

# 1. Apply the class trait
unit class Dusk::Model::MyModel is json-snake;

# 2. Declare attributes with explicit types for auto-coercion
has Str  $.id is required;
has Int  $.type;
has Bool $.enabled;

# 3. Use generic types ($) for nested objects/models
has $.author; 

# 4. Handle nested complexity in TWEAK
submethod TWEAK(:$author) {
    # jmap handles recursion safely
    $!author = $author ~~ Hash ?? jmap(Dusk::Model::User, $author) !! $author;
}
```

## Why this approach?
- **DRY (Don't Repeat Yourself):** No manual `.new` or `.bless` calls for simple fields.
- **Type Safety:** `jmap` respects Raku types and performs smart coercion (including Hex -> Int for colors).
- **Maintainability:** Adding a new field only requires adding the `has` declaration.

## Performance Note
Mapping is performed via the Meta-Object Protocol (MOP) during the `jmap` call. While slightly more overhead than a hardcoded constructor, it is negligible compared to network latency and provides a massive gain in code legibility.

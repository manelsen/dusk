=begin pod
=head1 Dusk::Event

Base role for all Discord Gateway events.
Wraps the raw JSON payload while providing typed accessors in concrete classes.

=head2 Usage

class Dusk::Event::MessageCreate does Dusk::Event {
method content(--> Str) { self.raw<content> }
}

=end pod

unit role Dusk::Event;

#| The raw payload (JSON decoded into a Hash) originally sent by Discord.
has Hash $.raw is required;

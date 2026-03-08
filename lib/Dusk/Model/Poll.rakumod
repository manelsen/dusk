use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::Poll is export;

#| Question object for the poll.
class Question {
    has Str $.text;
}

#| Answer object for the poll.
class Answer {
    has Int $.answer-id;
    has Hash $.poll-media;
}

#| Results object for the poll.
class Results {
    has Bool $.is-finalized;
    has Positional $.answer-counts;
}

has Question $.question;
has Positional $.answers;
has Instant $.expiry;
has Bool $.allow-multiselect;
has Int $.layout-type;
has Results $.results;

method from-json($data) {
    my %m = jmap($data);
    self.new(
        question          => Question.new(text => %m<question><text>),
        answers           => (%m<answers> // []).map({ Answer.new(|$jmap($_)) }).List,
        expiry            => %m<expiry> ?? Instant.from-rfc3339(%m<expiry>) !! Nil,
        allow-multiselect => ?%m<allow-multiselect>,
        layout-type       => %m<layout-type> // 1,
        results           => %m<results> ?? Results.new(|jmap(%m<results>)) !! Nil,
    )
}

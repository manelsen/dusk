use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Attachment;

plan 1;

subtest 'Attachment Parsing' => {
    my $json = "t/fixtures/rest_attachment.json".IO.slurp;
    my $data = from-json($json);
    
    my $att = Dusk::Model::Attachment.new(|$data[0]);
    
    isa-ok $att, Dusk::Model::Attachment, 'Correct type';
    is $att.id, "1472010770148757640", 'ID parsed';
    is $att.filename, "test.png", 'Filename parsed';
    is $att.size, 1024, 'Size parsed';
    is $att.url, "https://cdn.discordapp.com/attachments/1/2/test.png", 'URL parsed';
    is $att.content-type, "image/png", 'Content-type parsed';
    is $att.width, 100, 'Width parsed';
};

use strict;
use Test::More;
use UnQLite;

my $db = UnQLite->open(':memory:');
my $jx9 = <<'JX9';
print "Hello, world.";
JX9

my $out;
$db->exec($jx9, {
    output => sub { $out .= $_[0] },
    argv => [qw/Hello world/],
});

is $out => "Hello, world.";

done_testing;

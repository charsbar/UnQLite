use strict;
use Test::More;

use File::Temp qw(tempdir);
use UnQLite;

my $tmp = tempdir( CLEANUP => 1 );

# As of this writing, transactions are not supported for in-memory databases. (http://unqlite.org/c_api/unqlite_open.html)

{
    my $db = UnQLite->open("$tmp/foo.db");
    ok $db->begin;
    ok $db->kv_store("foo" => "bar");
    ok $db->commit;
    is $db->kv_fetch("foo") => "bar";
    ok $db->begin;
    ok $db->kv_store("yay" => "yappo");
    ok $db->rollback;
    isnt $db->kv_fetch("yay") => "yappo";
}

done_testing;

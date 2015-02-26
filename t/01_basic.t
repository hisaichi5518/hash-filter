use strict;
use warnings;
use Test::More;
use Hash::Filter;

subtest "#filter" => sub {
    my $f = Hash::Filter->new(filters => ["password"]);
    my $hash = {
        password => "hisaichi5518",
        name     => "hisaichi5518",
        deep     => {deep => {password => "hisaichi5518"}},
    };

    is_deeply $f->filter($hash), {
        password => $Hash::Filter::FILTERED,
        name     => "hisaichi5518",
        deep     => {deep => {password => $Hash::Filter::FILTERED}},
    };
};

done_testing;

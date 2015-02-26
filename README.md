# NAME

Hash::Filter - filtering Hash's value by Hash's key.

# SYNOPSIS

    use Hash::Filter;
    my $f = Hash::Filter->new(filters => ["password"]);
    $f->filter({password => "12345", hoge => "hoge"}) #=> {password => "[FILTERED]", hoge => "hoge"}

# DESCRIPTION

Hash::Filter is filtering Hash's value by Hash's key.

# LICENSE

Copyright (C) hisaichi5518.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

hisaichi5518 <hisaichi5518@gmail.com>

package Hash::Filter;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Mouse;

has filters => (
    is => "ro",
    isa => "ArrayRef[Str]",
    required => 1,
);

has _compiled_filter => (
    is => "rw",
    isa => "RegexpRef",
);

no Mouse;

our $FILTERED = "[FILTERED]";

sub BUILD {
    my ($self) = @_;
    my $compiled = $self->_compile_filters;
    $self->_compiled_filter($compiled);
}

sub filter {
    my ($self, $params) = @_;

    my $result = {};
    for my $key (keys %$params) {
        my $val = $params->{$key};

        if ($key =~ $self->_compiled_filter) {
            $val = $FILTERED;
        }
        elsif (ref $val eq "HASH") {
            $val = $self->filter($val);
        }
        elsif (ref $val eq "ARRAY") {
            $val = [map {
              (ref $_ eq "HASH") ? $self->filter($_) : $_;
            } @$val];
        }
        $result->{$key} = $val;
    }

    $result;
}

sub _compile_filters {
    my ($self) = @_;
    my $regexp_str = join "|", @{$self->filters};
    qr/$regexp_str/;
}

1;
__END__

=encoding utf-8

=head1 NAME

Hash::Filter - filtering Hash's value by Hash's key.

=head1 SYNOPSIS

    use Hash::Filter;
    my $f = Hash::Filter->new(filters => ["password"]);
    $f->filter({password => "12345", hoge => "hoge"}) #=> {password => "[FILTERED]", hoge => "hoge"}

=head1 DESCRIPTION

Hash::Filter is filtering Hash's value by Hash's key.

=head1 LICENSE

Copyright (C) hisaichi5518.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

hisaichi5518 E<lt>hisaichi5518@gmail.comE<gt>

=cut


package Module::CPANfile::Requirement;
use strict;
use overload q("") => sub { $_[0]->version }, fallback => 1;

sub as_hashref {
    my $self = shift;
    return +{ %$self };
}

sub options {
    my $self = shift;

    my $hash = $self->as_hashref;
    delete $hash->{$_} for qw( name version );

    $hash;
}

sub new {
    my ($class, %args) = @_;

    $args{version} ||= 0;

    bless +{
        name    => $args{name},
        version => $args{version},
        (exists $args{git} ? (git => $args{git}) : ()),
        (exists $args{rev} ? (rev => $args{rev}) : ()),
    }, $class;
}

sub name    { shift->{name} }
sub version { shift->{version} }

sub git { shift->{git} }
sub rev { shift->{rev} }

1;
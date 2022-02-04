package Perlisp;

use 5.024;
use warnings;
no warnings 'experimental::signatures';
use feature 'signatures';

package Perlisp::Expr;

sub new {
    my ($class, $type, $value ) = @_;
    return bless [ $type => $value ], $class;
}

sub type ( $expr ) { return $expr->[0] };
sub value ( $expr )  { return $expr->[1] };

package Perlisp;

sub is_atom ($expr) {
    my $type = $expr->type;
    return
         $type eq 'Symbol'
      || $type eq 'Number'
      || $type eq 'String'
      || $type eq 'Boolean';
}

sub is_symbol ($expr) { return $expr->type eq 'Symbol'; }

sub lookup ($expr, $env) {
    if ( exists $env->{$expr->value} ) {
        return $env->{$expr->value};
    }
    else {
        ...;
    }
}

sub evaluate ( $expr, $env ) {
    if ( is_atom($expr) ) {
        if ( is_symbol($expr) ) {
            return lookup( $expr, $env );
        }
        else {
            return $expr;
        }
    }
    else {
        ...;
    }
}

1;

__END__

"foo" -not this-> Atom("foo") -but this-> is_atom(Atom("foo"))

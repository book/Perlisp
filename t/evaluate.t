use 5.024;
use warnings;
use Test::More;
use Perlisp;

is( Perlisp::evaluate( Perlisp::Expr->new( Symbol => 'foo' ), { foo => 1 } ),
    1, "evaluate( foo ) with env { foo => 1 }" );

is( eval { Perlisp::evaluate( Perlisp::Expr->new( Symbol => 'foo' ), {} ) },
    undef, "evaluate( foo ) with empty env dies" );
like( $@, qr{\AUnimplemented}, "Code is not there yet" );

done_testing;

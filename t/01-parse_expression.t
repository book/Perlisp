use 5.024;
use warnings;
use Test::More;
use Perlisp;

my @tests = (
    [ '1'           => [ number => 1 ] ],        # number
    [ 'bam'         => [ symbol => 'bam' ] ],    # symbol
);

for my $t ( @tests ) {
    my ($source, @expr) = @$t;
    is_deeply(
       [ Perlisp->parse_expression( Perlisp->tokenize( $source ) ) ],
       \@expr,
       "Parsed: $source"
    );
}

done_testing;

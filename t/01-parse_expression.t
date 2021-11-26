use 5.024;
use warnings;
use Test::More;
use Data::Dumper;
use Perlisp;

my @tests = (
    [ '1'           => [ number => 1 ] ],        # number
    [ 'bam'         => [ symbol => 'bam' ] ],    # symbol
    [ '( 1 bam 2kayo )' => [ [ number => 1 ], [ symbol => 'bam' ], [ number => 2 ] ] ],
);

for my $t (@tests) {
    my ( $source, @expr ) = @$t;
    my $got = [ Perlisp->parse_expression( Perlisp->tokenize($source) ) ];
    is_deeply( $got, \@expr, "Parsed: $source" )
      or do {
        diag Dumper($got);
        diag Dumper( \@expr );
      };
}

my @fails = (
    #[ '1 )' => 'closing paren found' ],
);

for my $t (@fails) {
    my ( $source, $fail ) = @$t;
    ok( !eval { Perlisp->parse_expression( Perlisp->tokenize($source) ) },
        "Failed to parse: $source" );
    like( $@, qr{\A$fail}, "Error: $fail" );
}

done_testing;

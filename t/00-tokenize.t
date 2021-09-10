use 5.024;
use warnings;
use Test::More;
use Perlisp;

my @tests = (
    [ '1'               => '1' ],
    [ 'bam'             => 'bam' ],
    [ '(+ 1 19)'        => qw( ( + 1 19 ) ) ],
    [ '(+ 1 (- 10 3 ))' => qw( ( + 1 ( - 10 3 ) ) ) ],
);

for my $t (@tests) {
    my ( $string, @tokens ) = @$t;
    is_deeply( [ Perlisp->tokenize($string) ], \@tokens, "Tokenized: $string" );
}

done_testing;

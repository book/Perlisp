package Perlisp;

use 5.024;    # includes use strict
use warnings;
use experimental 'signatures';

# REPL
# interpret(program):
#   for each line:
#     eval(parse(line))

sub parse ( $self, $string ) {
    my @tokens = map { split / +/ } split /([()])/, $string;
}

1;

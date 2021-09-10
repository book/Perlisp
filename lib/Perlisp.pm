package Perlisp;

use 5.024;    # includes use strict
use warnings;
use experimental 'signatures';

# REPL
# interpret(program):
#   for each line:
#     eval(parse(line))

sub tokenize( $self, $string ) {
    return grep $_, split / +/, $string =~ s{([()])}{ $1 }gr;
}

1;

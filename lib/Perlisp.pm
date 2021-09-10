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

sub parse_expression ( $self, @list ) {
    return if !@list;    # done

    my $token = shift @list;
    if ( $token eq ')' ) {
        die "closing paren found\n";
    }

    my @expr;
    my $type;
    if ( $token =~ /\A-?[0-9]/ ) {    # starts with a number, surely it's one
        $token += 0;                  # well, force perl to make it a number
        $type = 'number';
    }
    else {                            # everything else is a symbol
        $type = 'symbol';
    }
    push @expr, [ $type => $token ];

    return @expr;
}

1;

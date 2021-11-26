package Perlisp;

use 5.024;    # includes use strict
use warnings;
use experimental 'signatures';

# REPL
# interpret(program):
#   for each line:
#     eval(parse(line))

# symbol, e.g. philippe, ulises, atom, etc.
# numbers, e.g. 1, 1.2, -1, -1.2
# expression, e.g. (expression expression...) | symbol | number
#
# symbol -> Perl string <- here 
# number -> Perl "number"
# (expression expression ...) -> Perl array

# if it's ")" -> error
# if it's "(" -> list of exps until next ")"
# if it begins with [0-9] -> parse number
# parse symbol
#
# "(+ 19 100 foo)" -> ["(", "+", "19", "100", "foo", ")"]
# [token1, token2, ...] -> something we can eval
# something we can eval -> eval(the thing)
#
#
# "12" -> ["12"]
# ["12"] -> Number(12)
# eval(Number(12), context={}) -> 12
#
# "'foo" -> ["quote", "foo"]
# ["quote", "foo"] -> Internal(quote, foo)
# eval(Internal(quote, foo), context={"quote": fn(thing) -> thing}) -> "foo"
#
# "foo" -> ["foo"]
# ["foo"] -> Symbol(foo)
# eval(Symbol(foo), context={}) -> ERROR (foo undefined)
# eval(Symbol(foo), context={"foo": 1}) -> 1
# eval(Symbol(foo), context={"foo": fn() -> 10}) -> fn
#
# 
#
# (this-gets-applied this-gets-resolved)
#
# (define this-gets-applied (lambda (x) (print x)))
# 1:
# (define this-gets-resolved 'foo)
# 2:
# (define this-gets-resolved (lambda () 1))
#
# eval 1: output on console: foo -- actual result of eval is nil
# eval 2: output on console: [fn @ memory address] -- actual result of eval is nil
#
# parse(string) = read_token(tokenise(string))

sub tokenize( $self, $string ) {
    return grep $_, split / +/, $string =~ s{([()])}{ $1 }gr;
}

sub parse_number ( $self, $maybe_number ) {

    # try parsing and return
    if ( $maybe_number =~ /\A[0-9]+/ ) {
        return [ number => $maybe_number ];
    }

    # or fail (throw exception, return null, etc.)
    return;
}

sub parse_symbol ( $self, $maybe_symbol ) {
    return [ symbol => $maybe_symbol ];
}

# in Lisp, a program is an expression
# 1 foo 10 bar
# parse( tokenize( $string ) )
sub parse_expression ( $self, @tokens ) {
    return unless @tokens;
    my @result;
    while (@tokens) {
        my $token = $tokens[0];
        my $thing;
        if ( $thing = $self->parse_number($token) ) {
            shift @tokens;
        }
        elsif ( $thing = $self->parse_symbol($token) ) {
            shift @tokens;
        }
        else { die }
        push @result, $thing;
    }
    return @result;
}

1;

__END__

# delete below

"1"
"a"
"1 2"

"(begin (define a 10) (define b 2))"

["begin", ["define", "a", "10"], ["define", "b", "2"]]

"(begin"

['(', 'begin']

string = "(begin (define a 10) (define b 2) (* a b))"

parse($string) -> ['(', 'function', 'a', '1', ...]

read_tokens(parse($string)) -> FUNC_CALL(function, parameters=...)

eval(FUNC_CALL, $env) -> actually runs the thing

sub eval ( $thing, $env ) {
  perl_runnable = lookup($env, $thing)

  eval($perl_runnable)
}

hash = {'+' => +, .. }

eval(read_tokens(parse($string)))

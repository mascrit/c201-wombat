Definitions.

INTEGER         = [0-9]+
ATOM            = :[a-z_]+
WHITESPACE      = [\s\t\n\r]
SIGN            = [\+\-]
NEGATIVESIGN    = [\-]
PARENTHESIS_O   = [\(]
PARENTHESIS_C   = [\)]

Rules.

{INTEGER}       : {token, {integer,     TokenLine, list_to_integer(TokenChars)}}.
{ATOM}          : {token, {atom,        TokenLine, to_atom(TokenChars)}}.
[a-z_]+:        : {token, {key,         TokenLine, list_to_atom(lists:sublist(TokenChars, 1, TokenLen - 1))}}.
\{              : {token, {'{',         TokenLine}}.
\}              : {token, {'}',         TokenLine}}.
\main           : {token, {'main',      TokenLine}}.
\int            : {token, {'int',       TokenLine}}.
{PARENTHESIS_O} : {token, {'(',         TokenLine}}.
{PARENTHESIS_C} : {token, {')',         TokenLine}}.

{WHITESPACE}+ : skip_token.

Erlang code.

to_atom([$:|Chars]) ->
    list_to_atom(Chars).

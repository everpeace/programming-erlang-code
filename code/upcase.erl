-module(upcase).
-export([start/0]).

start() ->
    case io:get_chars('', 8192) of
	eof ->
	    init:stop();
	Str ->
	    Str1 = up_case(Str),
	    io:put_chars(Str1),
	    start()
    end.

up_case([H|T]) when $a =< H, H =< $z ->
    [H-$a+$A|up_case(T)];
up_case([H|T]) ->
    [H|up_case(T)];
up_case([]) ->
    [].

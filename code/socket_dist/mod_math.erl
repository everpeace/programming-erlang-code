-module(mod_math).
-export([run/3]).

run(MM, ArgC, ArgS) ->
    io:format("mod_math:run starting~n"
	      "ArgC = ~p ArgS=~p~n",[ArgC, ArgS]),
    loop(MM).

loop(MM) ->
    receive
	{chan, MM, {factorial, N}} ->
	    MM ! {send, fac(N)}, 
	    loop(MM);
	{chan, MM, {fibonacci, N}} ->
	    MM ! {send, fib(N)},
	    loop(MM);
	{chan_closed, MM} ->
	    io:format("mod_math stopping~n"),
	    exit(normal)
    end.

fac(0) -> 1;
fac(N) -> N*fac(N-1).

fib(1) -> 1; 
fib(2) -> 1;
fib(N) -> fib(N-1) + fib(N-2).

    
    

-module(error1).
-export([start/0]).

start() -> loop(0).

loop(M) ->
    io:format("error1 M=~p~n",[M]),
    receive
	K ->
	    1/K,
	    loop(M+1)
    after 500 ->
	    loop(M+1)
    end.

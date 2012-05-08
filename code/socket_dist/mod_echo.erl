-module(mod_echo).

-export([start/3]).

start(MM, ArgC, ArgS) ->
    io:format("Echo starting arguments ArgC:~p ArgS:~p~n",
	      [ArgC, ArgS]),
    loop(MM).

loop(MM) ->
    receive
	{chan, MM, Any} ->
	    MM ! {send, Any}, 
	    loop(MM);
	{chan_closed, MM} ->
	    io:format("echo channel closed~n"),
	    exit(normal);
	Any ->
	    io:format("echo bad message:~p~n",[Any]),
	    loop(MM)
    end.

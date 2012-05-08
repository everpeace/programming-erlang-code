-module(monitor3).
-export([start/0]).


start() ->
    process_flag(trap_exit, true),
    Pid = spawn_link(fun() -> error1:start() end),
    loop(2, Pid).


loop(N, Pid) ->
    io:format("~p N=~p~n",[?MODULE, N]),
    Pid ! N,
    receive
	Any ->
	    io:format("~p received:~p~n",[?MODULE, Any]),
	    loop(N, Pid)
    after 1000 ->
	loop(N-1, Pid)
    end.
       
			 
			

-module(monitor1).
-export([start/1]).

start(Pid) ->
    spawn(fun() -> run(Pid) end).

run(Pid) ->
    link(Pid),
    loop(0).

loop(N) ->
    io:format("~p N=~p~n",[?MODULE, N]),
    receive
    after 2000 ->
	loop(N+1)
    end.
       
			 
			

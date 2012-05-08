-module(counter4).
-export([start/0]).

start() -> lib_misc:spawn_monitor(counter, true, fun() -> counter(0) end).

counter(N) -> 
    receive                 
	bump ->             
	    counter(N+1);
	display ->          
	    io:format("Count=~p~n", [N]),
	    counter(N);
	stop ->             
	    true
    end.

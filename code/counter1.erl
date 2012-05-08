-module(counter1).
-export([start/0, counter/1]).

start() -> 
    register(counter1,
	     spawn(fun() ->
			   io:format("Hello I'm a counter:~p~n",[self()]),
			   counter(0) 
		   end)).

counter(N) -> 
    receive    
	bump -> 
	    io:format("info=~p~n",[process_info(self())]),
	    counter(N+1);
	display ->       
	    io:format("Counter ~p count=~p~n", [self(), N]),
	    counter(N);
	die ->
	    io:format("I'm going to die:~p~n",[self()]),
	    1/0,
	    counter(N)
    end.


-module(counter2).
-export([start/0, read/1]).

start() -> spawn(fun() -> counter(0) end). %% (1)

read(Pid) ->                 %% (2)
    Pid ! {self(), read},   
    receive
	{Pid, N} ->         
	    N
    end.
    
counter(N) -> 
    receive      
	bump -> 
	    counter(N+1);
	{From, read} ->           %% (3)
	    From ! {self(), N},  
	    counter(N);
	stop ->            
	    true
    end.


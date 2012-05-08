-module(area_server2).  
-export([loop/0, rpc/2]). 


rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
	{Pid, Response} ->
	    Response
    end.


loop() ->
    receive
	{From, {rectangle, Width, Ht}} -> 
	    From ! {self(), Width * Ht},
	    loop();
	{From, {circle, R}} -> 
	    From !  {self(), 3.14159 * R * R},
	    loop();
	{From, Other} ->
	    From ! {self(), {error,Other}},
	    loop()
    end.




     


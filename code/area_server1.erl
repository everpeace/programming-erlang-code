-module(area_server1).  
-export([loop/0, rpc/2]). 


rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
	Response ->
	    Response
    end.


loop() ->
    receive
	{From, {rectangle, Width, Ht}} -> 
	    From ! Width * Ht,
	    loop();
	{From, {circle, R}} -> 
	    From !  3.14159 * R * R,
	    loop();
	{From, Other} ->
	    From ! {error,Other},
	    loop()
    end.




     


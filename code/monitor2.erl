-module(monitor2).
-export([start/0]).

start() ->
    spawn(fun() -> run() end).

run() ->
    process_flag(trap_exit, true),
    counter1:start(),
    link(whereis(counter1)),
    loop().

loop() ->
    receive
	{'EXIT', Pid, Why} ->
	    io:format("Monitor caught an exit from:~p Why=~p~n",
		      [Pid, Why]),
	    counter1:start(),
	    link(whereis(counter1)),
	    loop()
    end.

			 
			

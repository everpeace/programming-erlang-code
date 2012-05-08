-module(mod_chat_controller).
-export([start/3]).
-import(lib_chan_mm, [send/2]).

start(MM, _, _) ->
    process_flag(trap_exit, true),
    io:format("mod_chat_controller off we go ...~p~n",[MM]),
    loop(MM).

loop(MM) ->
     receive
	 {chan, MM, Msg} ->
	     chat_server ! {mm, MM, Msg},
	     loop(MM);
	 {'EXIT', MM, _Why} ->
	     chat_server ! {mm_closed, MM};
	 Other ->
	     io:format("mod_chat_controller unexpected message =~p (MM=~p)~n",
		       [Other, MM]),
	     loop(MM)
    end. 


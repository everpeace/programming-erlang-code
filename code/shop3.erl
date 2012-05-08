-module(shop3).
-export([total/1]).
 
total([{What, N}|T]) ->
    case (catch shop:cost(What)) of
	{'EXIT', _} ->
	    io:format("The shop does not sell ~p~n",[What]),
	    total(T);
	Cost ->
	    Cost * N + total(T)
    end;
total([]) ->
    0.


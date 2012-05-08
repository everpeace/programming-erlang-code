
-module(registrar).
-export([start/0, whereis/1, at/2]).

start() -> register(registrar, spawn(fun() -> loop([]) end)).

whereis(Thing)   -> call({locate, Thing}).
at(Thing, Where) -> cast({isAt, Thing, Where}).



call(Q) ->
    registrar ! {self(), Q},
    receive
	{registrar, Reply} ->
	    Reply
    end.

cast(X) -> registrar ! X.



loop(L) ->
    receive
	{isAt, Thing, Where} ->
	    L1 = add_location(Thing, Where, L),
	    loop(L1);
	{From, {locate, Thing}} ->
	    Reply = find_thing(Thing, L),
	    From ! {registrar, Reply},
	    loop(L)
    end.

	

add_location(Thing, At, [{Thing,_}|T]) -> [{Thing, At}|T];
add_location(Thing, At, [H|T])         -> [H|add_location(Thing, At, T)];
add_location(Thing, At, [])            -> [{Thing, At}].

find_thing(Thing, [{Thing, At}|_]) -> {found, At};
find_thing(Thing, [_|T])           -> find_thing(Thing, T);
find_thing(_Thing, [])             -> not_found.


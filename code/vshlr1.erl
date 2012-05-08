-module(vshlr1).

-export([start/0, stop/0, handle_event/2, 
	 i_am_at/2, find/1]).

-import(server1, [start/3, stop/1, rpc/2]).
-import(dict,    [new/0, store/3, find/2]).

start() -> start(vshlr, fun handle_event/2, new()).

stop() -> stop(vshlr).

i_am_at(Who, Where) -> 
    rpc(vshlr, {i_am_at, Who, Where}).

find(Who) -> 
    rpc(vshlr, {find, Who}).

handle_event({i_am_at, Who, Where}, Dict) ->
    {ok, store(Who, Where, Dict)};
handle_event({find, Who}, Dict) ->
    {find(Who, Dict), Dict}.


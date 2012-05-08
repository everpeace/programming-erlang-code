-module(lists1).
-compile(export_all).

%% Warning this module should be compiled for 
%% to check the systenmax of the modules only
%% No beam code should be created

map(_, [])     -> [];
map(F,  [H|T]) -> [F(H)|map(F, T)].



member(H, [H|_]) -> true;
member(H, [_|T]) -> member(H, T);
member(_, [])    -> false.

    

partition(Pred, L) -> partition(Pred, L, [], []).

partition(Pred, [H|T], Ts, Fs) ->
    case Pred(H) of
	true  -> partition(Pred, T, [H|Ts], Fs);
	false -> partition(Pred, T, Ts, [H|Fs])
    end;
partition(_, [], Ts, Fs) ->
    {reverse(Ts), reverse(Fs)}.
%END:partition


reverse(L) -> reverse(L, []).

reverse([H|T], L) -> reverse(T, [H|L]);
reverse([], L)    -> L.



search(Key, [{Key,Val}|_]) -> {ok, Val};        %% (1)
search(Key, [_|T])         -> search(Key, T);    %% (2)
search(_, [])              -> error.             %% (3)

    

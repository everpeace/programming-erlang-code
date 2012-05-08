-module(update_binary_file).
-export([update/3]).

update(File, Key, Delta) ->
    {ok, Bin} = file:read_file(File),
    Terms = binary_to_term(Bin),
    Terms1 = do_update(Key, Delta, Terms),
    file:write_file(File, [term_to_binary(Terms1)]).

do_update(Key, Delta, [{Key,Val}|T]) ->
    [{Key,Val+Delta}|T];
do_update(Key, Delta, [H|T]) ->
    [H|do_update(Key, Delta, T)];
do_update(Key, Delta, []) ->
    [{Key, Delta}].

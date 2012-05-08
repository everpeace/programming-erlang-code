-module(update_file).
-export([update/3]).
-import(lib_misc, [unconsult/2]).

update(File, Key, Delta) ->
    {ok, Terms} = file:consult(File),
    Terms1 = do_update(Key, Delta, Terms),
    unconsult(File ++ ".tmp", Terms1). %% <label id="code.update.file.1"/>

do_update(Key, Delta, [{Key,Val}|T]) ->
    [{Key,Val+Delta}|T];
do_update(Key, Delta, [H|T]) ->
    [H|do_update(Key, Delta, T)];
do_update(Key, Delta, []) ->
    [{Key, Delta}].

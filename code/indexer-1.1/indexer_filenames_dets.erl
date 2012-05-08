
-module(indexer_filenames_dets).
-export([open/1, close/0, test/0, filename2index/1, index2filename/1]).

open(File) ->
    io:format("dets opened:~p~n", [File]),
    Bool = filelib:is_file(File),
    case dets:open_file(?MODULE, [{file, File}]) of
	{ok, ?MODULE} ->
	    case Bool of
		true  -> void;
		false -> ok = dets:insert(?MODULE, {free,1})
	    end,
	    true;
	{error,_Reason} ->
	    io:format("cannot open dets table~n"),
	    exit(eDetsOpen)
    end.

close() -> dets:close(?MODULE).



filename2index(FileName) when is_binary(FileName) ->
    case dets:lookup(?MODULE, FileName) of
	[] ->
	    [{_,Free}] = dets:lookup(?MODULE, free),
	    ok = dets:insert(?MODULE,
		             [{Free,FileName},{FileName,Free},{free,Free+1}]),
	    Free;
	[{_,N}] ->
	    N
    end.



index2filename(Index) when is_integer(Index) ->
    case dets:lookup(?MODULE, Index) of
	[]        -> error;
	[{_,Bin}] -> Bin
    end.



test() ->
    file:delete("./filenames.dets"),
    open("./filenames.dets"),
    F = lib_files_find:files(".", "*.erl", true),
    lists:foreach(fun(I) -> filename2index(list_to_binary(I)) end, F).


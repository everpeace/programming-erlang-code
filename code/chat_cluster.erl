-module(chat_cluster).

-export([start/1, remote/2]).

start(Node) ->
    spawn(fun() -> chatter(Node) end).

chatter(Node) ->
    S = self(),
    Local  = io_widget:start(S),
    io_widget:set_title(Local, "chat to " ++ atom_to_list(Node)),
    Remote = rpc:call(Node, chat, remote, [node(), Local]),
    loop(Local, Remote).

remote(RemoteNode, Remote) ->
    S = self(),
    spawn(fun() -> remote1(S, RemoteNode, Remote) end),
    receive
	Pid -> Pid
    end.

remote1(Parent, RemoteNode, Remote) ->
    Local =  io_widget:start(self()),
    io_widget:set_title(Local, "chat to " ++ atom_to_list(RemoteNode)),
    Parent ! Local,
    loop(Local, Remote).
	    

loop(A, B) ->
    receive
	{_, {data, Str}} ->
	    io_widget:insert(A, [$\n|Str]),
	    io_widget:insert(B, [$\n|Str]),
	    loop(A, B);
	Any ->
	    io:format("~p~n", [Any]),
	    loop(A, B)
    end.


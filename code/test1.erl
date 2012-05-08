-module(test1).
-export([foo/1]).

zip(X) ->
    % this is zip
    Y = "abc",
    case X of
	1 ->
	    2
    end.


foo(X) ->

    bar(X).



bar(X) ->
    42.
 

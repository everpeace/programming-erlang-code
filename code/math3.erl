-module(math3).         
-export([area/1]).
-import(math, [pi/0]).

area({circle, Radius}) -> 
    pi() * squared(Radius);
area({triangle, A, B, C}) ->
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C)).

squared(X) -> X*X.

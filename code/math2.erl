-module(math2).   
-export([map/2]). 

map(_, [])    -> [];  %% (1)
map(F, [H|T]) -> [F(H)|map(F, T)]. %% (2)

    


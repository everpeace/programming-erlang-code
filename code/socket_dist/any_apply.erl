-module(any_apply).

-export([mfa/3]).

mfa(Mod, Func, Args) ->
    apply(Mod, Func, Args).

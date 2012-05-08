-module(convert2).

-export([convert/2]).

convert(Yards, meters) -> 0.9144 * Yards;
convert(Meters, yards) -> 1.0936133 * Meters.

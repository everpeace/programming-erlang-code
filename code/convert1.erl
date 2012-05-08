-module(convert1). %% (1)
-export([yards_to_meters/1, meters_to_yards/1]). %% (2)

yards_to_meters(Yards) ->   %% (3)
    0.9144 * Yards.

meters_to_yards(Meters) ->
    1.0936133 * Meters.

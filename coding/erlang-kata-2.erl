%%% I think this is broken. I should fix this.

%%% Kata 2

-module(kata2.binary).
-export([chop/2]).
-import(io).
-import(lists).

chop(_, [], _) ->
  -1;

chop(Needle, Haystack, Pointer) ->
  io:format("chop(~w, ~w, ~w)~n", [Needle, Haystack, Pointer]),
  Middle = lists:nth(ceiling(length(Haystack) / 2), Haystack),
  if
    Needle =:= Middle ->
      io:format("~w = ~w -> Pointer(~w)~n", [Needle, Middle, Pointer]),
      Pointer;
    Needle > Middle ->
      io:format("~w > ~w -> Higher(~w + ~w)~n", [Needle, Middle, Pointer, (length(Haystack) / 2)]),
      { _, Higher } = lists:split(floor(length(Haystack) / 2) + 1, Haystack),
      chop(Needle, Higher, (Pointer + floor(length(Haystack) / 2)) - 1);
    Needle < Middle ->
      io:format("~w < ~w -> Lower(~w - ~w)~n", [Needle, Middle, Pointer, (length(Haystack) / 2)]),
      { Lower, _ } = lists:split(ceiling(length(Haystack) / 2), Haystack),
      chop(Needle, Lower, (Pointer - ceiling(length(Haystack) / 2)))
  end.

chop(Needle, Haystack) ->
  chop(Needle, Haystack, ceiling(length(Haystack) / 2)).


floor(X) ->
  T = erlang:trunc(X),
  case (X - T) of
    Neg when Neg < 0 -> T - 1;
    Pos when Pos > 0 -> T;
    _ -> T
  end.

ceiling(X) ->
  T = erlang:trunc(X),
  case (X - T) of
    Neg when Neg < 0 -> T;
    Pos when Pos > 0 -> T + 1;
    _ -> T
  end.

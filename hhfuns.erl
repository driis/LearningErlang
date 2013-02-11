-module(hhfuns).
-export([map/2, incr/1, decr/1]).

map(_, []) -> 
	[];
map(Selector, [Head|Tail]) -> 
	[Selector(Head)|map(Selector,Tail)].

incr(X) -> X + 1.
decr(X) -> X - 1.
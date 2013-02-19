-module(road).
-export([shortest/0]).

shortest() -> 
	Data = read("road.txt"),
	shortest(h,Data, [], 0).

shortest(b, [{{a,A, b, B, x, X}},T], Acc, Length) -> 
	if A + X < B ->
		shortest(a, T, [a|Acc], Length + A + X); 
	   true ->
		shortest(b, T, [b|Acc], Length + B)
	end;
shortest(a, [{{a,A, b, B, x, X}},T], Acc, Length) -> 
	if B + X < A ->
		shortest(b, T, [b|Acc], Length + B + X);
	   true ->
		shortest(a, T, [a|Acc], Length + A)
	end;
shortest(_, [{{a,A, b, B, x, _}}|T], Acc, Length) -> 
	if A < B ->
		shortest(a, T, [a|Acc], Length + A);
	   true -> 
		shortest(b, T, [b|acc], Length + A)
	end;
shortest(_, [], Acc, Length) -> 
 	{Length, Acc}.

read(Name) -> 
	{_,Data} = file:read_file(Name),	
	StringData = binary_to_list(Data),
	lists:reverse(tokenize(string:tokens(StringData, "\r\n"))).

tokenize(List) -> tokenize(List, []).
tokenize([], Acc) -> Acc;
tokenize([A,B,X|T], Acc) ->
	tokenize(T, [{{a,A}, {b, B}, {x, X}}|Acc]).
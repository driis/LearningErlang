-module(road).
-export([shortest/0]).

shortest() -> 
	Data = read("road.txt"),
	shortest(h,Data, [], 0).

shortest(b, [{{a, A}, {b, B}, {x, X}} | T], Acc, Length) -> 
	if A + X < B ->
		shortest(a, T, [a|Acc], Length + A + X); 
	   true ->
		shortest(b, T, [b|Acc], Length + B)
	end;
shortest(a, [{{a, A}, {b, B}, {x, X}} | T], Acc, Length) -> 
	if B + X < A ->
		shortest(b, T, [b|Acc], Length + B + X);
	   true ->
		shortest(a, T, [a|Acc], Length + A)
	end;
shortest(_, [{{a, A}, {b, B}, {x, _}} | T], Acc, Length) -> 
	if A < B ->
		shortest(a, T, [a|Acc], Length + A);
	   true -> 
		shortest(b, T, [b|Acc], Length + A)
	end;
shortest(_, [], Acc, Length) -> 
 	{Length, Acc}.

read(Name) -> 
	{_,Data} = file:read_file(Name),	
	StringData = binary_to_list(Data),
	lists:reverse(tokenize(string:tokens(StringData, "\r\n"))).

to_number(N) -> 
	case string:to_float(N) of
		{error, no_float} -> list_to_integer(N);
		{F,_} -> F
	end.

tokenize(List) -> tokenize(List, []).
tokenize([], Acc) -> Acc;
tokenize([A,B,X|T], Acc) ->
	tokenize(T, [{{a,to_number(A)}, {b, to_number(B)}, {x, to_number(X)}} | Acc]).

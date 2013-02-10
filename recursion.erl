-module(recursion).
-export([
	fac/1,
	len/1,
	tail_fac/1,
	duplicate/2,
	reverse/1,
	sublist/2,
	zip/2,
	quicksort/1
]).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

len(List) -> len(List,0).
%% 'private':
len([],Acc) -> Acc;
len([_|T],Acc) -> len(T, Acc + 1).


tail_fac(N) -> tail_fac(N,1).
%% 'private':
tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1,N*Acc).

duplicate(Term,Count) when Count > 0 -> 
	duplicate(Term,Count, []).
duplicate(_,0, Acc) -> Acc;
duplicate(Term, Count, Acc) -> 
	duplicate(Term, Count - 1, [Term|Acc]).

reverse(N) -> reverse(N,[]).
reverse([],Acc) -> Acc;
reverse([H|T],Acc) -> reverse(T, [H|Acc]).

sublist(List,Length) when Length >= 0 -> 
	sublist(List,Length,[]).
sublist(_,0,Acc) -> Acc;
sublist([],_,Acc) -> Acc;
sublist([H|T],Length,Acc) -> 
	sublist(T,Length - 1, Acc ++ [H]).

zip(First,Second) -> reverse(zip(First,Second,[])).
zip([],_, Acc) -> Acc;
zip(_,[], Acc) -> Acc;
zip([Hf|Tf],[Hs|Ts],Acc) ->
	zip(Tf,Ts,[{Hf,Hs}|Acc]).

quicksort([]) -> [];
quicksort([Pivot|Rest]) -> 
	{Smaller,Larger} = quicksort_partition(Pivot,Rest, [],[]),
	quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).
quicksort_partition(_,[], Smaller, Larger) ->
	{Smaller,Larger};
quicksort_partition(Pivot,[Hlist|Tlist], Smaller,Larger) -> 
	if Hlist < Pivot -> 
		quicksort_partition(Pivot, Tlist, [Hlist|Smaller], Larger);
       Hlist >= Pivot -> 
	    quicksort_partition(Pivot,Tlist, Smaller, [Hlist|Larger])
	end.		

-module(recursion).
-export([fac/1,len/1,tail_fac/1,duplicate/2]).

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

duplicate(Term,Count) when Count > 0 -> duplicate(Term,Count, []).
duplicate(Term,0, Acc) -> Acc;
duplicate(Term, Count, Acc) -> duplicate(Term, Count - 1, [Term|Acc]).
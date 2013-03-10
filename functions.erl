-module(functions).
-compile(export_all). %% replace with export()

head([H|_]) -> H.

second([_,H|_]) -> H.

same(X,X) -> 
	true;
same(_,_) -> 
	false.

right_age(X) when X >= 16, X =< 104 -> 
	true;
right_age(_) -> 
	false.

oh_god(N) -> 
	if N =:= 2 -> might_succeed;
		true -> or_not
	end.

help_me(Animal) -> 
	Talk = 	if Animal == cat -> "meow";
			  Animal == dog -> "bark";
			  Animal == beef -> "mooh";
			  true -> "rfsd"
			end,		 
	{Animal, "says " ++ Talk ++ "!"}.

insert(X,[]) -> 
	[X];
insert(X,Set) -> 
	case lists:member(X,Set) of
		true  -> Set;
		false -> [X|Set]
	end.

fand(true,true) -> true;
fand(_,_) -> false.

for (true,false) -> true;
for (false,true) -> true;
for (_,_) -> false.

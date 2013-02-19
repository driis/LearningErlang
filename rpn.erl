-module(rpn).
-export([eval/1, rpn_test/0]).

eval(X) -> 
	Tokens = string:tokens(X, " "),
	[Result] = lists:foldl(fun processToken/2, [], Tokens),
	Result.

processToken("+", [L,R|Stack]) ->  [R + L | Stack];
processToken("-", [L,R|Stack]) ->  [R - L | Stack];
processToken("*", [L,R|Stack]) ->  [R * L | Stack];
processToken("/", [L,R|Stack]) ->  [R / L | Stack];	
processToken("log10", [N|Stack]) ->  [math:log10(N) | Stack];	
processToken("ln", [N|Stack]) ->  [math:log(N) | Stack];	
processToken("^", [Pow,N|Stack]) ->  [math:pow(N,Pow) | Stack];	
processToken("sum", Stack) ->  [sum(Stack,0)];	
processToken("prod", Stack) ->  [prod(Stack,1)];	
processToken(X, Stack) -> [read(X) | Stack].

sum([H|T], S) -> sum(T, S + H);
sum([], S) -> S.

prod([H|T], S) -> prod(T, H * S);
prod([], S) -> S.

read(N) -> 
	case string:to_float(N) of
		{error, no_float} -> list_to_integer(N);
		{F,_} -> F
	end.

rpn_test() ->
	5 = eval("2 3 +"),
	87 = eval("90 3 -"),
	-4 = eval("10 4 3 + 2 * -"),
	-2.0 = eval("10 4 3 + 2 * - 2 /"),
	ok = try
		eval("90 34 12 33 55 66 + * - +")
	catch
		error:{badmatch,[_|_]} -> ok
	end,
	4037 = eval("90 34 12 33 55 66 + * - + -"),
	8.0 = eval("2 3 ^"),
	true = math:sqrt(2) == eval("2 0.5 ^"),
	true = math:log(2.7) == eval("2.7 ln"),
	true = math:log10(2.7) == eval("2.7 log10"),
	50 = eval("10 10 10 20 sum"),
	10.0 = eval("10 10 10 20 sum 5 /"),
	1000.0 = eval("10 10 20 0.5 prod"),
	ok.
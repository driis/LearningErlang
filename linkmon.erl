-module(linkmon).
-compile([export_all]).

myproc() -> 
	timer:sleep(5000),
	exit(reason).

chain(0) ->
	receive _ -> ok
	after 2000 ->
		exit("chain dies")
	end;
chain(N) ->
	Pid = spawn(fun() -> chain(N-1) end),
	link(Pid),
	receive
		_ -> ok
	end.

start_critic() -> 
	spawn(?MODULE, critic, []).

start_critic_supervisor() -> 
	spawn(?MODULE, restarter, []).

restarter() -> 
	process_flag(trap_exit, true),
	Pid = spawn_link(?MODULE, critic, []),
	register(critic, Pid),
	receive 
		{ 'EXIT', Pid, normal } -> ok;
		{ 'EXIT', Pid, shutdown } -> ok;
		{ 'EXIT', Pid, _} -> 
			restarter()
	end.


judge(Band, Album) -> 
	Ref = make_ref(),
	critic ! { self(), Ref, { Band, Album }},	
	receive {Ref, Criticism} -> 
		Criticism
	after 2000 ->
		timeout
	end.

critic() ->
	receive
		{From, Ref, {"Rage Against the Turing Machine", "Unit Testify"}} ->
			From ! {Ref, "They are great!"};
		{From, Ref, {"System of a Downtime", "Memoize"}} ->
			From ! {Ref, "They're not Johnny Crash but they're good."};
		{From, Ref, {"Johnny Crash", "The Token Ring of Fire"}} ->
			From ! {Ref, "Simply incredible."};
		{From, Ref, {_Band, _Album}} ->
			From ! {Ref, "They are terrible!"}
	end,
	critic().
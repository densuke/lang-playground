#!/usr/bin/env escript
%% 軽量プロセスとメッセージの送受信
main(_) ->
    Parent = self(),
    Pids = [spawn(fun() ->
                      receive {square, From} -> From ! {result, self(), N * N} end
                  end) || N <- lists:seq(1, 3)],
    [P ! {square, Parent} || P <- Pids],
    [receive {result, _Pid, V} -> io:format("受信: ~p~n", [V]) end || _ <- Pids],

    %% 10 万個のプロセスを作って、全部から返事をもらう
    Count = 100000,
    T0 = erlang:monotonic_time(millisecond),
    [spawn(fun() -> Parent ! {done, I} end) || I <- lists:seq(1, Count)],
    Sum = lists:sum([receive {done, I} -> I end || _ <- lists:seq(1, Count)]),
    Ms = erlang:monotonic_time(millisecond) - T0,
    io:format("~p プロセスの合計: ~p (~p ms)~n", [Count, Sum, Ms]),

    %% 1 プロセスあたりのメモリ (words)
    P1 = spawn(fun() -> receive stop -> ok end end),
    {memory, Bytes} = process_info(P1, memory),
    io:format("1 プロセスのメモリ: ~p bytes~n", [Bytes]),
    P1 ! stop.

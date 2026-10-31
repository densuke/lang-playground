#!/usr/bin/env escript
%% let it crash: 働くプロセスは壊れたら死ぬ。直すのは別のプロセス (スーパーバイザ)
-mode(compile).
-behaviour(supervisor).
-export([init/1, worker/0]).

%% worker: 受け取った数で 100 を割る。0 が来たら ArithmeticError で落ちる
worker() ->
    Pid = spawn_link(fun loop/0),
    register(divider, Pid),
    {ok, Pid}.

loop() ->
    receive
        {From, N} ->
            From ! {self(), 100 div N},
            loop()
    end.

init([]) ->
    Child = #{id => divider, start => {?MODULE, worker, []}, restart => permanent},
    {ok, {#{strategy => one_for_one, intensity => 5, period => 10}, [Child]}}.

ask(N) ->
    divider ! {self(), N},
    receive {Pid, R} -> io:format("100 div ~p = ~p (pid ~p)~n", [N, R, Pid])
    after 500 -> io:format("100 div ~p = 返事なし~n", [N])
    end.

main(_) ->
    logger:set_primary_config(level, none),   % クラッシュの詳細ログは出さない
    {ok, _} = supervisor:start_link({local, sup}, ?MODULE, []),
    ask(5),
    Old = whereis(divider),
    io:format("0 を送る → worker が落ちる~n"),
    ask(0),
    timer:sleep(100),
    New = whereis(divider),
    io:format("同じ pid か: ~p (旧 ~p / 新 ~p)~n", [Old =:= New, Old, New]),
    ask(4),
    io:format("スーパーバイザの子: ~p~n",
              [[{Id, is_pid(P)} || {Id, P, _, _} <- supervisor:which_children(sup)]]).

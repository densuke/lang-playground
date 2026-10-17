%% 仕事袋 (bag of tasks)。親は {task, N} を袋に入れるだけ。
%% ワーカーは誰が何番を取るか知らない。取れたものを計算して {result, N, ...} を返す。
-module(taskbag).
-export([run/0]).

-define(TASKS, 8).
-define(WORKERS, 3).

worker(Id) ->
    case espace:inp({task, '$1'}) of
        nomatch -> ok;
        {[N], _} ->
            timer:sleep(200),                       % 仕事に時間がかかるふり
            espace:out({result, N, N * N, Id}),
            worker(Id)
    end.

run() ->
    logger:set_primary_config(level, warning),
    espace:start(),
    [espace:out({task, N}) || N <- lists:seq(1, ?TASKS)],
    io:format("親: task を ~p 個、袋に入れた~n", [?TASKS]),
    [espace:worker({fun() -> worker(Id) end}) || Id <- lists:seq(1, ?WORKERS)],
    io:format("親: ワーカーを ~p 人起こした。結果を in で待つ~n", [?WORKERS]),
    Results = [begin {[Sq, W], _} = espace:in({result, N, '$1', '$2'}), {N, Sq, W} end
               || N <- lists:seq(1, ?TASKS)],
    [io:format("  task ~p -> ~p  (worker ~p)~n", [N, Sq, W]) || {N, Sq, W} <- Results],
    Per = [{W, length([x || {_, _, X} <- Results, X =:= W])} || W <- lists:seq(1, ?WORKERS)],
    io:format("親: 全部そろった。ワーカーごとの処理数 ~p~n", [Per]),
    ok.

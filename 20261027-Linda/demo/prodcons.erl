%% 消費者を先に起こす。in は、合うタプルが現れるまで止まって待つ。
-module(prodcons).
-export([run/0]).

now_ms() -> erlang:monotonic_time(millisecond).

run() ->
    logger:set_primary_config(level, warning),
    espace:start(),
    T0 = now_ms(),
    Log = fun(Fmt, Args) -> io:format("[~4w ms] " ++ Fmt ++ "~n", [now_ms() - T0 | Args]) end,
    Parent = self(),

    espace:worker({fun() ->
        Log("消費者: in({item, N}) を呼ぶ (まだ何も無い)", []),
        {[N], _} = espace:in({item, '$1'}),
        Log("消費者: in が返った。受け取った item = ~p", [N]),
        Parent ! consumer_done
    end}),

    timer:sleep(4000),
    Log("生産者: 4 秒待った。out({item, 42})", []),
    espace:out({item, 42}),

    receive consumer_done -> ok after 5000 -> io:format("タイムアウト~n") end,
    ok.

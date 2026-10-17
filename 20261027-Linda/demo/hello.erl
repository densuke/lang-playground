%% Linda の 4 操作を 1 つずつ見せる。espace:out = out、in = in、rd = rd、eval = eval。
-module(hello).
-export([run/0]).

run() ->
    logger:set_primary_config(level, warning),
    espace:start(),
    espace:out({greeting, "Hello, Linda"}),
    io:format("out   : {greeting, \"Hello, Linda\"} を置いた~n"),

    {[Msg], _} = espace:rd({greeting, '$1'}),
    io:format("rd    : ~p を読んだ (タプルは残る)~n", [Msg]),

    {[Msg2], _} = espace:rd({greeting, '$1'}),
    io:format("rd    : もう一度 ~p (残っているので読める)~n", [Msg2]),

    {[Msg3], _} = espace:in({greeting, '$1'}),
    io:format("in    : ~p を取り出した (タプルは消える)~n", [Msg3]),

    io:format("rdp   : ~p (もう無い。止まらず nomatch が返る)~n", [espace:rdp({greeting, '$1'})]),

    espace:eval({square, {fun(N) -> N * N end, [7]}}),
    {[Sq], _} = espace:in({square, '$1'}),
    io:format("eval  : {square, 7*7} を別プロセスで計算 -> in で ~p を受け取った~n", [Sq]),
    ok.

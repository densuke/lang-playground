#!/usr/bin/env escript
%% パターンマッチ: = は代入ではなく「左右が合うか」の照合
main(_) ->
    {ok, Value} = {ok, 42},
    io:format("Value = ~p~n", [Value]),

    %% 関数の頭で場合分け
    Fib = fun F(0) -> 0;
              F(1) -> 1;
              F(N) when N > 1 -> F(N - 1) + F(N - 2)
          end,
    io:format("~p~n", [[Fib(N) || N <- lists:seq(0, 9)]]),

    %% 文字列 (整数のリスト) の先頭を取り出す
    "erlang" ++ Rest = "erlang/otp",
    io:format("Rest = ~p~n", [Rest]),

    %% ビット列のパターンマッチ (Erlang の得意分野: プロトコルの解析)
    <<Version:4, IHL:4, _/binary>> = <<69, 0, 0, 20>>,
    io:format("IPv4 version=~p header words=~p~n", [Version, IHL]),

    %% 合わなければ badmatch で落ちる
    try {ok, _} = {error, enoent}
    catch error:Reason -> io:format("合わない: ~p~n", [Reason])
    end.

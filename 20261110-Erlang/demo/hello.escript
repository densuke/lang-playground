#!/usr/bin/env escript
%% Hello World と環境の確認
main(_) ->
    io:format("Hello, world!~n"),
    io:format("OTP ~s / erts ~s~n",
              [erlang:system_info(otp_release), erlang:system_info(version)]).

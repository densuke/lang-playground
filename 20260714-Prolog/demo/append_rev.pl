% append/3 の双方向性。「連結する」だけでなく「分割する」「補う」にも使える。

:- initialization(main).

main :-
    % 普通の使い方: 連結した結果を求める
    append([1, 2], [3, 4], Whole),
    format("連結: ~w~n", [Whole]),

    % 逆向き: 結果から分割のしかたを全部求める
    findall(X-Y, append(X, Y, [a, b, c]), Splits),
    format("分割: ~w~n", [Splits]),

    % 部分だけ分かっているとき: 足りない側を埋める
    append([1, 2], Rest, [1, 2, 3, 4]),
    format("補完: ~w~n", [Rest]).

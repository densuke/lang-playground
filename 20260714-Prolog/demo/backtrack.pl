% バックトラッキングで全解を列挙する。SEND+MORE=MONEY のごく小さい版として、
% 2桁の数当てパズルを総当たりで解く。

digit(0). digit(1). digit(2). digit(3). digit(4).
digit(5). digit(6). digit(7). digit(8). digit(9).

% X + Y = 10 かつ X < Y を満たす組をすべて求める
pair(X, Y) :- digit(X), digit(Y), X < Y, X + Y =:= 10.

:- initialization(main).

main :-
    findall(X-Y, pair(X, Y), Pairs),
    format("X<Y かつ X+Y=10 の組: ~w~n", [Pairs]).

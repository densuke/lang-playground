% 事実 (facts) と規則 (rules) による家系図。
% Prolog では「何が答えか」ではなく「何が成り立つか」だけを書く。

parent(tanaka, satou).
parent(tanaka, suzuki).
parent(satou, yamada).
parent(suzuki, ito).

grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
sibling(X, Y) :- parent(P, X), parent(P, Y), X \== Y.

:- initialization(main).

main :-
    findall(G, grandparent(tanaka, G), Gs),
    format("tanaka の孫: ~w~n", [Gs]),
    findall(S, sibling(satou, S), Ss),
    format("satou のきょうだい: ~w~n", [Ss]).

% 同じ append が 2 つの向きで使える。向き (mode) ごとに「答えが何通りか」
% (determinism) を宣言し、コンパイラがそれを証明する。
:- module modes.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int, list, pair, solutions, string.

:- pred app(list(int), list(int), list(int)).
:- mode app(in, in, out) is det.     % 連結するだけ。答えはちょうど 1 つ
:- mode app(out, out, in) is multi.  % 分割する。答えは 1 つ以上 (必ずある)
app([], Ys, Ys).
app([X | Xs], Ys, [X | Zs]) :- app(Xs, Ys, Zs).

% semidet: 答えが 0 個か 1 個。失敗しうる
:- pred first_even(list(int)::in, int::out) is semidet.
first_even([X | Xs], E) :- ( if X mod 2 = 0 then E = X else first_even(Xs, E) ).

main(!IO) :-
    app([1, 2], [3, 4], Joined),
    io.print_line(Joined, !IO),

    solutions((pred(P::out) is nondet :- app(A, B, [1, 2, 3]), P = A - B), Splits),
    io.write_string("[1,2,3] の分割:\n", !IO),
    list.foldl(print_split, Splits, !IO),

    ( if first_even([1, 3, 6, 8], E1) then
        io.format("最初の偶数: %d\n", [i(E1)], !IO)
    else
        io.write_string("偶数なし\n", !IO)
    ),
    ( if first_even([1, 3, 5], E2) then
        io.format("最初の偶数: %d\n", [i(E2)], !IO)
    else
        io.write_string("[1,3,5] には偶数なし (失敗は if-then-else で受ける)\n", !IO)
    ).

:- pred print_split(pair(list(int), list(int))::in, io::di, io::uo) is det.
print_split(A - B, !IO) :- io.print_line(A - B, !IO).

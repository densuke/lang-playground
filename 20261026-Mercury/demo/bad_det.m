% 決定性エラー: det と宣言したのに、失敗しうる (偶数でなければ失敗する)
:- module bad_det.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.

:- pred half(int::in, int::out) is det.
half(X, Y) :- X mod 2 = 0, Y = X / 2.

main(!IO) :-
    half(3, Y),
    io.print_line(Y, !IO).

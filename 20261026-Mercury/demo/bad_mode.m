% モードエラー: in と宣言した引数に、値が決まっていない変数を渡している
:- module bad_mode.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.

:- pred double(int::in, int::out) is det.
double(X, Y) :- Y = X * 2.

main(!IO) :-
    double(N, 10),
    io.print_line(N, !IO).

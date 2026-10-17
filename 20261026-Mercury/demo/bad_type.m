% 型エラー: int を期待する所に文字列を渡している
:- module bad_type.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.

main(!IO) :-
    X = 1 + "two",
    io.print_line(X, !IO).

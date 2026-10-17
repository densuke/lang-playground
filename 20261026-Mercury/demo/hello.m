% Hello World。io.write_string は状態 (IO) を引数で受け渡す。
:- module hello.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.

main(!IO) :-
    io.write_string("Hello, world!\n", !IO).

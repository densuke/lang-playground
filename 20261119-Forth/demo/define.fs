\ : と ; で新しいワードを作る。新しいワードは組み込みと区別がない。
: square ( n -- n*n )  dup * ;
: cube   ( n -- n^3 )  dup square * ;
5 square . cr
3 cube . cr

\ 定義したワードを使って、さらに定義する。
: fact ( n -- n! )  1 swap 1+ 1 ?do i * loop ;
10 fact . cr
20 fact . cr

\ ワードは辞書に積まれる。同じ名前を作り直すと、以後はそちらが使われる。
: greet ." こんにちは" ;
: greet greet ."  、Forth です" ;
greet cr

\ 定義の中身は see で見られる。
see cube cr

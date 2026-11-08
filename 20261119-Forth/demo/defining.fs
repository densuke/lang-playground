\ create ... does> は「ワードを作るワード」を作る仕組み。
\ 定数を作るワードを自分で定義する。
: constant2  ( x "name" -- )  create , does> @ ;
42 constant2 answer
answer . cr

\ 配列を作るワード。作られたワードは、添字を取ってアドレスを返す。
: array  ( n "name" -- )  create cells allot does> swap cells + ;
5 array squares
: fill-squares  5 0 do i i * i squares ! loop ;
fill-squares
: show-squares  5 0 do i squares @ . loop cr ;
show-squares

\ 単位をワードにして、式をそのまま書けるようにする。辞書にワードを足すだけ。
: m   ;
: cm  100 / ;
: km  1000 * ;
3 km 250 m + . .( m) cr
5000 cm . .( m) cr

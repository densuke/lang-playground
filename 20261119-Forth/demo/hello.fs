\ スタックと逆ポーランド記法 (Gforth)
.( Hello, Forth!) cr
.( Gforth ) version-string type cr

\ 引数は先に積み、ワードが取って結果を積む。(3 + 4) * 2 は括弧がいらない。
3 4 + 2 * . cr

\ .s はスタックの中身を見る。
1 2 3 .s cr
swap .s cr      \ 先頭の 2 つを入れ替え
over .s cr      \ 2 番目を複製して積む
rot .s cr       \ 3 つ目を先頭へ回す
drop drop drop drop

\ 華氏 100 度を摂氏に直す。式はスタックの上で組み立てる。
100 32 - 5 * 9 / . cr

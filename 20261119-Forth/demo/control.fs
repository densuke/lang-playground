\ 制御構造は言語の組み込みではなく、普通のワード。自分で作れる。
\ immediate は、コンパイル中に即実行するワードの印。

\ unless: if の逆。0 以外のとき飛ばす。
: unless  postpone 0= postpone if ; immediate
: ok?  ( n -- )  unless ." ゼロでした" cr else ." ゼロではない" cr then ;
0 ok?
7 ok?

\ times: 回数を取って繰り返す、新しいループ構文。
: times  postpone 0 postpone ?do ; immediate
: end    postpone loop ; immediate
: stars  ( n -- )  times [char] * emit end cr ;
5 stars
12 stars

\ 条件が True の間繰り返す while も、既存のワードの組み合わせで足せる。
: countdown  ( n -- )
    begin dup 0> while dup . 1- repeat drop cr ;
5 countdown

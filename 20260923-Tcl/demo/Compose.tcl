# Tcl では「すべてが文字列」で、コマンド名も例外ではない。
# 文字列として組み立てた名前をそのままコマンドとして呼び出せる。
set cmd pu
append cmd ts
$cmd "コマンド名も文字列として組み立てられる"

# [コマンド置換] は文字列の中に埋め込める。ここでは式の結果を
# そのままコマンド名の一部として使う。
proc greet {lang} { return "puts" }
set say [greet ja]
$say "greet が返した文字列 puts を、そのままコマンドとして実行した"

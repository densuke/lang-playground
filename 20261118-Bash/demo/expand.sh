#!/usr/local/bin/bash
# パラメータ展開と波括弧展開
f=/home/user/archive.tar.gz
echo "拡張子を除く:   ${f%.gz}"
echo "最長で除く:     ${f%%.*}"
echo "ディレクトリ:   ${f%/*}"
echo "ファイル名:     ${f##*/}"
echo "置換:           ${f/user/alice}"
echo "大文字:         ${f^^}"
echo "長さ:           ${#f}"
unset v
echo "未設定の既定値: ${v:-既定}"
echo "波括弧展開:     $(echo file{1..3}.txt {a,b}{x,y})"

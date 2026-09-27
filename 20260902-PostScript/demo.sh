#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step cat hello.ps
# 画面が無いので、描いた文字を txtwrite デバイスでテキストとして取り出す。
step gs -q -dBATCH -dNOPAUSE -sDEVICE=txtwrite -sOutputFile=- hello.ps
step gs -q -dNODISPLAY -dBATCH -dNOPAUSE stack.ps
step gs -q -dNODISPLAY -dBATCH -dNOPAUSE program.ps
printf '\n'

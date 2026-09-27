#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
# -hist は 1972 年当時の書き方 (エスケープが * など) に合わせるオプション。
# -o で実行ファイルを /tmp に出し、demo/ に作業ファイルを残さない。
step b -q -hist -o /tmp/fib -run fib.b
step b -q -hist -o /tmp/typeless -run typeless.b
step cat kernighan.b
step b -q -hist -o /tmp/kernighan -run kernighan.b
printf '\n'

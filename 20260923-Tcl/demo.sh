#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step tclsh /work/Basics.tcl
step tclsh /work/Repeat.tcl
step tclsh /work/Compose.tcl
printf '\n'

#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step fpc -l- -v0 -FE/build iso.pas
step /build/iso
step fpc -l- -v0 -FE/build tp.pas
step /build/tp
step fpc -l- -v0 -FE/build objfpc.pas
step /build/objfpc
step fpc -Miso -l- -v0 -FE/build modtest.pas
step /build/modtest
step fpc -Mtp -l- -v0 -FE/build modtest.pas
step /build/modtest
step fpc -Mdelphi -l- -v0 -FE/build procvar.pas
step /build/procvar
step fpc -Mobjfpc -l- -v0 -FE/build procvar.pas
printf '\n'

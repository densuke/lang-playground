#!/usr/local/bin/bash
# 版と、シェルとしての自己紹介
echo "Hello, Bash!"
echo "版: $BASH_VERSION"
echo "BASH_VERSINFO: ${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]} パッチ ${BASH_VERSINFO[2]}"
echo "名前: ${0##*/}  引数の数: $#"

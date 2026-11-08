#!/usr/local/bin/bash
# 配列と連想配列
langs=(Bash Perl "Common Lisp")
langs+=(Ruby)
echo "要素数: ${#langs[@]}"
echo "添字1: ${langs[1]}"
echo "全部: ${langs[@]}"

declare -A kind=([Bash]=シェル [C]=コンパイル)
kind[Perl]=スクリプト
for k in "${!kind[@]}"; do echo "$k -> ${kind[$k]}"; done | sort
echo "キー数: ${#kind[@]}"

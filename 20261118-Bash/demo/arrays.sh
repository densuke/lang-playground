#!/usr/local/bin/bash
# 配列と連想配列
langs=(Bash Perl Python "Common Lisp")
langs+=(Ruby)
echo "要素数: ${#langs[@]}"
echo "2 番目: ${langs[1]}"
for l in "${langs[@]}"; do printf '[%s] ' "$l"; done; echo
echo "スライス: ${langs[@]:1:2}"

declare -A kind=([Bash]=シェル [Perl]=スクリプト [C]=コンパイル)
kind[Python]=スクリプト
for k in "${!kind[@]}"; do echo "$k -> ${kind[$k]}"; done | sort
echo "キー数: ${#kind[@]}"

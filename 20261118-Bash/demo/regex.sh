#!/usr/local/bin/bash
# [[ ]] と正規表現
s="bash-5.3.20"
if [[ $s =~ ^bash-([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
  echo "major=${BASH_REMATCH[1]} minor=${BASH_REMATCH[2]} patch=${BASH_REMATCH[3]}"
fi
[[ $s == bash-* ]] && echo "グロブ一致"
[[ -z "" && ! -e /nonexistent ]] && echo "[[ ]] は && が使える"
# [[ ]] では単語分割が起きない
x="a b"
[[ $x == "a b" ]] && echo "引用なしでも安全"

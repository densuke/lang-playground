step() { w=$1; shift; printf '\n$ %s\n' "$*"; sleep 1.5; eval "$@"; sleep "$w"; }
mkdir -p /tmp/w && cp /work/hash.md /tmp/w/ && cd /tmp/w
step 5 sed -n 5,11p hash.md
step 4 sed -n 18,21p hash.md
step 1 'ucm transcript hash.md > /dev/null 2>&1'
step 5 sed -n 27,31p hash.output.md
step 5 sed -n 39,46p hash.output.md
step 5 sed -n 53,57p hash.output.md
step 6 sed -n 59,66p hash.output.md

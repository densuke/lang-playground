step() { w=$1; shift; printf '\n$ %s\n' "$*"; sleep 1.5; eval "$@"; sleep "$w"; }
mkdir -p /tmp/w && cp /work/hello.md /work/nohandler.md /tmp/w/ && cd /tmp/w
step 3 ucm version
step 6 cat hello.md
step 4 ucm transcript hello.md
step 5 sed -n 17,24p hello.output.md
step 4 sed -n 5,12p nohandler.md
step 1 'ucm transcript nohandler.md > /dev/null 2>&1'
step 6 sed -n 14,20p nohandler.output.md

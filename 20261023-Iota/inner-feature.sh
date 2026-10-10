cd /work
step() { printf '\n$ %s\n' "$1"; sleep 1.5; eval "$1"; sleep "$2"; }
sleep 10.3
step 'sh /work/demo.sh | tail -5' 24.2
step 'sh /work/loop.sh' 1.0
printf '\n$ '

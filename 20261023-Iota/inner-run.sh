cd /work
step() { printf '\n$ %s\n' "$1"; sleep 1.5; eval "$1"; sleep "$2"; }
sleep 4.7
step 'guile --version | head -1' 15.4
step 'sh /work/demo.sh | head -3' 9.75
printf '\n$ '

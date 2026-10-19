cd /work
step() { printf '\n$ %s\n' "$1"; sleep 1.5; eval "$1"; sleep "$2"; }
sleep 0.3
step 'cat hello2.we' 7.6
step 'for s in 1 2 4; do ./wh $s hello2.we | tr "\n" " "; echo "(seed=$s)"; done' 8.0
printf '\033[2J\033[H'
step './wh 1 bottles.we' 21.0
printf '\n$ '

cd /work
step() { printf '\n$ %s\n' "$1"; sleep 1.5; eval "$1"; sleep "$2"; }
sleep 3.2
step 'python3 --version' 5.5
step 'cat hello.we' 2.2
step './wh 1 hello.we' 4.5
printf '\033[2J\033[H'
step 'cat unordered.we' 9.5
step 'for s in 1 2 4; do ./wh $s unordered.we | tr "\n" " "; echo "(seed=$s)"; done' 19.5
printf '\n$ '

step() { printf '\n$ %s\n' "$*"; sleep 1.5; "$@"; sleep 5; }
cd /work
step elixir --version
step cat hello.exs
step elixir hello.exs
step elixir match.exs
sleep 2
printf "\n"

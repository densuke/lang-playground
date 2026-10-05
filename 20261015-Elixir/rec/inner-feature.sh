cd /work
printf '\n$ head -n 14 process.exs\n'; sleep 1.5; head -n 14 process.exs; sleep 9
printf '\n$ elixir process.exs\n'; sleep 1.5; elixir process.exs; sleep 14
printf '\n'

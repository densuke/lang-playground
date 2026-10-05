# 軽量プロセスとメッセージパッシング
parent = self()

pids =
  for n <- 1..3 do
    spawn(fn ->
      receive do
        {:square, from} -> send(from, {:result, self(), n * n})
      end
    end)
  end

Enum.each(pids, fn pid -> send(pid, {:square, parent}) end)

for _ <- pids do
  receive do
    {:result, _pid, value} -> IO.puts("受信: #{value}")
  end
end

# 10 万個のプロセスを作って終わりを待つ
count = 100_000
tasks = for i <- 1..count, do: Task.async(fn -> i end)
sum = tasks |> Task.await_many() |> Enum.sum()
IO.puts("#{count} プロセスの合計: #{sum}")

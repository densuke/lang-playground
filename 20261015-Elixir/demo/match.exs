# パターンマッチ: 関数の頭で場合分けする
defmodule Fib do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when n > 1, do: fib(n - 1) + fib(n - 2)
end

0..9 |> Enum.map(&Fib.fib/1) |> IO.inspect()

{:ok, value} = {:ok, 42}
IO.puts("value = #{value}")

case File.read("no_such_file") do
  {:ok, _body} -> IO.puts("読めた")
  {:error, reason} -> IO.puts("読めない: #{inspect(reason)}")
end

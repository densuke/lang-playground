IO.puts("Hello, world!")

# パイプ演算子 |> : 左の値を右の関数の第 1 引数に渡す
"elixir is fun"
|> String.split()
|> Enum.map(&String.capitalize/1)
|> Enum.join(" ")
|> IO.puts()

1..10
|> Enum.filter(&(rem(&1, 2) == 0))
|> Enum.map(&(&1 * &1))
|> IO.inspect()

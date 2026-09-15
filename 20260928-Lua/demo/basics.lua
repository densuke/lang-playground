-- Lua の基本。型は 8 種類しかない。
print("Hello, world!")

-- フィボナッチ。関数は値なので変数に入る。
local function fib(n)
  if n < 2 then return n end
  return fib(n - 1) + fib(n - 2)
end
io.write("fib: ")
for i = 0, 9 do io.write(fib(i), " ") end
print()

-- テーブルは 1 つで配列でも辞書でもある。添字は 1 から。
local t = {10, 20, 30, name = "lua"}
print(#t, t[1], t.name, type(t))

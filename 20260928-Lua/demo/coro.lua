-- コルーチン。途中で止まって、あとから続きを走らせられる。
local function counter(name)
  return coroutine.wrap(function()
    for i = 1, 3 do coroutine.yield(name .. i) end
  end)
end

local a, b = counter("a"), counter("b")
for i = 1, 3 do
  print(a(), b())                       -- 交互に進む。スレッドではない
end

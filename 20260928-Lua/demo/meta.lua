-- メタテーブルでテーブルの振る舞いを変える。
local Vec = {}
Vec.__index = Vec                       -- 見つからない名前はここを探す

function Vec.new(x, y) return setmetatable({x = x, y = y}, Vec) end
function Vec.__add(a, b) return Vec.new(a.x + b.x, a.y + b.y) end
function Vec.__tostring(v) return "(" .. v.x .. ", " .. v.y .. ")" end
function Vec:len() return math.sqrt(self.x^2 + self.y^2) end

local a, b = Vec.new(3, 4), Vec.new(1, 2)
print(tostring(a + b))                  -- __add が呼ばれる
print(a:len())                          -- __index 経由でメソッド

-- クラス構文は無い。これだけでオブジェクト指向になる。

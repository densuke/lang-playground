# 多重代入: 右側を先に全部計算してから、左へ配る
a, b = 1, 2
a, b = b, a
print("入れ替え:", a, b)

a, b = 0, 1
for _ in range(5):
    a, b = b, a + b
print("多重代入で5回:", a, b)

# 一行ずつ代入すると、b の計算に「更新後の a」が使われてしまう
a, b = 0, 1
for _ in range(5):
    a = b
    b = a + b
print("一行ずつで5回:", a, b)

# ブロックの範囲は字下げで決まる。波括弧は使わない
def classify(n):
    if n % 2 == 0:
        return "偶数"
    return "奇数"

for n in range(4):
    print(n, classify(n))
print("ループの外")

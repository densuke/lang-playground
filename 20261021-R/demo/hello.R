cat("Hello, world!\n")

# 代入は <-。数値はすべてベクトル (1 個の値も長さ 1 のベクトル)
x <- c(1, 2, 3, 4, 5)
print(x * 2)          # 全要素にいっぺんに掛ける (ループ不要)
print(x[x > 2])       # 条件で選ぶ
print(sum(x)); print(mean(x))

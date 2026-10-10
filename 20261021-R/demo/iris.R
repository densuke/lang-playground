# 組み込みデータセット iris (アヤメ 150 件) の集計
print(head(iris, 3))
print(table(iris$Species))
print(aggregate(Sepal.Length ~ Species, data = iris, FUN = mean))
# 端末で見えるグラフ (base R の stem() だけ)
stem(iris$Petal.Length)

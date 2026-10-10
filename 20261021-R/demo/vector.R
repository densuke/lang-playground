# ベクトル演算とデータフレーム
height <- c(150, 160, 170, 180)
weight <- c(50, 56, 65, 80)
bmi <- weight / (height / 100)^2     # 要素ごとの計算
df <- data.frame(height, weight, bmi = round(bmi, 1))
print(df)
print(summary(df$bmi))

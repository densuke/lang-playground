# 動画の端末収録 (asciinema) に使ったスクリプト

コンテナの中で流すスクリプトです。収録はプレイグラウンドの直下で次のように行いました。

```bash
asciinema rec --overwrite --idle-time-limit 2 --window-size 68x16 \
    -c "./run.sh bash -c \"\$(cat cast/run-in-container.sh)\"" run.cast
```

asciinema 3.2.1 は `--idle-time-limit` を収録時に適用しないため、出力を `/dev/null` に送った
transcript の無出力の待ち (10 秒超) は収録後に 2 秒へ詰めています。

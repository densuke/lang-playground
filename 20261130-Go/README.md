# Go を試す (2026-11-30)

「古今東西 プログラミング言語紹介」2026-11-30 回の実験環境です。

## 使い方

```bash
./run.sh                                  # 対話シェル (bash) に入る
./run.sh go run /work/hello.go            # 1 本だけ動かす
./run.sh bash -s < demo.sh                # 全部を順に実行する
./run.sh bash -c 'cd /work && go build -o /tmp/hello hello.go && /tmp/hello'
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。

## 処理系について

公式イメージ `golang:1.27.4-trixie` (Go 1.27.4、2026-11-10 リリース。BSD 系ライセンス) を、
マニフェストの digest で固定して使います。arm64 / amd64 の両方が配られています。
動かして確かめたのは linux/arm64 の 1.27.4 だけです。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.go` | Hello, World。`go run hello.go` / `go build` |
| `demo/sortsignal.go` | goroutine で並べ替え、終わったら channel に合図を送る (Effective Go の例を動く形に) |
| `demo/workers.go` | 5 つの goroutine の結果を channel で集める |
| `demo/race.go` | 1000 個の goroutine が鍵なしで同じ変数を増やす。毎回違う値になる。`go run -race race.go` で `DATA RACE` の警告が出る |

## 動かした出力 (2026-11-22)

```
go version go1.27.4 linux/arm64
Hello, World!
[1 2 3 5 8 9]
期待する値は 1000、実際は 953   (実行のたびに変わる)
-rwxr-xr-x 1 root root 2342397 Nov 22 04:00 /tmp/hello
```

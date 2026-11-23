# コンテナ内で bash -s に流して使う。バイナリは /tmp へ出す (demo/ を汚さない)
set -u
cd /work
go version
echo "--- hello (go run)"; go run hello.go
echo "--- sortsignal (goroutine と channel)"; go run sortsignal.go
echo "--- workers (5 つの goroutine で集める)"; go run workers.go
echo "--- race (鍵なしの書き換え。-race で検出)"; go run -race race.go 2>&1 | head -12
echo "--- go build (実行ファイル)"; go build -o /tmp/hello hello.go && ls -l /tmp/hello && /tmp/hello

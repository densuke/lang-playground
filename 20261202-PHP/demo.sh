# コンテナ内で bash -s に流して使う。
set -u
cd /work
echo "--- 版"; php -v | head -1; php -r 'echo PHP_VERSION, PHP_EOL;'
echo "--- hello"; php hello.php
echo "--- index.php (タグの外はそのまま出て、中だけ展開される)"; php index.php
echo "--- php -S + curl (組み込みサーバー。公衆網では使わない)"
php -S 127.0.0.1:8000 -t /work >/tmp/server.log 2>&1 &
pid=$!
sleep 1
curl -s http://127.0.0.1:8000/index.php
kill "$pid"; wait "$pid" 2>/dev/null
echo "--- array"; php array.php
echo "--- version_check"; php version_check.php

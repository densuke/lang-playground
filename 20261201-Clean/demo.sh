# コンテナ内で bash -s に流して使う。clm の生成物は /tmp の作業コピーに出す (demo/ を汚さない)
set -u
rm -rf /tmp/w && cp -r /work /tmp/w && cd /tmp/w
# 見せ場のコンパイルが失敗するもの。コンパイラの出力と終了コードを見せる
fails() { clm "$1" -o "/tmp/$1" 2>&1; echo "clm の終了コード: $?"; }

clm --version | head -1
echo "--- hello (Start の式を評価する。main は無い)"; clm -ms hello -o /tmp/hello && /tmp/hello 2>/dev/null
echo "--- squares (内包表記と、終わりのないリストの遅延評価)"; clm -ms squares -o /tmp/squares && /tmp/squares 2>/dev/null
echo "--- nfib (コンパイルして実行時間を測る)"; time clm -ms nfib -o /tmp/nfib; /tmp/nfib 2>&1
echo "--- write_file (*File を使って書いて、読み戻す)"; clm -ms write_file -o /tmp/write_file && /tmp/write_file 2>/dev/null
echo "--- shared_file (ユニーク性を破る。型検査で拒否されるのが見せ場)"; fails shared_file

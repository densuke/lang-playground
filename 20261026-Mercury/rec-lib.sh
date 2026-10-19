# 収録用の共通部品。rec-run.sh / rec-feature.sh が先頭で読み込む (一緒に bash -c へ渡す)。
# 時刻は cast の頭からの秒で書く。OFFSET は「コンテナが立ち上がるまでの秒」。
OFFSET=${OFFSET:-1.0}
t0=$EPOCHREALTIME
at() { sleep "$(awk -v n="$EPOCHREALTIME" -v t0="$t0" -v o="$OFFSET" -v t="$1" 'BEGIN{d=t0+t-o-n; print (d>0?d:0)}')"; }
# 時刻 $1 にコマンド $2 を打ち、1.5 秒後に実行する
step() { at "$1"; printf '\n$ %s\n' "$2"; sleep 1.5; bash -c "$2"; }
clear_at() { at "$1"; printf '\033[H\033[2J'; }
prompt_at() { at "$1"; printf '\n$ '; }
# デモの置き場を汚さないよう作業用ディレクトリへ写す。
work=$(mktemp -d); cp /work/*.m "$work"; cd "$work" || exit 1
# mmc は Making の進捗行を省き、端末幅 (68 桁) で折り返して呼ぶ。エラーや警告はそのまま出す。
mmc() { command mmc "$@" 2>&1 | grep -v '^Making' | fold -s -w 66; return "${PIPESTATUS[0]}"; }
export -f mmc

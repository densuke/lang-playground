# 収録用 (assets/feature.cast)。AID の Let / Do part / Eh? / 十進の丸め。
# 前準備 (画面に出さない): TOPS-10 を起動して AID を入れておく
#   container run -d --name joss-rec -v "$PWD/images:/images:ro" -v "$PWD/demo:/work" lang-joss-aid \
#       bash -c 'aid-boot >/dev/null; aid-run /dev/null; touch /tmp/ready; sleep 7200'
#   (/tmp/ready ができるまで待つ。約 1 分半)
# 収録: asciinema rec --overwrite --idle-time-limit 12 --window-size 68x16 -c 'container exec -it joss-rec bash -c "$(cat rec-feature.sh)"' feature.cast
sleep 1
expect -f - <<'EXP'
source /work/rec.exp
spawn telnet localhost 10603
expect "Connected"
wait_login
typed "login 100,100" {Password:}
secret "demo1" {\r\n\.}
send -s -- "r aid\r"
expect -re {[\n\f]\*}
sleep 2
# 式に名前を付けて関数にする
typed "Let f(b,c) = b^2 + 2*b*c + c^2" {[\n\f]\*}
sleep 2.5
typed "Type f(4,10)" {=\s+196}
sleep 8
# 行番号を付けると蓄えられ、Do part で呼べる
typed "1.1 Type i*i" {[\n\f]\*}
sleep 1.5
typed "Do part 1 for i = 1(1)5" {=\s+25[^\n]*\r?\n\*}
sleep 5
# 大文字だけの命令は通らない
typed "TYPE 2+2" {Eh\?}
sleep 3
# 十進 9 桁の丸め
typed "Type 1/3" {=\s+\.333333333}
sleep 2
typed "Type 1/3+1/3+1/3" {=\s+\.999999999}
# 台詞が cast より長いと動画で cast がループする。画面が最後に変わる時刻で尺が決まる (待ちは数えない) ので、もう 1 つ打つ
sleep 6
typed "Type 2/3" {=\s+\.666666667}
sleep 2
EXP

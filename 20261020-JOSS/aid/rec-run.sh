# 収録用 (assets/run.cast)。起動 -> ログイン -> AID の取り込み -> AID で Type 2+2 まで。
# 使い方: asciinema rec --overwrite --idle-time-limit 12 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
cd /tmp
step() { printf '\n$ %s\n' "$1"; sleep 1; bash -c "$1"; }
sleep 2
step 'unzip -q /images/tops603ka.zip -d /disks'
step 'bunzip2 -c /images/bb-x130a-sb.tap.bz2 > /disks/bb-x130a-sb.tap'
printf '\n$ tail -f /dev/null | pdp10-ka /opt/ini/run.ini > console.log &\n'
sleep 1
(tail -f /dev/null | pdp10-ka /opt/ini/run.ini > /tmp/console.log 2>&1 &)
sleep 1
printf '$ tail -f console.log\n'
tail -n +1 -f /tmp/console.log &
logpid=$!
until grep -q 'system 50' /tmp/console.log 2>/dev/null; do sleep 1; done
sleep 3
kill "$logpid"
printf '\n$ telnet localhost 10603\n'
sleep 1
expect -f - <<'EXP'
source /work/rec.exp
spawn telnet localhost 10603
expect "Connected"
wait_login
sleep 2
# 1. AID はテープから入れる (BACKUP)
typed "login 1,2" {Password:}
secret "FAILSA" {\r\n\.}
sleep 1
typed "r backup" {\r\n/}
typed "/tape mta0:" {\r\n/}
typed "/rewind" {\r\n/}
typed "/restore dskb:\[1,4]=aid.exe" {\r\n}
typed "!" {Done}
sleep 1
typed "/exit" {\r\n\.}
typed "protect sys:aid.exe <155>" {\r\n\.}
typed "r logout" {Logged off}
sleep 1.5
# 2. 一般利用者でログインして AID を起動
typed "login 100,100" {Password:}
secret "demo1" {\r\n\.}
sleep 1
send -s -- "r aid\r"
expect -re {[\n\f]\*}
sleep 5.5
typed "Type 2+2" {=\s+4}
# 台詞が cast より長いと動画で cast がループする。画面が最後に変わる時刻で尺が決まる (待ちは数えない) ので、もう 1 つ打つ
sleep 3.5
typed "Type 22/7" {=\s+3\.14285714}
sleep 2
EXP

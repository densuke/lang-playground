use strict;
use warnings;

# アクセスログから「ステータスごとの件数」を抜き出して報告する。
# Practical Extraction and Report の Extraction (抽出) と Report (報告) そのもの。
my %count;
while (my $line = <DATA>) {
    # 正規表現は言語に組み込み。() で取り出した部分が順に $1, $2, $3 に入る
    next unless $line =~ /"(GET|POST) (\S+)[^"]*" (\d{3})/;
    $count{$3}++;
}

for my $status (sort keys %count) {
    printf "%s %3d %s\n", $status, $count{$status}, '*' x $count{$status};
}

__DATA__
127.0.0.1 - - [14/Oct/2026:09:00:01 +0900] "GET /index.html HTTP/1.1" 200 512
127.0.0.1 - - [14/Oct/2026:09:00:02 +0900] "GET /perl.png HTTP/1.1" 200 2048
127.0.0.1 - - [14/Oct/2026:09:00:03 +0900] "GET /old.html HTTP/1.1" 404 128
127.0.0.1 - - [14/Oct/2026:09:00:04 +0900] "POST /form HTTP/1.1" 302 0
127.0.0.1 - - [14/Oct/2026:09:00:05 +0900] "GET /index.html HTTP/1.1" 200 512
127.0.0.1 - - [14/Oct/2026:09:00:06 +0900] "GET /nothing HTTP/1.1" 404 128

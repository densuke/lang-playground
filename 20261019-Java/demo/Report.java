// アクセスログからステータスごとの件数を数える (Perl 回の report.pl と同じ題材)。
// テキストブロック・record・Stream・Collectors.groupingBy。
record Hit(String method, String path, int status) {}

static final String LOG = """
        127.0.0.1 - - [19/Oct/2026:09:00:01 +0900] "GET /index.html HTTP/1.1" 200 512
        127.0.0.1 - - [19/Oct/2026:09:00:02 +0900] "GET /java.png HTTP/1.1" 200 2048
        127.0.0.1 - - [19/Oct/2026:09:00:03 +0900] "GET /old.html HTTP/1.1" 404 128
        127.0.0.1 - - [19/Oct/2026:09:00:04 +0900] "POST /form HTTP/1.1" 302 0
        127.0.0.1 - - [19/Oct/2026:09:00:05 +0900] "GET /index.html HTTP/1.1" 200 512
        127.0.0.1 - - [19/Oct/2026:09:00:06 +0900] "GET /nothing HTTP/1.1" 404 128
        """;

void main() {
    var pattern = java.util.regex.Pattern.compile("\"(GET|POST) (\\S+)[^\"]*\" (\\d{3})");
    var count = LOG.lines()
            .map(pattern::matcher)
            .filter(java.util.regex.Matcher::find)
            .map(m -> new Hit(m.group(1), m.group(2), Integer.parseInt(m.group(3))))
            .collect(java.util.stream.Collectors.groupingBy(Hit::status,
                    java.util.TreeMap::new, java.util.stream.Collectors.counting()));
    count.forEach((status, n) -> IO.println("%s %3d %s".formatted(status, n, "*".repeat(n.intValue()))));
}

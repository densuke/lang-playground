// 仮想スレッド (Java 21 で正式機能)。1 万本が各 1 秒眠っても、全体は 1 秒ほどで終わる。
void main() throws Exception {
    var started = System.nanoTime();
    try (var executor = java.util.concurrent.Executors.newVirtualThreadPerTaskExecutor()) {
        for (int i = 0; i < 10_000; i++) {
            executor.submit(() -> {
                Thread.sleep(java.time.Duration.ofSeconds(1));
                return null;
            });
        }
    } // close() が全タスクの完了を待つ
    var seconds = (System.nanoTime() - started) / 1_000_000_000.0;
    IO.println("10000 本の仮想スレッドが完了 (各 1 秒睡眠): %.1f 秒".formatted(seconds));
}

#include <algorithm>
#include <print>
#include <vector>

// テンプレート: 型ごとに専用のコードがコンパイル時に作られる
template <typename T>
T twice(T x) { return x + x; }

// constexpr: コンパイル時に計算させる
constexpr long fib(int n) { return n < 2 ? n : fib(n - 1) + fib(n - 2); }
static_assert(fib(10) == 55);          // 間違っていればコンパイルが通らない

int main() {
    std::println("{} {}", twice(21), twice(1.5));
    std::vector<int> v{5, 3, 8, 1};
    std::ranges::sort(v);               // C++20 の ranges
    for (int x : v) std::print("{} ", x);
    std::println("");
    std::println("fib(40) = {}", fib(40));
}

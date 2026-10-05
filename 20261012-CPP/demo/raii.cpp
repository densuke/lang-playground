#include <print>
#include <string>
// C with Classes 以来の「クラス」。片付けはデストラクタで (RAII)
class Guard {
    std::string name;
public:
    explicit Guard(std::string n) : name(std::move(n)) {
        std::println("開ける: {}", name); }
    ~Guard() { std::println("閉じる: {}", name); }
};
int main() {
    Guard a("ファイル");
    { Guard b("ロック"); std::println("作業中"); }   // b が閉じる
    std::println("おわり");
}                                                    // a が閉じる

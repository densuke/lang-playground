/* README の対応表を switch に写した Brainfuck 処理系 (./mini ファイル.b) */
#include <stdio.h>

int main(int argc, char **argv) {
    static char src[65536], array[30000];
    int p = 0, depth, c;
    FILE *f = (argc > 1) ? fopen(argv[1], "r") : NULL;
    if (!f) return 1;
    size_t n = fread(src, 1, sizeof src - 1, f);
    for (size_t pc = 0; pc < n; pc++) {
        switch (src[pc]) {
        case '+': array[p]++; break;
        case '-': array[p]--; break;
        case '>': p++; break;
        case '<': p--; break;
        case '.': putchar(array[p]); break;
        case ',':
            c = getchar();
            array[p] = (c == EOF) ? 0 : c;  /* 入力の終わりは 0 */
            break;
        case '[':
            if (array[p]) break;
            for (depth = 1; depth; ) {
                pc++;
                depth += (src[pc] == '[') - (src[pc] == ']');
            }
            break;
        case ']':
            if (!array[p]) break;
            for (depth = 1; depth; ) {
                pc--;
                depth += (src[pc] == ']') - (src[pc] == '[');
            }
            break;
        }
    }
    return 0;
}

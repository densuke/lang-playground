/* Malbolge インタプリタ (Ben Olmstead の仕様に基づく最小実装)。
   三進10桁 = 59049 のメモリ、実行後に命令が暗号化される、crazy 演算。 */
#include <stdio.h>
#include <string.h>

#define MEM 59049
static int m[MEM];

/* 命令の暗号化に使う置換表 (仕様で定義された固定の 94 文字) */
static const char *cr =
"5z]&gqtyfr$(we4{WP)H-Zn,[%\\3dL+Q;>U!pJS72FhOA1CB6v^=I_0/8|jsb9m<.TVac`uY*MK'X~xDl}REokN:#?G\"i@";

/* crazy 演算: 三進の各桁ごとに決まった表を引く */
static int crazy(int a, int b) {
    static const int t[3][3] = {{1,0,0},{1,0,2},{2,2,1}};
    int r = 0, p = 1;
    for (int i = 0; i < 10; i++) {
        r += t[b / p % 3][a / p % 3] * p;
        p *= 3;
    }
    return r;
}

static int rot(int v) { return v / 3 + v % 3 * 19683; }

int main(int argc, char **argv) {
    FILE *f = fopen(argv[1], "rb");
    if (!f) { fprintf(stderr, "open failed\n"); return 1; }

    int n = 0, c;
    while ((c = fgetc(f)) != EOF) {
        if (c == ' ' || c == '\t' || c == '\n' || c == '\r') continue;
        if (c < 33 || c > 126) { fprintf(stderr, "invalid char\n"); return 1; }
        /* 読み込み時に、その位置で有効な命令かを検証する (仕様) */
        int op = (c + n) % 94;
        if (op != 4 && op != 5 && op != 23 && op != 39 && op != 40
            && op != 62 && op != 68 && op != 81) {
            fprintf(stderr, "invalid instruction at %d (op=%d)\n", n, op);
            return 1;
        }
        m[n++] = c;
    }
    fclose(f);
    for (int i = n; i < MEM; i++) m[i] = crazy(m[i-1], m[i-2]);

    int a = 0, cptr = 0, d = 0;
    for (;;) {
        if (m[cptr] < 33 || m[cptr] > 126) return 0;
        int instr = (m[cptr] + cptr) % 94;
        switch (instr) {
            case 4:  cptr = m[d]; break;                 /* j */
            case 5:  putchar(a % 256); break;            /* o */
            case 23: a = getchar(); if (a == EOF) a = MEM - 1; break;
            case 39: a = m[d] = rot(m[d]); break;        /* p */
            case 40: d = m[d]; break;                    /* < */
            case 62: a = m[d] = crazy(a, m[d]); break;   /* * */
            case 68: break;                              /* nop */
            case 81: return 0;                           /* v */
            default: break;
        }
        /* 実行した命令をその場で暗号化する = 同じ場所を二度同じには読めない */
        m[cptr] = cr[m[cptr] - 33];
        cptr = (cptr + 1) % MEM;
        d = (d + 1) % MEM;
    }
}

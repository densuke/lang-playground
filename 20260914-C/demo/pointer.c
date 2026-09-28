#include <stdio.h>

int main(void) {
    char s[] = "hello";
    char *p = s;            /* 配列の名前は、先頭の要素を指すポインタになる */

    printf("p == &s[0] : %d\n", p == &s[0]);
    printf("s[1]       : %c\n", s[1]);
    printf("*(p + 1)   : %c\n", *(p + 1));
    printf("1[s]       : %c\n", 1[s]);   /* a[i] は *(a + i) なので、これも通る */

    /* ポインタを進めながら、1 文字ずつたどる */
    for (char *q = s; *q != '\0'; q++) printf("%c", *q - 'a' + 'A');
    printf("\n");

    /* ただし配列そのものはポインタではない。大きさが違う */
    printf("sizeof s   : %zu\n", sizeof s);
    printf("sizeof p   : %zu\n", sizeof p);
    return 0;
}

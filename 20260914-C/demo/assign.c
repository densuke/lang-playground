#include <stdio.h>

int main(void) {
    int x = 5;

    if (x == 0) printf("x == 0 is true\n");
    else        printf("x == 0 is false\n");

    /* == のつもりで = と書くと、代入になる。条件は代入した値 0 で、偽 */
    if (x = 0) printf("x = 0 is true\n");
    else       printf("x = 0 is false\n");

    printf("x is now %d\n", x);
    return 0;
}

#include <stdio.h>

int fib(int n) {
    return n < 2 ? n : fib(n - 1) + fib(n - 2);
}

int main(void) {
    printf("Hello, world!\n");
    for (int i = 0; i < 10; i++) printf("%d ", fib(i));
    printf("\n");
    return 0;
}

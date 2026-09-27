main() {
    extrn printf;
    auto a, b, t, i;
    a = 0;
    b = 1;
    i = 0;
    while (i < 10) {
        printf("%d ", a);
        t = a + b;
        a = b;
        b = t;
        i = i + 1;
    }
    printf("*n");
}

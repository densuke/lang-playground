/* B has no types. Every variable is one machine word. */
main() {
    extrn printf;
    auto v 3, p, n;    /* v is a vector of words */
    v[0] = 10;
    v[1] = 20;
    v[2] = 30;
    p = v;              /* the same word used as an address */
    n = p[0] + p[2];    /* and its contents used as integers */
    printf("p[0] + p[2] = %d*n", n);
    n = 'AB';           /* a character constant is just a word, too */
    printf("'AB' = %d*n", n);
}

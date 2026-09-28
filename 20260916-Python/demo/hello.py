def fib(n):
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b

print("Hello, world!")
print(list(fib(10)))
print([x * x for x in range(10) if x % 2 == 0])

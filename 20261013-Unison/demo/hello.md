```ucm
scratch/main> lib.install @unison/base
```

```unison
fib : Nat -> Nat
fib n = if n < 2 then n else fib (n - 1) + fib (n - 2)

main : '{IO, Exception} ()
main = do
  printLine "Hello, world!"
  printLine ("fib: " ++ Text.join " " (List.map (n -> Nat.toText (fib n)) (List.range 0 10)))
```

```ucm
scratch/main> add
scratch/main> run main
```

```ucm :hide
scratch/main> lib.install @unison/base
```

```unison
double : Nat -> Nat
double x = x * 2

quad : Nat -> Nat
quad n = double (double n)
```

```ucm
scratch/main> add
scratch/main> names double
```

```unison
twice : Nat -> Nat
twice y = y * 2
```

```ucm
scratch/main> add
scratch/main> names twice
scratch/main> move.term double timesTwo
scratch/main> view quad
```

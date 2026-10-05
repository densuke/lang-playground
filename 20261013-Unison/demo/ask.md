```ucm :hide
scratch/main> lib.install @unison/base
```

```unison
ability Ask where
  ask : Nat

addTwice : '{Ask} Nat
addTwice = do Ask.ask + Ask.ask

alwaysTen : '{g, Ask} r ->{g} r
alwaysTen action =
  h = cases
    { r } -> r
    { Ask.ask -> resume } -> handle resume 10 with h
  handle action() with h

counter : '{g, Ask} r ->{g} r
counter action =
  go n = cases
    { r } -> r
    { Ask.ask -> resume } -> handle resume (n + 1) with go (n + 1)
  handle action() with go 0

main : '{IO, Exception} ()
main = do
  printLine ("always 10: " ++ Nat.toText (alwaysTen addTwice))
  printLine ("counter  : " ++ Nat.toText (counter addTwice))
```

```ucm
scratch/main> add
scratch/main> run main
```

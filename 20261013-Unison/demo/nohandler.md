```ucm :hide
scratch/main> lib.install @unison/base
```

```unison :error
ability Ask where
  ask : Nat

main : '{IO, Exception} ()
main = do
  printLine (Nat.toText (Ask.ask + Ask.ask))
```

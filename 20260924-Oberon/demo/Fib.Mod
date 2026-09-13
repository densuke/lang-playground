MODULE Fib;
  IMPORT Out;

  (* 名前の後ろの * が公開の印 (export mark)。
     これだけでモジュールの外から見える。 *)
  PROCEDURE Fib*(n: INTEGER): INTEGER;
  BEGIN
    IF n < 2 THEN RETURN n
    ELSE RETURN Fib(n-1) + Fib(n-2)
    END
  END Fib;

  PROCEDURE Run*;
    VAR i: INTEGER;
  BEGIN
    Out.String("Hello, world!"); Out.Ln;
    FOR i := 0 TO 9 DO Out.Int(Fib(i), 3) END;
    Out.Ln
  END Run;

BEGIN
  Run
END Fib.

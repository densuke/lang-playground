MODULE Shapes;
  IMPORT Out;

TYPE
  (* Oberon が Modula-2 に足した、ほぼ唯一の機能がこの型拡張。
     継承という言葉を使わず、レコードの拡張として導入されている。 *)
  Figure = RECORD x, y: INTEGER END;
  Circle = RECORD (Figure) r: INTEGER END;

  FigurePtr = POINTER TO Figure;
  CirclePtr = POINTER TO Circle;

(* 宣言の順番は CONST → TYPE → VAR → PROCEDURE で固定。
   VAR を手続きより後ろに書くと "END missing" で落ちる。 *)
VAR
  f: FigurePtr;
  c: CirclePtr;

PROCEDURE Describe(f: FigurePtr);
BEGIN
  Out.String("figure at "); Out.Int(f.x, 0);
  Out.String(","); Out.Int(f.y, 0);
  (* 実行時の型判定。Circle は Figure を受け取る場所へ渡せる *)
  IF f IS CirclePtr THEN
    Out.String("  circle r="); Out.Int(f(CirclePtr).r, 0)
  END;
  Out.Ln
END Describe;

BEGIN
  NEW(f); f.x := 1; f.y := 2;
  NEW(c); c.x := 10; c.y := 20; c.r := 5;
  Describe(f);
  Describe(c)
END Shapes.

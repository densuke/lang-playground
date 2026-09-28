{ モード指定なし。コマンドラインの -Miso / -Mtp で方言を切り替えて比べる }
program modtest(output);
var
  a, b: integer;
begin
  a := -7;
  b := 3;
  writeln('-7 mod 3 = ', a mod b)
end.

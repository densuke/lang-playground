{$mode iso}
{ 標準 Pascal (ISO 7185)。使うファイルは program の引数に書く }
program iso(output);
const
  N = 5;
type
  Vector = array[1..N] of integer;
var
  v: Vector;
  i, total: integer;

procedure Fill(var a: Vector);
var
  k: integer;
begin
  for k := 1 to N do
    a[k] := k * k
end;

begin
  Fill(v);
  total := 0;
  for i := 1 to N do
    total := total + v[i];
  writeln('sum of squares 1..', N:1, ' =', total)
end.

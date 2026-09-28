{ モード指定なし。-Mdelphi では通り、-Mobjfpc では止まる }
program procvar;
type
  TIntFunc = function(x: longint): longint;

function Twice(x: longint): longint;
begin
  Twice := x * 2
end;

var
  f: TIntFunc;
begin
  f := Twice;      { objfpc では f := @Twice; と書く必要がある }
  writeln(f(21))
end.

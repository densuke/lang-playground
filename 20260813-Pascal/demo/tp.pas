{$mode tp}
{ Turbo Pascal 流。uses で unit を取り込み、string 型で文字列を扱う }
program tp;
uses greet;
var
  s: string;
begin
  s := Hello('Turbo Pascal');
  writeln(s);
  writeln('length = ', Length(s), ', max = ', High(s));
  writeln('copy   = ', Copy(s, 8, 5))
end.

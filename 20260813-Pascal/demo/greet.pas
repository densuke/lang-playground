{$mode tp}
{ Turbo Pascal 流の unit。interface に公開するものを、implementation に中身を書く }
unit greet;

interface

function Hello(name: string): string;

implementation

function Hello(name: string): string;
begin
  Hello := 'Hello, ' + name + '!'
end;

end.

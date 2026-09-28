{$mode objfpc}{$H+}
{ Object Pascal。クラス、プロパティ、例外が使える }
program objfpc;
uses SysUtils;
type
  TAccount = class
  private
    FBalance: Integer;
  public
    procedure Withdraw(Amount: Integer);
    property Balance: Integer read FBalance write FBalance;
  end;

procedure TAccount.Withdraw(Amount: Integer);
begin
  if Amount > FBalance then
    raise Exception.CreateFmt('insufficient funds (balance %d, withdraw %d)', [FBalance, Amount]);
  FBalance := FBalance - Amount;
end;

var
  Acc: TAccount;
begin
  Acc := TAccount.Create;
  try
    Acc.Balance := 100;
    Acc.Withdraw(30);
    WriteLn('balance = ', Acc.Balance);
    try
      Acc.Withdraw(500);
    except
      on E: Exception do
        WriteLn(E.ClassName, ': ', E.Message);
    end;
  finally
    Acc.Free;
  end;
end.

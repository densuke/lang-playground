# テキストではなくオブジェクトが流れていることを見せる
$PSStyle.OutputRendering = "PlainText"   # 端末でないときの色コードを出さない
$item = Get-Item /etc/os-release
$item.GetType().FullName          # 型名
$item.Length                      # プロパティ (数値)
$item.Length.GetType().Name       # Int64。文字列ではない
"--- Get-Member で、流れてくるものの中身を見る ---"
Get-Item /etc/os-release | Get-Member -MemberType Property | Select-Object -First 6 Name, MemberType

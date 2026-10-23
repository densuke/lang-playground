# JSON はそのままオブジェクトになる。テキスト整形も正規表現も要らない
$PSStyle.OutputRendering = "PlainText"   # 端末でないときの色コードを出さない
$json = @'
[
  {"name":"bash","kind":"shell","year":1989},
  {"name":"zsh","kind":"shell","year":1990},
  {"name":"PowerShell","kind":"shell","year":2006}
]
'@
$shells = $json | ConvertFrom-Json
$shells | Where-Object year -gt 1989 | Sort-Object year -Descending | Format-Table
"--- 同じものを別の形へ ---"
$shells | Select-Object name, year | ConvertTo-Csv -NoTypeInformation
"--- UNIX の道具とも混ぜられる (こちらは文字列) ---"
(uname -s).GetType().Name

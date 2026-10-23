# プロパティで絞る・並べる。cut / awk / sort -k を使わない
$PSStyle.OutputRendering = "PlainText"   # 端末でないときの色コードを出さない
Get-ChildItem /usr/bin |
    Where-Object { $_.Length -gt 500KB } |
    Sort-Object Length -Descending |
    Select-Object -First 5 Name, Length
"--- 件数と合計 ---"
Get-ChildItem /usr/bin | Measure-Object Length -Sum | Select-Object Count, Sum | Format-Table
"--- シンボリックリンクか実体か ---"
Get-ChildItem /usr/bin | Group-Object LinkType | Select-Object Count, @{n="種別"; e={ if ($_.Name) { $_.Name } else { "実体" } }} | Format-Table

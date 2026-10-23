Get-ChildItem /usr/bin |
    Where-Object Length -gt 500KB |
    Sort-Object Length -Descending |
    Select-Object -First 3 Name, Length

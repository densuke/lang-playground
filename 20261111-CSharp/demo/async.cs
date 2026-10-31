// async / await (C# 5.0、2012 年): 待つ処理を順番に書ける
using System.Diagnostics;

var sw = Stopwatch.StartNew();
async Task<string> Fetch(string name, int ms)
{
    await Task.Delay(ms);                       // ネットワークの代わりに待つ
    Console.WriteLine($"  {name} 完了 ({sw.ElapsedMilliseconds / 100 * 100} ms 付近)");
    return name.ToUpper();
}

Console.WriteLine("順番に:");
var a = await Fetch("a", 300);
var b = await Fetch("b", 300);
Console.WriteLine($"  {a}{b}  合計 {sw.ElapsedMilliseconds / 100 * 100} ms 付近");

sw.Restart();
Console.WriteLine("同時に:");
var results = await Task.WhenAll(Fetch("x", 300), Fetch("y", 300), Fetch("z", 300));
Console.WriteLine($"  {string.Concat(results)}  合計 {sw.ElapsedMilliseconds / 100 * 100} ms 付近");

// Hello World。クラスも Main も要らない (トップレベル文、C# 9 から)
Console.WriteLine("Hello, world!");
Console.WriteLine($"C# on {System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription}");
var answer = 6 * 7;                       // var: 型は int と推論される
Console.WriteLine($"{answer} は {answer.GetType().Name}");

// Hello World。クラスも Main も要らない (C# 9 から)
Console.WriteLine("Hello, world!");
var answer = 6 * 7;                  // var: 型は int と推論される
var type = answer.GetType().Name;
Console.WriteLine($"{answer} は {type}");
Console.WriteLine(Environment.Version);

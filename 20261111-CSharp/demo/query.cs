// LINQ: コレクションに問い合わせる (C# 3.0)
Lang[] langs = [new("C", 1972), new("Java", 1995),
                new("C#", 2000), new("Go", 2009)];
var query = from l in langs
            where l.Year >= 1995
            orderby l.Year descending
            select $"{l.Year} {l.Name}";
foreach (var line in query) Console.WriteLine(line);
Console.WriteLine($"古い: {langs.Count(l => l.Year < 1990)}件");

record Lang(string Name, int Year);

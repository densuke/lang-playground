// LINQ: コレクションに SQL のような問い合わせを書く (C# 3.0、2007 年)
var langs = new[]
{
    new Lang("C", 1972), new Lang("C++", 1985), new Lang("Java", 1995),
    new Lang("C#", 2000), new Lang("Rust", 2015), new Lang("Go", 2009),
};

// クエリ式
var query = from l in langs
            where l.Year >= 1995
            orderby l.Year descending
            select $"{l.Year} {l.Name}";
foreach (var line in query) Console.WriteLine(line);

// 同じことをメソッドで書く
Console.WriteLine(string.Join(", ", langs.Where(l => l.Year < 1990).Select(l => l.Name)));
Console.WriteLine($"平均 {langs.Average(l => l.Year):F1} 年、最古 {langs.MinBy(l => l.Year)!.Name}");
foreach (var g in langs.GroupBy(l => l.Year / 10 * 10).OrderBy(g => g.Key))
    Console.WriteLine($"{g.Key}年代: {string.Join(" ", g.Select(l => l.Name))}");

record Lang(string Name, int Year);

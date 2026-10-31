// record と switch 式によるパターンマッチ
Shape[] shapes = [new Circle(1.5), new Rect(3, 4), new Rect(2, 2), new Circle(0)];

foreach (var s in shapes)
    Console.WriteLine($"{s} -> {Describe(s):F2}  {Kind(s)}");

var moved = new Rect(3, 4) with { Width = 10 };   // with: 一部だけ変えた複製
Console.WriteLine($"{moved}  同値か: {moved == new Rect(10, 4)}");

double Describe(Shape s) => s switch
{
    Circle(var r) => Math.PI * r * r,
    Rect(var w, var h) => w * h,
    _ => throw new ArgumentException("unknown"),
};

string Kind(Shape s) => s switch
{
    Circle { Radius: 0 } => "点",
    Rect(var w, var h) when w == h => "正方形",
    Rect => "長方形",
    Circle => "円",
};

abstract record Shape;
record Circle(double Radius) : Shape;
record Rect(double Width, double Height) : Shape;

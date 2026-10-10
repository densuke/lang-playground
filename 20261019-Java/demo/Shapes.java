// record (Java 16) + sealed (Java 17) + switch のパターンマッチ (Java 21)。
sealed interface Shape permits Circle, Rect, Triangle {}
record Circle(double r) implements Shape {}
record Rect(double w, double h) implements Shape {}
record Triangle(double base, double height) implements Shape {}

// sealed なので全ケースを並べればよく、default は要らない。取りこぼすとコンパイルエラーになる。
double area(Shape shape) {
    return switch (shape) {
        case Circle(double r) -> Math.PI * r * r;
        case Rect(double w, double h) -> w * h;
        case Triangle(double b, double h) -> b * h / 2;
    };
}

void main() {
    var shapes = java.util.List.of(new Circle(1.5), new Rect(3, 4), new Triangle(6, 2));
    for (var shape : shapes) {
        IO.println(shape + " -> 面積 " + String.format("%.2f", area(shape)));
    }
}

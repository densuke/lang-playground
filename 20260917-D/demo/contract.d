import std.stdio;
import core.exception : AssertError;

// in は事前条件、out は事後条件。どちらも言語の構文
int divide(int a, int b)
in (b != 0, "b must not be 0")
out (r; r * b <= a)
{
    return a / b;
}

void main() {
    writeln("10 / 3 = ", divide(10, 3));
    try {
        writeln(divide(10, 0));
    } catch (AssertError e) {
        writeln("AssertError: ", e.msg);
    }
}

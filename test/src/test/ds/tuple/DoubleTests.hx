package test.ds.tuple;

import hxdf.ds.tuple.Double;

class DoubleTests extends TestCase {
    public function new() {
        var a = new Double(42, 37);
        assert(a.first == 42);
        assert(a.second == 37);

        var b = a.copy();
        assert(b.first == 42);
        assert(b.second == 37);

        var c = a.map((x) -> x + 1);
        assert(c.first == 43);
        assert(c.second == 38);

        assert(a.toString() == "{42,37}");
        assert(c.toString() == "{43,38}");

        assert(a.join("-") == "42-37");
        assert(c.join("-") == "43-38");

        var d = new Double("Hello", 42);
        assert(d.first == "Hello");
        assert(d.second == 42);

        assert(d.toString() == "{Hello,42}");
        assert(d.join(", ") == "Hello, 42");
    }
}

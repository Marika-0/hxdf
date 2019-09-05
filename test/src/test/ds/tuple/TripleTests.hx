package test.ds.tuple;

import hxdf.ds.tuple.Triple;

class TripleTests extends TestCase {
    public function new() {
        var a = new Triple(42, 37, 54);
        assert(a.first == 42);
        assert(a.second == 37);
        assert(a.third == 54);

        var b = a.copy();
        assert(b.first == 42);
        assert(b.second == 37);
        assert(b.third == 54);

        var c = a.map((x) -> x + 1);
        assert(c.first == 43);
        assert(c.second == 38);
        assert(c.third == 55);

        assert(a.toString() == "{42,37,54}");
        assert(c.toString() == "{43,38,55}");

        assert(a.join("-") == "42-37-54");
        assert(c.join("-") == "43-38-55");

        var d = new Triple("Hello", 42, true);
        assert(d.first == "Hello");
        assert(d.second == 42);
        assert(d.third == true);

        assert(d.toString() == "{Hello,42,true}");
        assert(d.join(", ") == "Hello, 42, true");
    }
}

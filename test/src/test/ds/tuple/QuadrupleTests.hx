package test.ds.tuple;

import hxdf.ds.tuple.Quadruple;

class QuadrupleTests extends TestCase {
    public function new() {
        var a = new Quadruple(42, 37, 54, 0);
        assert(a.first == 42);
        assert(a.second == 37);
        assert(a.third == 54);
        assert(a.fourth == 0);

        var b = a.copy();
        assert(b.first == 42);
        assert(b.second == 37);
        assert(b.third == 54);
        assert(b.fourth == 0);

        var c = a.map((x) -> x + 1);
        assert(c.first == 43);
        assert(c.second == 38);
        assert(c.third == 55);
        assert(c.fourth == 1);

        assert(a.toString() == "{42,37,54,0}");
        assert(c.toString() == "{43,38,55,1}");

        assert(a.join("-") == "42-37-54-0");
        assert(c.join("-") == "43-38-55-1");

        var d = new Quadruple("Hello", 42, true, 19.999);
        assert(d.first == "Hello");
        assert(d.second == 42);
        assert(d.third == true);
        assert(d.fourth == 19.999);

        assert(d.toString() == "{Hello,42,true,19.999}");
        assert(d.join(", ") == "Hello, 42, true, 19.999");
    }
}

package test.lambda.unit;

import hxdf.ds.unit.DoubleNode;
import hxdf.lambda.unit.BackwardsDoubleNodeIterator;

class BackwardsDoubleNodeIteratorTests extends TestCase {
    public function new() {
        var u = new BackwardsDoubleNodeIterator(null);
        assert(!u.hasNext());

        var e = new DoubleNode(42);
        var d = new DoubleNode(37, e);
        e.prev = d;
        var c = new DoubleNode(54, d);
        d.prev = c;
        var b = new DoubleNode(19, c);
        c.prev = b;
        var a = new DoubleNode(0, b);
        b.prev = a;

        u = new BackwardsDoubleNodeIterator(e);
        for (i in 0...5) {
            assert(u.hasNext());
            assert(u.next() == [0, 19, 54, 37, 42][4 - i]);
        }
        assert(!u.hasNext());
    }
}

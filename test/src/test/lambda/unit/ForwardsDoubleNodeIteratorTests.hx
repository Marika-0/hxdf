package test.lambda.unit;

import hxdf.ds.unit.DoubleNode;
import hxdf.lambda.unit.ForwardsDoubleNodeIterator;

class ForwardsDoubleNodeIteratorTests extends TestCase {
    public function new() {
        var u = new ForwardsDoubleNodeIterator(null);
        assert(!u.hasNext());

        var e = new DoubleNode(42);
        var d = new DoubleNode(37, e);
        var c = new DoubleNode(54, d);
        var b = new DoubleNode(19, c);
        var a = new DoubleNode(0, b);

        u = new ForwardsDoubleNodeIterator(a);
        for (i in 0...5) {
            assert(u.hasNext());
            assert(u.next() == [0, 19, 54, 37, 42][i]);
        }
        assert(!u.hasNext());
    }
}

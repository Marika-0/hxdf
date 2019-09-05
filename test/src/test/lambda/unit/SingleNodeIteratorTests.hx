package test.lambda.unit;

import hxdf.ds.unit.SingleNode;
import hxdf.lambda.unit.SingleNodeIterator;

class SingleNodeIteratorTests extends TestCase {
    public function new() {
        var u = new SingleNodeIterator(null);
        assert(!u.hasNext());

        var e = new SingleNode(42);
        var d = new SingleNode(37, e);
        var c = new SingleNode(54, d);
        var b = new SingleNode(19, c);
        var a = new SingleNode(0, b);

        u = new SingleNodeIterator(a);
        for (i in 0...5) {
            assert(u.hasNext());
            assert(u.next() == [0, 19, 54, 37, 42][i]);
        }
        assert(!u.hasNext());
    }
}

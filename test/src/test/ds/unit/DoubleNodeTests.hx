package test.ds.unit;

import hxdf.ds.unit.DoubleNode;

class DoubleNodeTests extends TestCase {
    public function new() {
        var a = new DoubleNode<Null<Int>>(null);
        assert(a.data == null);
        assert(a.next == null);
        assert(a.prev == null);

        a.data = 42;
        a.next = new DoubleNode<Int>(37, null, a);
        assert(a.data == 42);
        assert(a.next != null);
        assert(a.prev == null);
        assert(a.next.data == 37);
        assert(a.next.next == null);
        assert(a.next.prev == a);

        a.prev = new DoubleNode<Int>(58, a, null);
        assert(a.data == 42);
        assert(a.next != null);
        assert(a.prev != null);
        assert(a.next.data == 37);
        assert(a.next.next == null);
        assert(a.next.prev == a);
        assert(a.prev.data == 58);
        assert(a.prev.next == a);
        assert(a.prev.prev == null);
    }
}

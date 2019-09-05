package test.ds.unit;

import hxdf.ds.unit.SingleNode;

class SingleNodeTests extends TestCase {
    public function new() {
        var a = new SingleNode<Null<Int>>(null);
        assert(a.data == null);
        assert(a.next == null);

        a.data = 42;
        a.next = new SingleNode<Int>(37);
        assert(a.data == 42);
        assert(a.next != null);
        assert(a.next.data == 37);
        assert(a.next.next == null);
    }
}

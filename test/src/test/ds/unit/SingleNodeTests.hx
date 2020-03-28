package test.ds.unit;

import hxdf.ds.unit.SingleNode;

class SingleNodeTests extends hxtf.TestObject {
    public function new() {
        var node = new SingleNode(3);
        node = new SingleNode(2, node);
        node = new SingleNode(1, node);

        var head = node;
        assert(head.data == 1);
        assert(head.next != null);

        head = head.next;
        assert(head.data == 2);
        assert(head.next != null);

        head = head.next;
        assert(head.data == 3);
        assert(head.next == null);
    }
}

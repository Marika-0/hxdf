package test.ds.unit;

import hxdf.ds.unit.DoubleNode;

class DoubleNodeTests extends hxtf.TestObject {
    public function new() {
        var node = new DoubleNode(3);
        node = new DoubleNode(2, node);
        node.next.prev = node;
        node = new DoubleNode(1, node);
        node.next.prev = node;

        var head = node;
        assert(head.data == 1);
        assert(head.prev == null);
        assert(head.next != null);

        head = head.next;
        assert(head.data == 2);
        assert(head.prev != null);
        assert(head.next != null);

        head = head.next;
        assert(head.data == 3);
        assert(head.prev != null);
        assert(head.next == null);

        head = head.prev;
        assert(head.data == 2);
        assert(head.prev != null);
        assert(head.next != null);

        head = head.prev;
        assert(head.data == 1);
        assert(head.prev == null);
        assert(head.next != null);
    }
}

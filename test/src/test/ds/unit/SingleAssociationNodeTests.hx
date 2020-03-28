package test.ds.unit;

import hxdf.ds.unit.SingleAssociationNode;

class SingleAssociationNodeTests extends hxtf.TestObject {
    public function new() {
        var node = new SingleAssociationNode("World", 3);
        node = new SingleAssociationNode("Hello", 2, node);
        node = new SingleAssociationNode("My", 1, node);

        var head = node;
        assert(head.key == "My");
        assert(head.value == 1);
        assert(head.next != null);

        head = head.next;
        assert(head.key == "Hello");
        assert(head.value == 2);
        assert(head.next != null);

        head = head.next;
        assert(head.key == "World");
        assert(head.value == 3);
        assert(head.next == null);
    }
}

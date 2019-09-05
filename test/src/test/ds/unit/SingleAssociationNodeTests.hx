package test.ds.unit;

import hxdf.ds.unit.SingleAssociationNode;

class SingleAssociationNodeTests extends TestCase {
    public function new() {
        var a = new SingleAssociationNode<String, Int>("One", 1);
        assert(a.key == "One");
        assert(a.value == 1);
        assert(a.next == null);

        a.value = 0;
        a.next = new SingleAssociationNode<String, Int>("Two", 2);
        assert(a.value == 0);
        assert(a.next != null);
        assert(a.next.key == "Two");
        assert(a.next.value == 2);
        assert(a.next.next == null);
    }
}

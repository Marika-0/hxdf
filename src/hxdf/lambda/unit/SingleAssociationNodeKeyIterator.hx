package hxdf.lambda.unit;

import hxdf.ds.unit.SingleAssociationNode;

/**
    An iterator for the `hxdf.ds.unit.SingleAssociationNode` type, iterating
    over keys.
**/
class SingleAssociationNodeKeyIterator<K> {
    var node:SingleAssociationNode<K, Dynamic>;

    /**
        Create a new SingleAssociationNodeKeyIterator beginning iteration from
        an initial node `head`.
    **/
    public function new(head:SingleAssociationNode<K, Dynamic>) {
        node = head;
    }

    /**
        Tells if `this` SingleAssociationNodeKeyIterator has at least one more
        element to iterate on.
    **/
    public function hasNext():Bool {
        return node != null;
    }

    /**
        Accesses the current element of iteration and increments `this`
        SingleAssociationNodeKeyIterator.
    **/
    public function next():K {
        var data = node.key;
        node = node.next;
        return data;
    }
}

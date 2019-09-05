package hxdf.lambda.unit;

import hxdf.ds.unit.SingleAssociationNode;

/**
    An iterator for the `hxdf.ds.unit.SingleAssociationNode` type, iterating
    over values.
**/
class SingleAssociationNodeValueIterator<V> {
    var node:SingleAssociationNode<Dynamic, V>;

    /**
        Create a new SingleAssociationNodeValueIterator beginning iteration from
        an initial node `head`.
    **/
    public function new(head:SingleAssociationNode<Dynamic, V>) {
        node = head;
    }

    /**
        Tells if `this` SingleAssociationNodeValueIterator has at least one more
        element to iterate on.
    **/
    public function hasNext():Bool {
        return node != null;
    }

    /**
        Accesses the current element of iteration and increments `this`
        SingleAssociationNodeValueIterator.
    **/
    public function next():V {
        var data = node.value;
        node = node.next;
        return data;
    }
}

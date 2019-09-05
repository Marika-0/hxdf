package hxdf.lambda.unit;

import hxdf.ds.unit.SingleNode;

/**
    An iterator for the `hxdf.ds.unit.SingleNode` type.
**/
class SingleNodeIterator<T> {
    var node:SingleNode<T>;

    /**
        Creates a new SingleNodeIterator beginning iteration from an initial
        node `head`.
    **/
    public function new(head:SingleNode<T>) {
        node = head;
    }

    /**
        Tells if `this` SingleNodeIterator has at least one more element to
        iterate on.
    **/
    public function hasNext():Bool {
        return node != null;
    }

    /**
        Accesses the current element of iteration and increments `this`
        SingleNodeIterator.
    **/
    public function next():T {
        var data = node.data;
        node = node.next;
        return data;
    }
}

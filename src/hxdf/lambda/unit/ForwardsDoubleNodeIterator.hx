package hxdf.lambda.unit;

import hxdf.ds.unit.DoubleNode;

/**
    An iterator for the `hxdf.ds.unit.DoubleNode` that iterates forwards.
**/
class ForwardsDoubleNodeIterator<T> {
    var node:DoubleNode<T>;

    /**
        Creates a new ForwardsDoubleNodeIterator beginning iteration from some
        initial node `head`.
    **/
    public function new(head:DoubleNode<T>) {
        node = head;
    }

    /**
        Tells if `this` ForwardsDoubleNodeIterator has at least one more element
        to iterate on.
    **/
    public function hasNext():Bool {
        return node != null;
    }

    /**
        Accesses the current element of iteration and increments `this`
        ForwardsDoubleNodeIterator.
    **/
    public function next():T {
        var data = node.data;
        node = node.next;
        return data;
    }
}

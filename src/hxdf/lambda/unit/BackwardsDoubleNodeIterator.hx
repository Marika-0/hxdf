package hxdf.lambda.unit;

import hxdf.ds.unit.DoubleNode;

/**
    An iterator for the `hxdf.ds.unit.DoubleNode` that iterates backwards.
**/
class BackwardsDoubleNodeIterator<T> {
    var node:DoubleNode<T>;

    /**
        Creates a new BackwardsDoubleNodeIterator beginning iteration from some
        initial node `head`.
    **/
    public function new(tail:DoubleNode<T>) {
        node = tail;
    }

    /**
        Tells if `this` BackwardsDoubleNodeIterator has at least one more
        element to iterate on.
    **/
    public function hasNext():Bool {
        return node != null;
    }

    /**
        Accesses the current element of iteration and increments `this`
        BackwardsDoubleNodeIterator.
    **/
    public function next():T {
        var data = node.data;
        node = node.prev;
        return data;
    }
}

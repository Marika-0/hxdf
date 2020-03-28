package hxdf.ds.unit;

/**
    A node containing some data and references to next and previous nodes.
**/
class DoubleNode<T> {
    /**
        The data stored in `this` DoubleNode.
    **/
    public var data:T;

    /**
        The next node referenced by `this` DoubleNode.
    **/
    public var next:DoubleNode<T>;

    /**
        The previous node referenced by `this` DoubleNode.
    **/
    public var prev:DoubleNode<T>;

    /**
        Creates a new DoubleNode with data `data`, and optional references to
        next and previous DoubleNodes.
    **/
    public inline function new(data:T, ?next:DoubleNode<T>, ?prev:DoubleNode<T>) {
        this.data = data;
        this.next = next;
        this.prev = prev;
    }
}

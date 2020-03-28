package hxdf.ds.unit;

/**
    A node containing some data and a reference to another node.
**/
class SingleNode<T> {
    /**
        The data stored in `this` SingleNode.
    **/
    public var data:T;

    /**
        The node referenced by `this` SingleNode.
    **/
    public var next:SingleNode<T>;

    /**
        Creates a new SingleNode with data `data`, and an optional reference to
        another SingleNode.
    **/
    public inline function new(data:T, ?next:SingleNode<T>) {
        this.data = data;
        this.next = next;
    }
}

package hxdf.ds.unit;

/**
    A node containing a key/value pair and a reference to another node.
**/
class SingleAssociationNode<K, V> {
    /**
        The key of `this` SingleAssociationNode.
    **/
    public var key:K;

    /**
        The value of `this` SingleAssociationNode.
    **/
    public var value:V;

    /**
        The node referenced by `this` SingleAssociationNode.
    **/
    public var next:SingleAssociationNode<K, V>;

    /**
        Creates a new SingleAssociationNode with key `key` and value `value`,
        and an optional reference to another SingleAssociationNode.
    **/
    public inline function new(key:K, value:V, ?next:SingleAssociationNode<K, V>) {
        this.key = key;
        this.value = value;
        this.next = next;
    }
}

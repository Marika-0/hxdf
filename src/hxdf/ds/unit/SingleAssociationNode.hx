package hxdf.ds.unit;

import hxdf.ds.unit.KeyValuePair;

/**
    A node containing a key/value pair and a reference to another node.
**/
class SingleAssociationNode<K, V> {
    /**
        The key of `this` SingleAssociationNode.
    **/
    public var key(get, set):K;

    inline function get_key():K {
        return pair.key;
    }

    inline function set_key(key:K):K {
        return pair.key = key;
    }

    /**
        The value of `this` SingleAssociationNode.
    **/
    public var value(get, set):V;

    inline function get_value():V {
        return pair.value;
    }

    inline function set_value(value:V):V {
        return pair.value = value;
    }

    /**
        The key/value pair of `this` SingleAssociationNode.
    **/
    public var pair:KeyValuePair<K, V>;

    /**
        The node referenced by `this` SingleAssociationNode.
    **/
    public var next:SingleAssociationNode<K, V>;

    /**
        Creates a new SingleAssociationNode with key `key` and value `value`,
        and an optional reference to another SingleAssociationNode.
    **/
    public inline function new(key:K, value:V, ?next:SingleAssociationNode<K, V>) {
        pair = new KeyValuePair<K, V>(key, value);
        this.next = next;
    }
}

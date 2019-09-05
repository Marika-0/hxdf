package hxdf.ds.unit;

import hxdf.ds.tuple.Double;

/**
    A node containing a key/value pair and a reference to another node.
**/
abstract SingleAssociationNode<K, V>(Double<KeyValuePair<K, V>, SingleAssociationNode<K, V>>) {
    /**
        The key of `this` SingleAssociationNode.
    **/
    public var key(get, never):K;

    inline function get_key():K {
        return this.first.key;
    }

    /**
        The value of `this` SingleAssociationNode.
    **/
    public var value(get, set):V;

    inline function get_value():V {
        return this.first.value;
    }

    inline function set_value(v:V):V {
        return this.first.value = v;
    }

    /**
        The node referenced by `this` SingleAssociationNode.
    **/
    public var next(get, set):SingleAssociationNode<K, V>;

    inline function get_next():SingleAssociationNode<K, V> {
        return this.second;
    }

    inline function set_next(x:SingleAssociationNode<K, V>):SingleAssociationNode<K, V> {
        return this.second = x;
    }

    /**
        Creates a new SingleAssociationNode with given key and value, and
        optional reference to another SingleAssociationNode.
    **/
    public inline function new(key:K, value:V, ?next:SingleAssociationNode<K, V>) {
        this = new Double(KeyValuePair.KVPFactory.create(key, value), next);
    }
}

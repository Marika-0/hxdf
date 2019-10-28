package hxdf.ds.unit;

import hxdf.ds.tuple.Double;

/**
    A node containing a key/value pair and a reference to another node.
**/
class SingleAssociationNode<K, V> {
    var _data:Double<KeyValuePair<K, V>, SingleAssociationNode<K, V>>;

    /**
        The key of `this` SingleAssociationNode.
    **/
    public var key(get, never):K;

    inline function get_key():K {
        return _data.first.key;
    }

    /**
        The value of `this` SingleAssociationNode.
    **/
    public var value(get, set):V;

    inline function get_value():V {
        return _data.first.value;
    }

    inline function set_value(v:V):V {
        return _data.first.value = v;
    }

    /**
        The node referenced by `this` SingleAssociationNode.
    **/
    public var next(get, set):SingleAssociationNode<K, V>;

    inline function get_next():SingleAssociationNode<K, V> {
        return _data.second;
    }

    inline function set_next(x:SingleAssociationNode<K, V>):SingleAssociationNode<K, V> {
        return _data.second = x;
    }

    /**
        Creates a new SingleAssociationNode with given key and value, and
        optional reference to another SingleAssociationNode.
    **/
    public inline function new(key:K, value:V, ?next:SingleAssociationNode<K, V>) {
        _data = new Double(KeyValuePair.KVPFactory.create(key, value), next);
    }
}

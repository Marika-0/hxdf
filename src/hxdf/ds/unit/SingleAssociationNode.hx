package hxdf.ds.unit;

import hxdf.ds.unit.KeyValuePair;

/**
    A node containing a key/value pair and a reference to another node.
**/
abstract SingleAssociationNode<K, V>(SingleNode<KeyValuePair<K, V>>) from SingleNode<KeyValuePair<K, V>> to SingleNode<KeyValuePair<K, V>>
{
    /**
        The key of `this` SingleAssociationNode.
    **/
    public var key(get, set):K;

    inline function get_key():K {
        return this.data.key;
    }

    inline function set_key(key:K):K {
        return this.data.key = key;
    }

    /**
        The value of `this` SingleAssociationNode.
    **/
    public var value(get, set):V;

    inline function get_value():V {
        return this.data.value;
    }

    inline function set_value(value:V):V {
        return this.data.value = value;
    }

    /**
        The key/value pair of `this` SingleAssociationNode.
    **/
    public var pair(get, set):KeyValuePair<K, V>;

    inline function get_pair():KeyValuePair<K, V>
    {
        return this.data;
    }

    inline function set_pair(pair:KeyValuePair<K, V>):KeyValuePair<K, V>
    {
        this.data.key = pair.key;
        this.data.value = pair.value;
        return this.data;
    }

    /**
        The node referenced by `this` SingleAssociationNode.
    **/
    public var next(get, set):SingleAssociationNode<K, V>;

    inline function get_next():SingleAssociationNode<K, V>
    {
        return this.next;
    }

    inline function set_next(next:SingleAssociationNode<K, V>):SingleAssociationNode<K, V>
    {
        return this.next = next;
    }

    /**
        Creates a new SingleAssociationNode.
    **/
    public function new(key:K, value:V, ?next:SingleAssociationNode<K, V>)
    {
        this = new SingleNode(new KeyValuePair(key, value), next);
    }
}

package hxdf.ds.unit;

import hxdf.ds.tuple.Triple;

/**
    A node containing some data and a reference to two other nodes.
**/
class DoubleNode<T> {
    /**
        The data stored in `this` SingleNode.
    **/
    public var data(get, set):T;

    inline function get_data():T {
        return triple.first;
    }

    inline function set_data(x:T):T {
        return triple.first = x;
    }

    /**
        The next node referenced by `this` DoubleNode.
    **/
    public var next(get, set):DoubleNode<T>;

    inline function get_next():DoubleNode<T> {
        return triple.second;
    }

    inline function set_next(x:DoubleNode<T>):DoubleNode<T> {
        return triple.second = x;
    }

    /**
        The previous node referenced by `this` DoubleNode.
    **/
    public var prev(get, set):DoubleNode<T>;

    inline function get_prev():DoubleNode<T> {
        return triple.third;
    }

    inline function set_prev(x:DoubleNode<T>):DoubleNode<T> {
        return triple.third = x;
    }

    var triple:Triple<T, DoubleNode<T>, DoubleNode<T>>;

    /**
        Creates a new DoubleNode with given data and optional references to two
        other DoubleNodes.
    **/
    public inline function new(data:T, ?next:DoubleNode<T>, ?prev:DoubleNode<T>) {
        triple = new Triple(data, next, prev);
    }
}

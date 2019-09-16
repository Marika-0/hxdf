package hxdf.ds.unit;

import hxdf.ds.tuple.Triple;

/**
    A node containing some data and a reference to two other nodes.
**/
class DoubleNode<T> {
    var _data:Triple<T, DoubleNode<T>, DoubleNode<T>>;

    /**
        The data stored in `this` SingleNode.
    **/
    public var data(get, set):T;

    inline function get_data():T {
        return _data.first;
    }

    inline function set_data(x:T):T {
        return _data.first = x;
    }

    /**
        The next node referenced by `this` DoubleNode.
    **/
    public var next(get, set):DoubleNode<T>;

    inline function get_next():DoubleNode<T> {
        return _data.second;
    }

    inline function set_next(x:DoubleNode<T>):DoubleNode<T> {
        return _data.second = x;
    }

    /**
        The previous node referenced by `this` DoubleNode.
    **/
    public var prev(get, set):DoubleNode<T>;

    inline function get_prev():DoubleNode<T> {
        return _data.third;
    }

    inline function set_prev(x:DoubleNode<T>):DoubleNode<T> {
        return _data.third = x;
    }

    /**
        Creates a new DoubleNode with given data and optional references to two
        other DoubleNodes.
    **/
    public inline function new(data:T, ?next:DoubleNode<T>, ?prev:DoubleNode<T>) {
        _data = new Triple(data, next, prev);
    }
}

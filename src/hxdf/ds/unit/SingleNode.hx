package hxdf.ds.unit;

import hxdf.ds.tuple.Double;

/**
    A node containing some data and a reference to another node.
**/
class SingleNode<T> {
    var _data:Double<T, SingleNode<T>>;

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
        The node referenced by `this` SingleNode.
    **/
    public var next(get, set):SingleNode<T>;

    inline function get_next():SingleNode<T> {
        return _data.second;
    }

    inline function set_next(x:SingleNode<T>):SingleNode<T> {
        return _data.second = x;
    }

    /**
        Creates a new SingleNode with given data and optional reference to
        another SingleNode.
    **/
    public inline function new(data:T, ?next:SingleNode<T>) {
        _data = new Double(data, next);
    }
}

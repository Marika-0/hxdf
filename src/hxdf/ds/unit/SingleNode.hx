package hxdf.ds.unit;

import hxdf.ds.tuple.Double;

/**
    A node containing some data and a reference to another node.
**/
class SingleNode<T> {
    /**
        The data stored in `this` SingleNode.
    **/
    public var data(get, set):T;

    inline function get_data():T {
        return double.first;
    }

    inline function set_data(x:T):T {
        return double.first = x;
    }

    /**
        The node referenced by `this` SingleNode.
    **/
    public var next(get, set):SingleNode<T>;

    inline function get_next():SingleNode<T> {
        return double.second;
    }

    inline function set_next(x:SingleNode<T>):SingleNode<T> {
        return double.second = x;
    }

    var double:Double<T, SingleNode<T>>;

    /**
        Creates a new SingleNode with given data and optional reference to
        another SingleNode.
    **/
    public inline function new(data:T, ?next:SingleNode<T>) {
        double = new Double(data, next);
    }
}

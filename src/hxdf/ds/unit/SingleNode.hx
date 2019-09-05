package hxdf.ds.unit;

import hxdf.ds.tuple.Double;

/**
    A node containing some data and a reference to another node.
**/
abstract SingleNode<T>(Double<T, SingleNode<T>>) {
    /**
        The data stored in `this` SingleNode.
    **/
    public var data(get, set):T;

    inline function get_data():T {
        return this.first;
    }

    inline function set_data(x:T):T {
        return this.first = x;
    }

    /**
        The node referenced by `this` SingleNode.
    **/
    public var next(get, set):SingleNode<T>;

    inline function get_next():SingleNode<T> {
        return this.second;
    }

    inline function set_next(x:SingleNode<T>):SingleNode<T> {
        return this.second = x;
    }

    /**
        Creates a new SingleNode with given data and optional reference to
        another SingleNode.
    **/
    public inline function new(data:T, ?next:SingleNode<T>) {
        this = new Double(data, next);
    }
}

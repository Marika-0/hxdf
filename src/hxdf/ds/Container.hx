package hxdf.ds;

import hxdf.ds.unit.KeyValuePair;

/**
    A storage for data.
**/
interface Container<T> {
    /**
        The number of items in the Container.
    **/
    var length(default, null):Int;

    /**
        Tells if the Container is empty.
    **/
    function isEmpty():Bool;

    /**
        Clears all elements from the Container.
    **/
    function clear():Void;

    /**
        Returns a copy of the Container.

        The return type parameter is typed as `Dynamic` to prevent compiler
        errors for the `copy` field of composite containers.
    **/
    function copy():Container<Dynamic>;

    /**
        Converts the Container into a string representation.
    **/
    function toString():String;
}

/**
    A sequential data storage type.
**/
interface SequentialContainer<T> extends Container<T> {
    /**
        Adds `item` to the growth-end of the SequentialContainer.
    **/
    function push(item:T):T;

    /**
        Removes the furthermost item at the growth-end of the
        SequentialContainer and returns it.

        See implementations for behavior when the SequentialContainer is empty.
    **/
    function pop():Null<T>;

    /**
        Returns the first item (the furthermost item at the growth-end) of the
        SequentialContainer.
    **/
    function first():Null<T>;

    /**
        Converts the SequentialContainer into a string where each element is
        separated by `sep`.
    **/
    function join(sep:String):String;
}

/**
    A container that can be iterated over, filtered, and mapped.
**/
interface TraversableContainer<T> extends Container<T> {
    /**
        Returns an iterator over the elements of the TraversableContainer.
    **/
    function iterator():Iterator<T>;

    /**
        Returns a new TraversableContainer filtered with function `f`.

        If `f` is null, the result is unspecified.
    **/
    function filter(f:T->Bool):TraversableContainer<T>;

    /**
        Returns a new TraversableContainer mapped with function `f`.

        If `f` is null, the result is unspecified.
    **/
    function map<S>(f:T->S):TraversableContainer<S>;
}

/**
    A sequential data storage type that can add to or remove elements from
    either end.
**/
interface BilateralContainer<T> extends SequentialContainer<T> {
    /**
        Adds `item` to the secondary growth-end of the BilateralContainer.
    **/
    function unshift(item:T):T;

    /**
        Removes the furthermost item at the secondary growth-end of the
        BilateralContainer and returns it.

        See implementations for behavior when the BilateralContainer is empty.
    **/
    function shift():Null<T>;

    /**
        Returns the last item (the furthermost item at the secondary growth-end)
        of the BilateralContainer.
    **/
    function last():Null<T>;
}

/**
    A sequential data storage type supporting reading and writing values at
    arbitrary positions.
**/
interface RandomAccessContainer<T> extends BilateralContainer<T> extends TraversableContainer<T> {
    /**
        Sets the value at index `index` to `value` and returns it.

        If `index` is negative or not less than the length of the
        RandomAccessContainer, the result is unspecified.
    **/
    function set(index:Int, value:T):T;

    /**
        Returns the value stored at index `index`.

        If `index` is negative or not less than the length of the
        RandomAccessContainer, the result is unspecified.
    **/
    function get(index:Int):T;

    /**
        Removes the first occurrence of `v` in the RandomAccessContainer.

        If `comp` is specified, item `item` is removed if `comp(v, item)`
        returns true. Otherwise, standard equity is used.
    **/
    function remove(v:T, ?comp:T->T->Bool):Bool;
}

/**
    A potentially non-sequential unique element data storage type.
**/
interface SpaceContainer<T> extends Container<T> {
    /**
        Returns the number of elements in the SpaceContainer.
    **/
    function size():Int;

    /**
        Removes the given element `item` from the SpaceContainer and returns
        `true` if it existed.

        If `item` does not exist in the SpaceContainer, returns `false`.
    **/
    function delete(item:T):Bool;

    /**
        Tells if element `item` exists in the SpaceContainer.
    **/
    function exists(item:T):Bool;

    /**
        Internal comparison function for evaluating the equity of elements.
    **/
    private function compare<S>(a:S, b:S):Bool;
}

/**
    An arbitrary SpaceContainer.
**/
interface SetContainer<T> extends SpaceContainer<T> {
    /**
        Adds the given element `item` to the SetContainer if it does not already
        exist.
    **/
    function add(item:T):T;

    /**
        Removes the given element `item` from the SetContainer and returns it.

        If `item` does not exist in the SetContainer, returns `null`.
    **/
    function remove(item:T):Null<T>;
}

/**
    A container that maps keys to values.
**/
interface AssociativeContainer<K, V> extends SpaceContainer<K> extends TraversableContainer<V> {
    /**
        Binds `key` to `value` and return `value`.

        If `key` is already bound to a value, that binding is overridden.

        If `key` is null, the result is unspecified.
    **/
    function set(key:K, value:V):V;

    /**
        Returns the binding of `key`.

        Returns `null` if `key` is not bound to a value.

        If `key` is null, the result is unspecified.
    **/
    function get(key:K):Null<V>;

    /**
        Removes the given item `item` from the SpaceContainer and returns it.

        If `item` does not exist in the SpaceContainer, returns `null`.
    **/
    function remove(key:K):Null<V>;

    /**
        Returns an iterator over the keys of the AssociativeContainer.
    **/
    function keys():Iterator<K>;

    /**
        Returns an iterator over the key/value pairs of AssociativeContainer.
    **/
    function keyValueIterator():Iterator<KeyValuePair<K, V>>;

    /**
        Returns a new AssociativeContainer filtered with function `f`.

        The returned AssociativeContainer will contain all key/value bindings
        for which `f(key)` returns `true`.

        If `f` is null, the result is unspecified.
    **/
    function filterKeys(f:K->Bool):AssociativeContainer<K, V>;

    /**
        Returns a new AssociativeContainer filtered with function `f`.

        The returned AssociativeContainer will contain all key/value bindings
        for which `f({key:K, value:V})` returns `true`.

        If `f` is null, the result is unspecified.
    **/
    function filterPairs(f:KeyValuePair<K, V>->Bool):AssociativeContainer<K, V>;

    /**
        Returns a new AssociativeContainer mapped with function `f`.

        The returned AssociativeContainer will retain all its original values
        with the key to each value being set to `f(key)`.

        if `f` is null, the result is unspecified.
    **/
    function mapKeys<X>(f:K->X):AssociativeContainer<X, V>;

    /**
        Returns a new AssociativeContainer mapped with function `f`.

        The returned AssociativeContainer will contain the output of `f(pair)`
        on each key/value pair of the AssociativeContainer. Where `pair` is of
        the type `hxdf.lambda.KeyValuePair`.

        if `f` is null, the result is unspecified.
    **/
    function mapPairs<X, Y>(f:KeyValuePair<K, V>->KeyValuePair<X, Y>):AssociativeContainer<X, Y>;
}

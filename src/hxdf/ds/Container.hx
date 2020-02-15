package hxdf.ds;

import hxdf.ds.unit.KeyValuePair;
import hxdf.lambda.Iterator;

/**
    A data storage type.
**/
interface Container<T> {
    /**
        The number of elements in the Container.
    **/
    var length(default, null):Int;

    /**
        Tests if the Container contains any elements.

        Returns `true` if the Container is empty, otherwise returns `false`.
    **/
    function isEmpty():Bool;

    /**
        Removes all elements from the Container.
    **/
    function clear():Void;

    /**
        Returns a copy of the Container.
    **/
    function copy():Container<T>;

    /**
        Converts the Container into a string representation.

        Containers of a sequential list of elements will have the elements in
        order separated by `","` and contained in square brackets (`"["`/`"]"`).

        Containers of a non-sequential grouping of elements will have each
        element separated by `","` and contained in braces (`"{"`/`"]}`).

        Containers of key-value pairs will formay key/values as `key=>value`
        and will have each pair separated by `","`. The pairs may or may not be
        in a particular order depending on the datastructure and will always be
        contained in braces (`"{"`/`"]}`).
    **/
    function toString():String;
}

/**
    A sequential data storage container.
**/
interface SequentialContainer<T> extends Container<T> {
    /**
        Adds `item` to the SequentialContainer.
    **/
    function push(item:T):Void;

    /**
        Removes the first element from the "push-end" of the SequentialContainer
        and returns it.

        If the SequentialContainer is empty, returns null.
    **/
    function pop():Null<T>;

    /**
        Returns the first element from the "push-end" of the SequentialContainer
        without removing it.

        If the SequentialContainer is empty, returns null.
    **/
    function peek():Null<T>;

    /**
        Converts the SequentialContainer into a string representation where each
        element is separated by `sep`.

        If the SequentialContainer is empty, returns an empty string.
    **/
    function join(sep:String):String;
}

/**
    A container that can be iterated over and transformed.
**/
interface WalkableContainer<T> extends Container<T> {
    /**
        Returns a UnidirectionalIterator over the elements of the
        WalkableContainer.
    **/
    function iterator():UnidirectionalIterator<T>;

    /**
        Returns a copy of the WalkableContainer filtered with function `f`.

        The returned WalkableContainer contains each element `item` of the
        WalkableContainer where `f(item)` returns `true`.

        If the WalkableContainer stores it's elements sequentially, the order of
        elements is preserved.

        If `f` is null, the result may be unspecified.
    **/
    function filter(f:(T) -> Bool):WalkableContainer<T>;

    /**
        Returns a copy of the WalkableContainer mapped with function `f`.

        The returned WalkableContainer contains the transformation `f(item)` of
        each element `item` of the WalkableContainer

        If the WalkableContainer stores it's elements sequentially, the order of
        elements is preserved.

        If `f` is null, the result may be unspecified.
    **/
    function map<S>(f:(T) -> S):WalkableContainer<S>;
}

/**
    An aggregative container of elements.
**/
interface SpaceContainer<T> extends Container<T> {
    /**
        Returns the number of elements in the SpaceContainer (equivalent to
        `length`).
    **/
    function size():Int;

    /**
        Tells if `val` exists in the SpaceContainer.
    **/
    function exists(val:T):Bool;

    /**
        Removes `val` from the SpaceContainer.

        Returns `true` if an element was deleted, or `false` otherwise.
    **/
    function delete(val:T):Bool;
}

/**
    A sequential container that can add to or remove elements from either of two
    ends.
**/
interface BilateralContainer<T> extends SequentialContainer<T> {
    /**
        Adds `item` to opposite end of the BilateralContainer than
        SequentialContainer's `push` function.
    **/
    function unshift(item:T):Void;

    /**
        Removes the first element from the "unshift-end" of the
        BilateralContainer and returns it.

        If the BilateralContainer is empty, returns null.
    **/
    function shift():Null<T>;

    /**
        Returns the first element from the "unshift-end" of the
        BilateralContainer without removing it.

        If the BilateralContainer is empty, returns null.
    **/
    function spy():Null<T>;
}

/**
    A sequential container that can be iterated over through various means,
    filtered, transformed, and remove individual elements.
**/
interface ExtractableContainer<T> extends SequentialContainer<T> extends WalkableContainer<T> {
    /**
        Returns a key-value iterator over the indexes-elements of the
        ExtractableContainer.

        Equivalent to `keyValueIterator()`, just renamed to make more sense
        since it works specifically with indexes.
    **/
    function indexIterator():IndexIterator<T>;

    /**
        Returns a key-value iterator over the indexes-elements of the
        ExtractableContainer.

        Allows use of the ExtractableContainer in key-value iteration loops.
    **/
    function keyValueIterator():IndexIterator<T>;

    /**
        Removes the first element `item` from the ExtractableContainer for which
        `comp(val, item)` returns `true`.

        If `comp` is null, standard equity is used.

        Returns `true` if an element was removed, or `false` otherwise.
    **/
    function remove(val:T, ?comp:(T, T) -> Bool):Bool;
}

/**
    A container that can be arbitrarily iterated over from two distinct ends.
**/
interface TraversableContainer<T> extends WalkableContainer<T> {
    /**
        Returns a UnidirectionalIterator over the TraversableContainer
        (iterating in reverse to `iterator()`).
    **/
    function reverseIterator():UnidirectionalIterator<T>;

    /**
        Returns a BidirectionalIterator over the TraversableContainer.
    **/
    function beginIterator():BidirectionalIterator<T>;

    /**
        Returns a BidirectionalIterator over the TraversableContainer
        (iterating in reverse to `beginIterator()`).
    **/
    function endIterator():BidirectionalIterator<T>;
}

/**
    A container consisting of keys mapped to associated values.

    The methods inherited from WalkableContainer operate on the values of the
    AssociativeContainer. AssociativeContainer provides methods for walking over
    keys and key-value pairs.
**/
interface AssociativeContainer<K, V> extends WalkableContainer<V> extends SpaceContainer<K> {
    /**
        Maps `key` to `value` in the AssociativeContainer.

        If `key` is already mapped to a value, the previous value is
        overwritten.

        If `key` is null the result may be unspecified.
    **/
    function set(key:K, value:V):Void;

    /**
        Returns the mapped value of `key` in the AssociativeContainer.

        If `key` is not mapped to a value, returns null.

        If `key` is null the result may be unspecified.
    **/
    function get(key:K):Null<V>;

    /**
        Removes the the mapping of `key` from the AssociativeContainer and
        returns it's corresponding value.

        If `key` is not mapped to a value, returns null.

        If `key` is null the result may be unspecified.
    **/
    function remove(key:K):Null<V>;

    /**
        Returns a UnidirectionalIterator over the keys of the
        AssociativeContainer.
    **/
    function keyIterator():UnidirectionalIterator<K>;

    /**
        Returns a UnidirectionalIterator over the key/value pairs of the
        AssociativeContainer.
    **/
    function keyValueIterator():KeyValueIterator<K, V>;

    /**
        Returns a new AssociativeContainer filtered with function `f`.

        The returned AssociativeContainer will contain all key/value bindings
        for which `f(key)` returns `true`.

        If `f` is null, the result may be unspecified.
    **/
    function filterKeys(f:(K) -> Bool):AssociativeContainer<K, V>;

    /**
        Returns a new AssociativeContainer filtered with function `f`.

        The returned AssociativeContainer will contain all key/value bindings
        for which `f({key:K, value:V})` returns `true`.

        If `f` is null, the result may be unspecified.
    **/
    function filterPairs(f:(KeyValuePair<K, V>) -> Bool):AssociativeContainer<K, V>;

    /**
        Returns a new AssociativeContainer mapped with function `f`.

        The returned AssociativeContainer will retain all its original values
        with the key to each value being set to `f(key)`.

        If `f` is null, the result may be unspecified.
    **/
    function mapKeys<S>(f:(K) -> S):AssociativeContainer<S, V>;

    /**
        Returns a new AssociativeContainer mapped with function `f`.

        The returned AssociativeContainer will contain the output of `f(pair)`
        on each key/value pair of the AssociativeContainer. Where `pair` is of
        the type `hxdf.lambda.KeyValuePair`.

        if `f` is null, the result may be unspecified.
    **/
    function mapPairs<X, Y>(f:(KeyValuePair<K, V>) -> KeyValuePair<X, Y>):AssociativeContainer<X, Y>;
}

/**
    An aggregative container of unique elements.
**/
interface SetContainer<T> extends WalkableContainer<T> extends SpaceContainer<T> {
    /**
        Adds the given element `item` to the SetContainer if it does not already
        exist.
    **/
    function add(val:T):Void;
}

/**
    A sequential container supporting reading and writing of values at arbitrary
    positions and arbitrary traversion.
**/
interface RandomAccessContainer<T> extends BilateralContainer<T> extends ExtractableContainer<T> extends TraversableContainer<T> {
    /**
        Sets the value at position `index` to `value` and returns it.

        If `index` is negative or not less than the length of the
        RandomAccessContainer, the result may be unspecified.
    **/
    function get(index:Int):T;

    /**
        Returns the value stored at position `index`.

        If `index` is not in the range `[0, length)`, the result may be
        unspecified.
    **/
    function set(index:Int, value:T):Void;
}

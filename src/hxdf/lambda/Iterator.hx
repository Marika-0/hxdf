package hxdf.lambda;

import hxdf.ds.unit.KeyValuePair;

/**
    Typedef of `InputIterator<T>`.
**/
typedef Iterator<T> = InputIterator<T>;

/**
    An iterator that can retrieve data and be copied.
**/
interface InputIterator<T> {
    /**
        Tells if the InputIterator can retrieve another value.
    **/
    function hasNext():Bool;

    /**
        Increments the InputIterator and returns the value being iterated over.
    **/
    function next():T;

    /**
        Creates a copy of the InputIterator with the same focus and returns it.

        Copies of certain InputIterators (eg when reading a file) may be
        redundant. In this case, the function is a no-op.
    **/
    function copy():InputIterator<T>;
}

/**
    An iterator that can recall the value returned by `next` arbitrarily.
**/
interface ExtractableIterator<T> {
    /**
        Returns the current value being iterated over (the value returned by
        `next()`) without incrementing iteration.

        If `next()` has not yet been called, returns the value that the first
        call to `next()` will return.
    **/
    function value():T;
}

/**
    An iterator that operates over a defined sequence of elements.
**/
interface SequentialIterator<T> {
    /**
        Advances the SequentialIterator `steps` units and returns the last value
        iterated over.

        If `steps` is greater than the remaining number of elements available to
        iterator over or is negative, the result may be unspecified. See
        specific implementations for details.
    **/
    function advance(steps:Int):T;

    /**
        Tests the equity of the SequentialIterator with `it`.

        If the SequentialIterator and `it` are not of the same type, or not
        iterating over the same object, the result is unspecified.
    **/
    function equals(it:SequentialIterator<T>):Bool;
}

/**
    An iterator over pairs of keys and their corresponding values.
**/
interface KeyValueIterator<K, V> extends InputIterator<KeyValuePair<K, V>> {
    /**
        Returns the current key being iterated over.

        If `next()` has not yet been called, returns the value that the first
        call to `next().key` will return.
    **/
    function key():K;

    /**
        Returns the current value being iterated over.

        If `next()` has not yet been called, returns the value that the first
        call to `next().value` will return.
    **/
    function value():V;

    /**
        Returns the current key-value pair being iterated over (the value
        returned by `next`) without incrementing the KeyValueIterator.

        If `next()` has not yet been called, returns the value that the first
        call to `next()` will return.
    **/
    function pair():KeyValuePair<K, V>;
}

/**
    An iterator that can be advanced an arbitrary number of steps, arbitrarily
    retrieve iterated values, and undergo equity comparison.
**/
interface UnidirectionalIterator<T> extends ExtractableIterator<T> extends SequentialIterator<T> {}

/**
    An iterator over key-value pairs of indexes and values of a defined sequence
    of elements.
**/
interface IndexIterator<T> extends SequentialIterator<KeyValuePair<Int, T>> extends KeyValueIterator<Int, T> {
    /**
        The current position of the IndexIterator.

        Equivalent to a call to `key()`.
    **/
    function position():Int;
}

/**
    An iterator that can be advanced or retreated an arbitrary number of steps.
**/
interface BidirectionalIterator<T> extends UnidirectionalIterator<T> {
    /**
        Tells if the BidirectionalIterator can be decremented.
    **/
    function hasPrev():Bool;

    /**
        Decrements the BidirectionalIterator and returns the value being
        iterated over.
    **/
    function prev():T;

    /**
        Retreats the BidirectionalIterator `steps` units and returns the last
        value iterated over.

        If `steps` is greater than the preceding number of elements available to
        iterator over or is negative, the result may be unspecified. See
        specific implementations for details.
    **/
    function retreat(steps:Int):T;
}

/**
    An iterator that can be set to and retrieve values from arbitrary positions.
**/
interface RandomAccessIterator<T> extends BidirectionalIterator<T> {
    /**
        The current position of the RandomAccessIterator.
    **/
    function position():Int;

    /**
        Sets the RandomAccessIterator to `position`.

        If `position` is outside the bounds of iteration, the result may be
        unspecified. See specific implementations for details.
    **/
    function setToPosition(index:Int):T;

    /**
        Returns the value `offset` units from the RandomAccessIterators current
        position.

        If the offset puts value retrieval outside the bounds of iteration, the
        result is unspecified.
    **/
    function getOffset(offset:Int):T;

    /**
        Compares the RandomAccessIterator with another RandomAccessIterator
        `it`.

        If the RandomAccessIterator is before `it`, the result is negative. If
        `it` is before the RandomAccessIterator the result is position. If the
        RandomAccessIterator and `it` are in the same position, the result is 0.

        If the RandomAccessIterator and `it` are not of the same type, or not
        iterating over the same object, the result is unspecified.
    **/
    function compare(it:RandomAccessIterator<T>):Int;
}

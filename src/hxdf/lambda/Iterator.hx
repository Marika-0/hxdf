package hxdf.lambda;

import hxdf.ds.unit.KeyValuePair;

/**
    Alias for `InputIterator<T>`.
**/
typedef Iterator<T> = InputIterator<T>;

/**
    An iterator operating on a series of elements.
**/
interface InputIterator<T> {
    /**
        Returns `true` if the iterator can be advanced or `false` otherwise.

        This function is not required to be called before a call to `next()`.
    **/
    function hasNext():Bool;

    /**
        Returns the current value of the iterator and advances to the next one.

        If this function is called while `hasNext()` returns `false`, the result
        may be unspecified.
    **/
    function next():T;

    /**
        Creates a copy of the InputIterator over the same iterable and at the
        same position.
    **/
    function copy():InputIterator<T>;
}

/**
    An iterator operating over a defined sequence of elements.
**/
interface SequentialIterator<T> extends InputIterator<T> {
    /**
        Tests the equity of the SequentialIterator with `it`, returning `true`
        if the SequentialIterator and `it` are at the same position of
        iteration or `false` otherwise.

        If the SequentialIterator and `it` are not of the same type, or not
        iterating over the same object, the result is unspecified.
    **/
    function equals(it:SequentialIterator<T>):Bool;
}

interface IndexIterator<T> extends InputIterator<KeyValuePair<Int, T>> {
    /**
        Compares the IndexIterator with another IndexIterator `it`.

        If the IndexIterator is before `it`, the result is negative. If `it` is
        before the IndexIterator the result is position. If the IndexIterator
        and `it` have the same position, the result is `0`.

        If the IndexIterator and `it` are not of the same type, or not iterating
        over the same object, the result is unspecified.
    **/
    function compare(it:IndexIterator<T>):Int;
}

/**
    An iterator operating over a defined sequence of elements that can move in
    reverse.
**/
interface BidirectionalIterator<T> extends SequentialIterator<T> {
    /**
        Returns `true` if the iterator can be retreated or `false` otherwise.

        This function is not required to be called before a call to `prev()`.
    **/
    function hasPrev():Bool;

    /**
        Returns the current value of the iterator and retreats to the previous
        one.

        If this function is called while `hasPrev()` returns `false`, the result
        may be unspecified.
    **/
    function prev():T;
}

/**
    An iterator that can be set to and retrieve values from arbitrary positions
    in a defined sequence of elements.
**/
interface RandomAccessIterator<T> extends BidirectionalIterator<T> {
    /**
        The current position of the RandomAccessIterator.
    **/
    function position():Int;

    /**
        Sets the RandomAccessIterator to `position`.

        If `pos` is outside the bounds of iteration, the result may be
        unspecified.
    **/
    function setTo(pos:Int):Void;

    /**
        Compares the RandomAccessIterator with another RandomAccessIterator
        `it`.

        If the RandomAccessIterator is before `it`, the result is negative. If
        `it` is before the RandomAccessIterator the result is position. If the
        RandomAccessIterator and `it` have the same position, the result is `0`.

        If the RandomAccessIterator and `it` are not of the same type, or not
        iterating over the same object, the result is unspecified.
    **/
    function compare(it:RandomAccessIterator<T>):Int;
}

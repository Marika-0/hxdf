package hxdf.ds.tuple;

/**
    A tuple of two values.
**/
@:generic
class Double<A, B> implements Tuple {
    /**
        The element at the first position in `this` Double.
    **/
    public var first:A;

    /**
        The element at the second position in `this` Double.
    **/
    public var second:B;

    /**
        Creates a new Double with the given values.
    **/
    public function new(a:A, b:B) {
        first = a;
        second = b;
    }

    /**
        Creates a copy of `this` Double.
    **/
    public function copy():Double<A, B> {
        return new Double(first, second);
    }

    /**
        Maps the elements of `this` Double to a new Double with function `f`.

        If `f` is null, the result is unspecified.
    **/
    public function map(f:Dynamic->Dynamic):Double<A, B> {
        return new Double(f(first), f(second));
    }

    /**
        Converts `this` Double into a string representation.

        The string is enclosed by `{}` with each element separated by a comma.
    **/
    public function toString():String {
        return '{$first,$second}';
    }

    /**
        Converts `this` Double into a string representation where each element
        is separated by `s`.
    **/
    public function join(s:String):String {
        return '$first$s$second';
    }
}

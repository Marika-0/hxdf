package hxdf.ds.tuple;

/**
    A tuple of three values.
**/
@:generic
class Triple<A, B, C> implements Tuple {
    /**
        The element at the first position in `this` Triple.
    **/
    public var first:A;

    /**
        The element at the second position in `this` Triple.
    **/
    public var second:B;

    /**
        The element at the third position in `this` Triple.
    **/
    public var third:C;

    /**
        Creates a new Triple with the given values.
    **/
    public function new(a:A, b:B, c:C) {
        first = a;
        second = b;
        third = c;
    }

    /**
        Creates a copy of `this` Triple.
    **/
    public function copy():Triple<A, B, C> {
        return new Triple(first, second, third);
    }

    /**
        Maps the elements of `this` Triple to a new Triple with function `f`.

        If `f` is null, the result is unspecified.
    **/
    public function map(f:Dynamic->Dynamic):Triple<A, B, C> {
        return new Triple(f(first), f(second), f(third));
    }

    /**
        Converts `this` Triple into a string representation.

        The string is enclosed by `{}` with each element separated by a comma.
    **/
    public function toString():String {
        return '{$first,$second,$third}';
    }

    /**
        Converts `this` Triple into a string representation where each element
        is separated by `s`.
    **/
    public function join(s:String):String {
        return '$first$s$second$s$third';
    }
}

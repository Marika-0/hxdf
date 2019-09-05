package hxdf.ds.tuple;

/**
    A tuple of four values.
**/
@:generic
class Quadruple<A, B, C, D> implements Tuple {
    /**
        The element at the first position in `this` Quadruple.
    **/
    public var first:A;

    /**
        The element at the second position in `this` Quadruple.
    **/
    public var second:B;

    /**
        The element at the third position in `this` Quadruple.
    **/
    public var third:C;

    /**
        The element at the fourth position in `this` Quadruple.
    **/
    public var fourth:D;

    /**
        Creates a new Quadruple with the given values.
    **/
    public function new(a:A, b:B, c:C, d:D) {
        first = a;
        second = b;
        third = c;
        fourth = d;
    }

    /**
        Creates a copy of `this` Quadruple.
    **/
    public function copy():Quadruple<A, B, C, D> {
        return new Quadruple(first, second, third, fourth);
    }

    /**
        Maps the elements of `this` Quadruple to a new Quadruple with function
        `f`.

        If `f` is null, the result is unspecified.
    **/
    public function map(f:Dynamic->Dynamic):Quadruple<A, B, C, D> {
        return new Quadruple(f(first), f(second), f(third), f(fourth));
    }

    /**
        Converts `this` Quadruple into a string representation.

        The string is enclosed by `{}` with each element separated by a comma.
    **/
    public function toString():String {
        return '{$first,$second,$third,$fourth}';
    }

    /**
        Converts `this` Quadruple into a string representation where each
        element is separated by `s`.
    **/
    public function join(s:String):String {
        return '$first$s$second$s$third$s$fourth';
    }
}

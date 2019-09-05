package hxdf.ds.tuple;

/**
    Represents a set number of values.
**/
interface Tuple {
    /**
        Creates a copy of the Tuple.
    **/
    function copy():Tuple;

    /**
        Maps the elements of the Tuple using function `f`.

        If `f` is null, the result is unspecified.
    **/
    function map(f:Dynamic->Dynamic):Tuple;

    /**
        Converts the Tuple into a string representation.

        The string is enclosed by `{}` with each element separated by a comma.
    **/
    function toString():String;

    /**
        Converts the Tuple into a string representation where each element is
        separated by `s`.
    **/
    function join(s:String):String;
}

package hxdf.lambda;

/**
    This class contains various comparison operators to help with keeping code
    clean.
**/
class Compare {
    /**
        Tests that `a == b`.
    **/
    public static inline function standardEquity<T>(a:T, b:T):Bool {
        return a == b;
    }

    /**
        Tests that `a != b`.
    **/
    public static inline function standardInequity<T>(a:T, b:T):Bool {
        return a != b;
    }
}

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

    /**
        Tests the equity of `a` and `b` using `Reflect.compare()` or
        `Reflect.compareMethods()` while ensuring null-safety.
    **/
    public static function reflectiveEquity<T>(a:Null<T>, b:Null<T>):Bool {
        if (a == null || b == null) {
            return a == null && b == null;
        }
        if (Reflect.isFunction(a)) {
            return Reflect.compareMethods(a, b);
        }
        return Reflect.compare(a, b) == 0;
    }

    /**
        Compares `a` and `b` using `Reflect.compare()` while ensuring
        null-safety.

        If `a` is less than `b`, returns a negative integer. If `b` is less than
        `a`, returns a positive integer. If `a` is equivalent to `b`, returns
        zero.

        Null values are evaluated as 'less' than non-null values.
    **/
    public static inline function reflectiveComparison<T>(a:Null<T>, b:Null<T>):Int {
        if (a == null && b != null) {
            return -1;
        }
        if (b == null && a != null) {
            return 1;
        }
        return Reflect.compare(a, b);
    }

    /**
        Returns a function evaluating the reversed relative equity of `comp`.

        For example, `reverse(reflectiveComparison)(a, b)` is equivalent to
        `reflectiveComparison(b, a)`.
    **/
    public static inline function reverse<T>(comp:(T, T)->Int):(T, T)->Int {
        return (a, b) -> 0 - comp(a, b);
    }
}

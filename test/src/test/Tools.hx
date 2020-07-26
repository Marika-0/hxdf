package test;

class Tools {
    public static function arrayEquals<T>(a:Array<T>, b:Array<T>, ?f:(T, T) -> Bool) {
        if (f == null) {
            f = (x, y) -> x == y;
        }

        if (a == null) {
            return b == null;
        } else if (b == null) {
            return false;
        }

        if (a.length != b.length) {
            return false;
        }

        for (i in 0...a.length) {
            if (!f(a[i], b[i])) {
                return false;
            }
        }
        return true;
    }
}

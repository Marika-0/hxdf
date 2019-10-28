package test.ds;

import hxdf.ds.Array;

class ArrayTests extends TestCase {
    public function new() {
        test_fill();
        test_cast();
        test_new();
        test_headModification();
        test_tailModification();
        test_resizing();
        test_remove();
        test_isEmpty();
        test_clear();
        test_dump();
        test_access();
        test_iterating();
        test_copy();
        test_concat();
        test_filter();
        test_map();
        test_toString();
        test_join();
    }

    function test_fill() {
        var a = Array.fill(42, 5);
        assert(a.length == 5);
        assert(a.capacity == 5);
        for (i in 0...5) {
            assert(a[i] == 42);
        }

        var b = Array.fill("String", 0);
        assert(b.length == 0);
        assert(b.capacity == 0);
    }

    function test_cast() {
        var a:Array<Int> = [1, 2, 3, 4, 5];
        assert(a.length == 5);
        assert(a.capacity == 5);
        for (i in 0...5) {
            assert(a[i] == i + 1);
        }

        var b:Array<Dynamic> = [];
        assert(b.length == 0);
        assert(b.capacity == 0);

        var c:std.Array<Dynamic> = b;
        assert(c.length == 0);
    }

    function test_new() {
        var a = new Array<Int>();
        assert(a.length == 0);
        assert(a.capacity == 0);
        assert(a.isEmpty());
    }

    function test_headModification() {
        var a = new Array<Int>();
        for (i in 0...100) {
            assert(a.push(i) == i);
            assert(a.last() == i);
            assert(a.length == i + 1);
            assert(a.capacity == i + 1);
        }
        for (i in 0...100) {
            assert(a.pop() == 99 - i);
            assert(a.length == 99 - i);
        }
        assert(a.pop() == null);
    }

    function test_tailModification() {
        var a = new Array<Int>();
        for (i in 0...100) {
            assert(a.unshift(i) == i);
            assert(a.first() == i);
            assert(a.length == i + 1);
            assert(a.capacity == i + 1);
        }
        for (i in 0...100) {
            assert(a.shift() == 99 - i);
            assert(a.length == 99 - i);
        }
        assert(a.shift() == null);
    }

    function test_resizing() {
        var a = new Array<Int>();
        assert(a.length == 0);
        assert(a.capacity == 0);

        a.reserve(10);
        assert(a.length == 0);
        assert(a.capacity == 10);

        a.resize(10);
        assert(a.length == 0);
        assert(a.capacity == 10);

        a.reserve(5);
        assert(a.length == 0);
        assert(a.capacity == 10);

        a.resize(5);
        assert(a.length == 0);
        assert(a.capacity == 5);

        a.shrink();
        assert(a.length == 0);
        assert(a.capacity == 0);

        a.push(10);
        assert(a.length == 1);
        assert(a.capacity == 1);

        a.reserve(6);
        assert(a.length == 1);
        assert(a.capacity == 6);

        a.shrink();
        assert(a.length == 1);
        assert(a.capacity == 1);
    }

    function test_remove() {
        var a:Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        assert(a.length == 10);

        a.remove(0);
        assert(a.length == 9);
        assert(a.first() == 1);

        a.remove(5, (x, v) -> v < x);
        assert(a.length == 8);
        assert(a.first() == 2);

        var b:Array<Int> = [];
        b.remove(1, (x, v) -> true);
        assert(b.length == 0);
        assert(b.capacity == 0);
    }

    function test_isEmpty() {
        var a = new Array<Int>();
        assert(a.isEmpty());

        a.push(1);
        assert(!a.isEmpty());

        a.pop();
        assert(a.isEmpty());
    }

    function test_clear() {
        var a = new Array<Int>();
        assert(a.isEmpty());
        a.clear();
        assert(a.length == 0);
        assert(a.capacity == 0);

        a.push(1);
        assert(!a.isEmpty());
        a.clear();
        assert(a.length == 0);
        assert(a.capacity == 0);
    }

    function test_dump() {
        var a = new Array<Int>();
        for (i in 0...10) {
            a.push(i);
        }
        assert(a.length == 10);
        assert(a.capacity == 10);

        a.dump();
        assert(a.length == 0);
        assert(a.capacity == 10);

        for (i in 0...10) {
            a.push(i);
        }
        assert(a.length == 10);
        assert(a.capacity == 10);
    }

    function test_access() {
        var a:Array<Int> = [for (i in 0...10) 2 * i + 1];

        for (i in 0...10) {
            assert(a[i] == 2 * i + 1);
        }

        for (_ in 0...500) {
            var i = Std.int(Math.random() * 10);
            assert(a[i] == 2 * i + 1);
        }
    }

    function test_iterating() {
        var a:Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

        var i = 0;
        for (v in a) {
            assert(v == i++);
        }
        i = 0;
        for (v in a.iterator()) {
            assert(v == i++);
        }
        i = 9;
        for (v in a.reverseIterator()) {
            assert(v == i--);
        }

        var b = new Array<Int>();
        assert(!b.iterator().hasNext());
        assert(!b.reverseIterator().hasNext());
    }

    function test_copy() {
        var a:Array<Int> = [6, 1, 5, 2, 4, 3];
        var b = a.copy();
        assert(a.length == b.length);

        for (i in 0...a.length) {
            assert(a[i] == b[i]);
            b[i] = b[i] + 1;
            assert(a[i] + 1 == b[i]);
        }
    }

    function test_concat() {
        var a:Array<Int> = [0, 1, 2, 3, 4];
        var b:Array<Int> = [5, 6, 7, 8, 9];

        var c = a.concat(b);
        for (i in 0...10) {
            assert(c[i] == i);
        }

        c = b.concat(a);
        for (i in 0...5) {
            assert(c[i] == i + 5);
            assert(c[i + 5] == i);
        }
    }

    function test_filter() {
        var a:Array<Int> = [for (i in 0...10) i];
        var b = a.filter((x) -> x % 2 == 0);
        assert(b.length == 5);
        for (i in 0...5) {
            assert(b[i] == i * 2);
        }

        a = [for (i in 0...10) i];
        a = a.filter((x) -> 5 <= x);
        assert(a.length == 5);
        for (i in 0...5) {
            assert(a[i] == i + 5);
        }
    }

    function test_map() {
        var a:Array<Int> = [for (i in 0...10) i];
        var b:Array<String> = a.map((x) -> Std.string(x));
        for (i in 0...10) {
            assert(b[i] == Std.string(i));
        }

        var a = a.map((x) -> x * 2);
        for (i in 0...10) {
            assert(a[i] == i * 2);
        }
    }

    function test_toString() {
        var a:Array<Int> = [for (i in 0...10) i];
        assert(a.toString() == "[0,1,2,3,4,5,6,7,8,9]");

        a.clear();
        assert(a.toString() == "[]");
    }

    function test_join() {
        var a:Array<Int> = [for (i in 0...10) i];
        assert(a.join(" ! ") == "0 ! 1 ! 2 ! 3 ! 4 ! 5 ! 6 ! 7 ! 8 ! 9");
        assert(a.join("") == "0123456789");

        a.clear();
        assert(a.join(" ! ") == "");
        assert(a.join("") == "");
    }
}

package test.ds.list;

import hxdf.ds.list.SingleLinkedList;

@:access(hxdf.ds.list.SingleLinkedList)
class SingleLinkedListTests extends TestCase {
    public function new() {
        test_new();
        test_length();
        test_headModification();
        test_tailModification();
        test_combinedModification();
        test_remove();
        test_isEmpty();
        test_clear();
        test_accessing();
        test_iterating();
        test_creating();
        test_transforming();
        test_stringifying();
    }

    function test_new() {
        assertNExcept(() -> new SingleLinkedList<Int>());
        assert_empty(new SingleLinkedList<Int>());
    }

    function test_length() {
        var a = new SingleLinkedList<Int>();
        assert_empty(a);

        a.push(42);
        assert_notEmpty(a);
        for (i in 0...9) {
            a.push(42);
            assert(a.length == i + 2);
        }
        assert(a.length == 10);

        for (i in 0...10) {
            a.pop();
            assert(a.length == 9 - i);
        }
        assert_empty(a);
    }

    function test_headModification() {
        var a = new SingleLinkedList<Int>();
        assert(a.pop() == null);

        a.push(42);
        assert(a.length == 1);
        assert(a.first() == 42);

        a.push(37);
        assert(a.length == 2);
        assert(a.first() == 37);

        a.push(54);
        assert(a.length == 3);
        assert(a.first() == 54);

        assert(a.pop() == 54);
        assert(a.length == 2);

        assert(a.pop() == 37);
        assert(a.length == 1);

        assert(a.pop() == 42);
        assert_empty(a);

        assert(a.pop() == null);
    }

    function test_tailModification() {
        var a = new SingleLinkedList<Int>();
        assert(a.shift() == null);

        a.unshift(42);
        assert(a.length == 1);
        assert(a.last() == 42);

        a.unshift(37);
        assert(a.length == 2);
        assert(a.last() == 37);

        a.unshift(54);
        assert(a.length == 3);
        assert(a.last() == 54);

        assert(a.shift() == 54);
        assert(a.length == 2);

        assert(a.shift() == 37);
        assert(a.length == 1);

        assert(a.shift() == 42);
        assert_empty(a);

        assert(a.shift() == null);
    }

    function test_combinedModification() {
        var a = new SingleLinkedList<Int>();
        assert(a.pop() == null);
        assert(a.shift() == null);

        a.push(2);
        a.unshift(3);
        a.push(1);
        a.unshift(4);
        for (i in 0...4) {
            assert(a.pop() == [1, 2, 3, 4][i]);
        }
        assert_empty(a);

        a.push(2);
        a.unshift(3);
        a.push(1);
        a.unshift(4);
        for (i in 0...4) {
            assert(a.shift() == [1, 2, 3, 4][3 - i]);
        }
        assert_empty(a);

        a.push(2);
        a.unshift(3);
        a.push(1);
        a.unshift(4);
        for (i in 0...2) {
            assert(a.pop() == [1, 2][i]);
            assert(a.shift() == [4, 3][i]);
        }
        assert_empty(a);
    }

    function test_remove() {
        var a = new SingleLinkedList<Int>();

        assert(!a.remove(42));

        a.push(2);
        a.push(1);
        a.push(0);

        var b = a.copy();

        assert(b.length == 3);
        assert(!b.remove(42));
        assert(b.remove(0));
        assert(b.length == 2);
        assert(b.remove(1));
        assert(b.length == 1);
        assert(b.remove(2));
        assert_empty(b);

        b = a.copy();
        assert(b.length == 3);
        assert(!b.remove(42));
        assert(b.remove(2));
        assert(b.length == 2);
        assert(b.remove(1));
        assert(b.length == 1);
        assert(b.remove(0));
        assert_empty(b);

        b = a.copy();
        assert(b.length == 3);
        assert(!b.remove(42));
        assert(b.remove(1));
        assert(b.length == 2);
        assert(!b.isEmpty());
        assert(b.remove(2));
        assert(b.length == 1);
        assert(!b.isEmpty());
        assert(b.remove(0));
        assert_empty(b);

        var c = new SingleLinkedList<Int>();
        c.push(0);
        c.push(1);
        c.push(2);

        var d = new SingleLinkedList<Int>();
        d.push(0);
        d.push(2);

        c.remove(2, (a, b) -> b < a);
        assert_equal(c, d);
    }

    function test_isEmpty() {
        var a = new SingleLinkedList<Int>();
        assert(a.isEmpty());
        assert(a.length == 0);

        a.push(0);
        assert(!a.isEmpty());
        assert_notEmpty(a);
        a.pop();
        assert_empty(a);

        a.push(0);
        a.shift();
        assert_empty(a);

        a.unshift(0);
        assert(!a.isEmpty());
        assert_notEmpty(a);
        a.pop();
        assert_empty(a);

        a.unshift(0);
        a.shift();
        assert_empty(a);
    }

    function test_clear() {
        var a = new SingleLinkedList<Int>();

        a.clear();
        assert_empty(a);

        a.push(0);
        a.clear();
        assert_empty(a);

        a.push(0);
        a.push(0);
        a.push(0);
        a.clear();
        assert_empty(a);

        a.unshift(0);
        a.unshift(0);
        a.unshift(0);
        a.clear();
        assert_empty(a);

        a.push(0);
        a.unshift(0);
        a.clear();
        assert_empty(a);
    }

    function test_accessing() {
        var a = new SingleLinkedList<Int>();

        assert(a.first() == null);
        assert(a.last() == null);

        a.push(42);
        assert(a.first() == 42);
        assert(a.last() == 42);

        a.push(37);
        assert(a.first() == 37);
        assert(a.last() == 42);

        a.shift();
        assert(a.first() == 37);
        assert(a.last() == 37);
    }

    function test_iterating() {
        var a = new SingleLinkedList<Int>();

        assert(!a.iterator().hasNext());

        a.push(2);
        a.push(1);
        a.push(0);

        var i = 0;
        for (item in a) {
            assert(item == i++);
        }
    }

    function test_creating() {
        var a = new SingleLinkedList<Int>();
        assert_equal(a.copy(), a);

        a.push(2);
        assert_equal(a.copy(), a);
        a.push(1);
        assert_equal(a.copy(), a);
        a.push(0);
        assert_equal(a.copy(), a);

        var b = new SingleLinkedList<Int>();
        b.push(2);
        b.push(1);
        b.push(0);

        assert_equal(a, b);
        assert_equal(a.copy(), b.copy());
        assert_equal(a.copy(), b.copy());
        assert_equal(a.copy(), b.copy());

        var c = new SingleLinkedList<Int>();
        c.push(2);
        c.push(1);
        c.push(0);
        c.push(2);
        c.push(1);
        c.push(0);

        assert_equal(a.concat(new SingleLinkedList<Int>()), a);
        assert_equal(a.concat(b), c);
    }

    function test_transforming() {
        var a = new SingleLinkedList<Int>();
        a.push(0);
        a.push(1);
        a.push(2);
        a.push(3);
        a.push(4);

        var b = new SingleLinkedList<Int>();
        b.push(0);
        b.push(1);
        b.push(2);

        assert_equal(a.filter((x) -> x < 3), b);
        assert_equal(a.filter((x) -> x == 0), b.filter((x) -> x == 0));

        var c = new SingleLinkedList<Int>();
        c.push(0);
        c.push(2);
        c.push(4);

        assert_equal(b.map((x) -> x * 2), c);

        b.shift();
        b.push(3);
        b.push(4);
        b.push(5);

        assert_equal(a.map((x) -> x + 1), b);

        var d = new SingleLinkedList<String>();
        d.push("0");
        d.push("1");
        d.push("2");
        d.push("3");
        d.push("4");

        assert_equal(a.map((x) -> Std.string(x)), d);
    }

    function test_stringifying() {
        var a = new SingleLinkedList<Int>();
        assert(a.toString() == "[]");

        a.push(2);
        assert(a.toString() == "[2]");
        a.push(1);
        assert(a.toString() == "[1,2]");
        a.push(0);
        assert(a.toString() == "[0,1,2]");

        a.clear();
        assert(a.join(" * ") == "");

        a.push(2);
        assert(a.join("ixe92384yx9") == "2");
        a.push(1);
        assert(a.join("wc989485ydw9y") == "1wc989485ydw9y2");
        a.push(0);
        assert(a.join(";\n") == "0;\n1;\n2");
    }

    function assert_empty(l:SingleLinkedList<Dynamic>, ?pos:PosInfos) {
        assert(l.length == 0, "length", pos);
        assert(l.isEmpty(), "isEmpty", pos);
    }

    function assert_notEmpty(l:SingleLinkedList<Dynamic>, ?pos:PosInfos) {
        assert(l.length != 0, "length", pos);
        assert(!l.isEmpty(), "isEmpty", pos);
    }

    function assert_equal<T>(l1:SingleLinkedList<T>, l2:SingleLinkedList<T>, ?pos:PosInfos) {
        var it1 = l1.iterator();
        var it2 = l2.iterator();

        while (it1.hasNext() && it2.hasNext()) {
            assert(it1.next() == it2.next(), "equity", pos);
        }
        assert(!it1.hasNext(), "it1", pos);
        assert(!it2.hasNext(), "it2", pos);

        assert(l1.length == l2.length, "length", pos);
    }
}

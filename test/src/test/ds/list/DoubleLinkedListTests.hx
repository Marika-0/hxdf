package test.ds.list;

import hxdf.ds.list.DoubleLinkedList;

class DoubleLinkedListTests extends hxtf.TestObject {
    public function new() {
        test_creating();
        test_modifying();
        test_reordering();
        test_iterating();
        test_transforming();
        test_stringifying();
    }

    function test_creating():Void {
        var list = new DoubleLinkedList<Int>();
        assert(list.length == 0);
        assert(list.isEmpty());
        assert(list.pop() == null);
        assert(list.peek() == null);
        assert(list.shift() == null);
        assert(list.spy() == null);
    }

    function test_modifying():Void {
        var listA = new DoubleLinkedList<Int>();

        listA.push(3);
        assert(listA.length == 1);
        assert(!listA.isEmpty());
        assert(listA.peek() == 3);
        assert(listA.spy() == 3);

        listA.push(17);
        assert(listA.length == 2);
        assert(!listA.isEmpty());
        assert(listA.peek() == 3);
        assert(listA.spy() == 17);

        listA.push(24);
        assert(listA.length == 3);
        assert(!listA.isEmpty());
        assert(listA.peek() == 3);
        assert(listA.spy() == 24);

        assert(listA.pop() == 3);
        assert(listA.length == 2);
        assert(!listA.isEmpty());
        assert(listA.peek() == 17);
        assert(listA.spy() == 24);

        assert(listA.pop() == 17);
        assert(listA.length == 1);
        assert(!listA.isEmpty());
        assert(listA.peek() == 24);
        assert(listA.spy() == 24);

        assert(listA.pop() == 24);
        assert(listA.length == 0);
        assert(listA.isEmpty());
        assert(listA.peek() == null);
        assert(listA.spy() == null);

        listA.unshift(3);
        assert(listA.length == 1);
        assert(!listA.isEmpty());
        assert(listA.peek() == 3);
        assert(listA.spy() == 3);

        listA.unshift(17);
        assert(listA.length == 2);
        assert(!listA.isEmpty());
        assert(listA.peek() == 17);
        assert(listA.spy() == 3);

        listA.unshift(24);
        assert(listA.length == 3);
        assert(!listA.isEmpty());
        assert(listA.peek() == 24);
        assert(listA.spy() == 3);

        assert(listA.shift() == 3);
        assert(listA.length == 2);
        assert(!listA.isEmpty());
        assert(listA.peek() == 24);
        assert(listA.spy() == 17);

        assert(listA.shift() == 17);
        assert(listA.length == 1);
        assert(!listA.isEmpty());
        assert(listA.peek() == 24);
        assert(listA.spy() == 24);

        assert(listA.shift() == 24);
        assert(listA.length == 0);
        assert(listA.isEmpty());
        assert(listA.peek() == null);
        assert(listA.spy() == null);

        var listB = new DoubleLinkedList<Int>();

        listB.push(3);
        listB.unshift(2);
        listB.push(4);
        listB.unshift(1);
        listB.push(5);
        listB.unshift(0);

        var listC = listB.copy();
        for (i in 0...6) {
            assert(listC.shift() == i);
            assert(listC.length == 5 - i);
        }
        assert(listC.isEmpty());

        var listD = listB.copy();
        for (i in 0...6) {
            assert(listD.pop() == 5 - i);
            assert(listD.length == 5 - i);
        }
        assert(listD.isEmpty());
    }

    function test_reordering():Void {
        var list = new DoubleLinkedList<Int>();

        assert(list.sort().length == 0);
        assert(list.reverse().length == 0);

        list.unshift(42);
        list.unshift(37);
        list.unshift(16);
        list.unshift(99);
        list.unshift(84);

        assert(list.reverse().toString() == "[42,37,16,99,84]");
        assert(list.sort().toString() == "[16,37,42,84,99]");
        assert(list.sort(false).toString() == "[99,84,42,37,16]");
        assert(list.sort().reverse().toString() == "[99,84,42,37,16]");
        assert(list.sort(false).reverse().toString() == "[16,37,42,84,99]");
        assert(list.sort((a, b) -> b - a).toString() == "[99,84,42,37,16]");
        assert(list.sort((a, b) -> b - a, false).toString() == "[16,37,42,84,99]");
    }

    function test_iterating():Void {
        // `beginIterator()` => `iterator()`
        // `endIterator()`   => `reverseIterator()`
        // `indexIterator()` => `keyValueIterator()`

        var listA = new DoubleLinkedList<Int>();

        for (item in listA) {
            assertUnreachable();
        }
        for (index => item in listA) {
            assertUnreachable();
        }
        assert(!listA.iterator().hasNext());
        assert(!listA.reverseIterator().hasNext());
        assert(!listA.keyValueIterator().hasNext());

        listA.push(5);
        for (item in listA) {
            assert(item == 5);
        }

        listA.push(13);
        listA.push(24);
        listA.push(29);
        listA.push(37);

        var index = 0;
        for (item in listA) {
            assert(item == [5, 13, 24, 29, 37][index++]);
        }
        for (item in listA.reverseIterator()) {
            assert(item == [5, 13, 24, 29, 37][--index]);
        }
        for (index => item in listA) {
            assert(item == [5, 13, 24, 29, 37][index]);
        }

        var iteratorA = listA.indexIterator();
        var iteratorB = listA.indexIterator();
        assert(iteratorA.compare(iteratorB) == 0);
        iteratorA.next();
        assert(0 < iteratorA.compare(iteratorB));
        iteratorB.next();
        assert(iteratorA.compare(iteratorB) == 0);
        iteratorB.next();
        assert(iteratorA.compare(iteratorB) < 0);
        iteratorA.next();
        assert(iteratorA.compare(iteratorB) == 0);

        var iteratorC = listA.iterator();
        assert(iteratorC.hasNext());
        assert(!iteratorC.hasPrev());
        assert(iteratorC.next() == 5);
        assert(iteratorC.hasNext());
        assert(iteratorC.next() == 13);
        assert(iteratorC.hasPrev());
        assert(iteratorC.prev() == 5);
        assert(iteratorC.hasNext());
        assert(iteratorC.next() == 13);
        assert(iteratorC.hasNext());
        assert(iteratorC.next() == 24);
        assert(iteratorC.hasNext());
        assert(iteratorC.next() == 29);
        assert(iteratorC.hasNext());
        assert(iteratorC.next() == 37);
        assert(!iteratorC.hasNext());
        assert(iteratorC.hasPrev());
        assert(iteratorC.prev() == 29);
        assert(iteratorC.hasPrev());
        assert(iteratorC.prev() == 24);
        assert(iteratorC.hasPrev());
        assert(iteratorC.prev() == 13);
        assert(iteratorC.hasPrev());
        assert(iteratorC.prev() == 5);
    }

    function test_transforming():Void {
        var listA = new DoubleLinkedList<Int>();
        listA.push(6);
        listA.push(7);
        listA.push(14);
        listA.push(22);
        listA.push(31);
        listA.push(42);

        var listB = listA.copy();
        assert(listA.length == 6);
        assert(listB.length == 6);
        for (i in 0...7) {
            listB.pop();
            assert(listA.length == 6);
            assert(listB.length == [5, 4, 3, 2, 1, 0, 0][i]);
        }
        assert(listB.isEmpty());

        // Filter out all even numbers.
        var listC = listA.filter((i) -> i % 2 != 0);
        assert(listC.length == 2);
        assert(listC.pop() == 31);
        assert(listC.pop() == 7);

        // Filter out all odd numbers.
        var listC = listA.filter((i) -> i % 2 == 0);
        assert(listC.length == 4);
        assert(listC.pop() == 42);
        assert(listC.pop() == 22);
        assert(listC.pop() == 14);
        assert(listC.pop() == 6);

        // Double all numbers.
        var listD = listA.map((i) -> i * 2);
        assert(listD.length == 6);
        for (index => item in listD) {
            assert(item == [84, 62, 44, 28, 14, 12][index]);
        }

        // Reduce all numbers by 2.
        var listE = listA.map((i) -> i - 2);
        assert(listE.length == 6);
        for (index => item in listE) {
            assert(item == [40, 29, 20, 12, 5, 4][index]);
        }

        var listF = new DoubleLinkedList<Int>();
        assertNExcept(() -> listF.remove(42));

        var listG = listA.copy();

        assert(listG.remove(22));
        assert(listG.length == 5);
        for (index => item in listG) {
            assert(item == [42, 31, 14, 7, 6][index]);
        }

        assert(listG.remove(13, (a, b) -> b < a));
        assert(listG.length == 4);
        for (index => item in listG) {
            assert(item == [42, 31, 14, 6][index]);
        }

        assert(listG.remove(42));
        assert(listG.length == 3);
        for (index => item in listG) {
            assert(item == [31, 14, 6][index]);
        }

        assert(listG.remove(6));
        assert(listG.length == 2);
        for (index => item in listG) {
            assert(item == [31, 14][index]);
        }

        assert(listG.remove(14));
        assert(listG.length == 1);
        assert(listG.peek() == 31);
        assert(listG.spy() == 31);

        assert(listG.remove(31));
        assert(listG.isEmpty());

        listG.push(99);
        assert(listG.peek() == listG.spy());

        assert(!listG.remove(-1));
        assert(listG.length == 1);
        assert(listG.peek() == 99);
        assert(listG.spy() == 99);

        assert(listG.remove(-1, (a, b) -> b == 99));
        assert(listG.isEmpty());
        assert(listG.peek() == null);
        assert(listG.spy() == null);
    }

    function test_stringifying():Void {
        var listA = new DoubleLinkedList<Int>();

        assert(listA.toString() == "[]");
        assert(listA.join("str") == "");

        listA.push(2);
        listA.push(5);
        listA.push(26);
        listA.push(677);

        assert(listA.toString() == "[2,5,26,677]");
        assert(listA.join("str") == "2str5str26str677");
        assert(listA.join(null) == "2null5null26null677");
    }
}

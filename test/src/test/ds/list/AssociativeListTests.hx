package test.ds.list;

import hxdf.ds.list.AssociativeList;
import hxdf.ds.unit.KeyValuePair;

using StringTools;

class AssociativeListTests extends hxtf.TestObject {
    public function new() {
        test_creating();
        test_modifying();
        test_iterating();
        test_transforming();
        test_stringifying();
    }

    function test_creating():Void {
        var list = new AssociativeList<Int, String>();
        assert(list.length == 0);
        assert(list.size() == 0);
        assert(list.isEmpty());
    }

    function test_modifying():Void {
        var listA = new AssociativeList<Int, String>();

        listA.set(0, "zero");
        assert(listA.length == 1);
        assert(listA.size() == 1);
        assert(!listA.isEmpty());
        assert(listA.get(0) == "zero");
        assert(listA[0] == "zero");

        listA[1] = "one";
        assert(listA.length == 2);
        assert(listA.size() == 2);
        assert(!listA.isEmpty());
        assert(listA.get(1) == "one");
        assert(listA[1] == "one");

        listA.set(2, "two");
        assert(listA.length == 3);
        assert(listA.size() == 3);
        assert(!listA.isEmpty());
        assert(listA.get(2) == "two");
        assert(listA[2] == "two");

        listA[-1] = "negative one";
        assert(listA.length == 4);
        assert(listA.size() == 4);
        assert(!listA.isEmpty());
        assert(listA.get(-1) == "negative one");
        assert(listA[-1] == "negative one");
    }

    function test_iterating():Void {
        var listA = new AssociativeList<Int, String>();

        for (value in listA) {
            assertUnreachable();
        }
        for (key => value in listA) {
            assertUnreachable();
        }

        assert(!listA.iterator().hasNext());
        assert(!listA.keyIterator().hasNext());
        assert(!listA.keyValueIterator().hasNext());

        listA[1] = "One";
        for (value in listA) {
            assert(value == "One");
        }
        for (key in listA.keyIterator()) {
            assert(key == 1);
        }
        for (key => value in listA) {
            assert(key == 1);
            assert(value == "One");
        }

        listA[0] = "Zero";
        listA[2] = "Two";
        listA[4] = "Four";
        listA[3] = "Three";

        var arrayA = ["Zero", "One", "Two", "Three", "Four"];
        for (value in listA) {
            assert(arrayA.remove(value));
        }
        assert(arrayA.length == 0);
        var arrayB = new Array<Int>();
        for (key in listA.keyIterator()) {
            arrayB.push(key);
        }
        arrayB.sort(Reflect.compare);
        assert(test.Tools.arrayEquals(arrayB, [0, 1, 2, 3, 4]));
    }

    function test_transforming():Void {
        var listA = new AssociativeList<Int, String>();

        listA[0] = "Zero";
        listA[1] = "One";
        listA[2] = "Two";
        listA[3] = "Three";

        var listB = listA.copy();
        var listC = listA.copy();
        assert(listA.size() == 4);
        assert(listB.size() == 4);
        assert(listC.size() == 4);
        for (i in 0...4) {
            assert(listA[i] == ["Zero", "One", "Two", "Three"][i]);
            assert(listB[i] == ["Zero", "One", "Two", "Three"][i]);
            assert(listC[i] == ["Zero", "One", "Two", "Three"][i]);
            assert(listB.delete(i));
            assert(listC.remove(i) == ["Zero", "One", "Two", "Three"][i]);
        }
        assert(listB.remove(42) == null);

        var listD = listA.copy();
        listD.clear();
        assert(listD.length == 0);
        assert(listD.size() == 0);
        for (i in listD) {
            assertUnreachable();
        }

        var listE = listA.copy().filter((s) -> s.endsWith("e"));
        assert(listE.size() == 2);
        assert(!listE.exists(0));
        assert(listE.exists(1));
        assert(!listE.exists(2));
        assert(listE.exists(3));

        var listF = listA.copy().filterKeys((i) -> i < 2);
        assert(listF.size() == 2);
        assert(listF.exists(0));
        assert(listF.exists(1));
        assert(!listF.exists(2));
        assert(!listF.exists(3));

        var listG = listA.copy().filterPairs((pair) -> pair.key == 3 || pair.value == "Two");
        assert(listG.size() == 2);
        assert(!listG.exists(0));
        assert(!listG.exists(1));
        assert(listG.exists(2));
        assert(listG.exists(3));

        var listH = listA.copy().map((s) -> s + "!");
        assert(listH.size() == 4);
        for (i in 0...4) {
            assert(listH[i] == ["Zero!", "One!", "Two!", "Three!"][i]);
        }

        var listI = listA.copy().mapKeys((i) -> i + 1);
        assert(listI.size() == 4);
        for (i in 0...4) {
            assert(listI[i + 1] == ["Zero", "One", "Two", "Three"][i]);
        }

        var listJ = listA.copy().mapPairs((pair) -> new KeyValuePair(pair.key + 1, pair.value + "!"));
        assert(listJ.size() == 4);
        for (i in 0...4) {
            assert(listJ[i + 1] == ["Zero!", "One!", "Two!", "Three!"][i]);
        }
    }

    function test_stringifying():Void {
        var list = new AssociativeList<Int, String>();
        assert(list.toString() == "{}");
        list[0] = "Zero";
        assert(list.toString() == "{0=>Zero}");
        list[1] = "One";
        assert(list.toString() == "{0=>Zero,1=>One}" || list.toString() == "{1=>One,0=>Zero}");
    }
}

package test.ds.list;

import hxdf.ds.list.SelfOrganizingList;
import hxdf.ds.unit.KeyValuePair.KVPFactory;

@:access(hxdf.ds.list.SelfOrganizingList)
class SelfOrganizingListTests extends TestCase {
    public function new() {
        test_new();
        test_set();
        test_get();
        test_remove();
        test_delete();
        test_exists();
        test_isEmpty();
        test_clear();
        test_iterators();
        test_create();
        test_filter();
        test_map();
        test_organize();
        test_toString();
    }

    function test_new() {
        assert(new SelfOrganizingList<String, Int>().length == 0);
        assert(new SelfOrganizingList<String, Int>().isEmpty());
    }

    function test_set() {
        var a = new SelfOrganizingList<String, Int>();
        a.set("One", 1);
        assert(a.length == 1);
        assert(!a.isEmpty());
        assert(a.head != null);
        assert(a.head.key == "One");
        assert(a.head.value == 1);
        assert(a.head == a.tail);

        a.set("Two", 2);
        assert(a.length == 2);
        assert(!a.isEmpty());
        assert(a.head != null);
        assert(a.head.key == "Two");
        assert(a.head.value == 2);
        assert(a.tail.key == "One");
        assert(a.tail.value == 1);
        assert(a.head != a.tail);

        a.set("One", -1);
        assert(a.length == 2);
        assert(!a.isEmpty());
        assert(a.head != null);
        assert(a.head.key == "Two");
        assert(a.head.value == 2);
        assert(a.tail.key == "One");
        assert(a.tail.value == -1);
    }

    function test_get() {
        var list = new SelfOrganizingList<Int, Int>();
        list.set(0, 0);
        list.set(1, 2);
        list.set(2, 4);
        list.set(3, 6);
        list.set(4, 8);
        list.set(5, 10);
        list.set(6, 12);
        list.set(7, 14);
        list.set(8, 16);
        list.set(9, 18);

        assert(list.toString() == "{9=18,8=16,7=14,6=12,5=10,4=8,3=6,2=4,1=2,0=0}");

        assert(list.get(9) == 18);
        assert(list.toString() == "{9=18,8=16,7=14,6=12,5=10,4=8,3=6,2=4,1=2,0=0}");
        assert(list.get(8) == 16);
        assert(list.toString() == "{8=16,9=18,7=14,6=12,5=10,4=8,3=6,2=4,1=2,0=0}");
        assert(list.get(9) == 18);
        assert(list.toString() == "{9=18,8=16,7=14,6=12,5=10,4=8,3=6,2=4,1=2,0=0}");
        assert(list.get(0) == 0);
        assert(list.toString() == "{9=18,8=16,7=14,6=12,0=0,5=10,4=8,3=6,2=4,1=2}");
        assert(list.get(0) == 0);
        assert(list.toString() == "{9=18,8=16,0=0,7=14,6=12,5=10,4=8,3=6,2=4,1=2}");
        assert(list.get(0) == 0);
        assert(list.toString() == "{9=18,0=0,8=16,7=14,6=12,5=10,4=8,3=6,2=4,1=2}");
        assert(list.get(0) == 0);
        assert(list.toString() == "{0=0,9=18,8=16,7=14,6=12,5=10,4=8,3=6,2=4,1=2}");
        assert(list.get(1) == 2);
        assert(list.toString() == "{0=0,9=18,8=16,7=14,1=2,6=12,5=10,4=8,3=6,2=4}");
        assert(list.get(3) == 6);
        assert(list.toString() == "{0=0,9=18,8=16,7=14,3=6,1=2,6=12,5=10,4=8,2=4}");
        assert(list.get(5) == 10);
        assert(list.toString() == "{0=0,9=18,8=16,5=10,7=14,3=6,1=2,6=12,4=8,2=4}");
        assert(list.get(1) == 2);
        assert(list.toString() == "{0=0,9=18,8=16,1=2,5=10,7=14,3=6,6=12,4=8,2=4}");
        assert(list.get(7) == 14);
        assert(list.toString() == "{0=0,9=18,7=14,8=16,1=2,5=10,3=6,6=12,4=8,2=4}");
        assert(list.get(1) == 2);
        assert(list.toString() == "{0=0,9=18,1=2,7=14,8=16,5=10,3=6,6=12,4=8,2=4}");
        assert(list.get(7) == 14);
        assert(list.toString() == "{0=0,7=14,9=18,1=2,8=16,5=10,3=6,6=12,4=8,2=4}");
        assert(list.get(7) == 14);
        assert(list.toString() == "{7=14,0=0,9=18,1=2,8=16,5=10,3=6,6=12,4=8,2=4}");
        assert(list.get(7) == 14);
        assert(list.toString() == "{7=14,0=0,9=18,1=2,8=16,5=10,3=6,6=12,4=8,2=4}");
    }

    function test_remove() {
        var a = new SelfOrganizingList<String, Int>();
        assert(a.remove("Any") == null);
        assert_empty(a);

        a.set("One", 1);
        assert(a.remove("One") == 1);
        assert_empty(a);

        a.set("One", 1);
        assert(a.remove("Two") == null);
        assert_notEmpty(a);

        a.set("Two", 2);
        a.set("Three", 3);
        assert(a.remove("One") == 1);
        assert(a.length == 2);
        assert(a.remove("One") == null);
        assert(a.length == 2);
        assert(a.remove("Two") == 2);
        assert(a.length == 1);
        assert(a.remove("Two") == null);
        assert(a.length == 1);
        assert(a.remove("Three") == 3);
        assert_empty(a);
        assert(a.remove("Three") == null);
        assert_empty(a);
    }

    function test_delete() {
        var a = new SelfOrganizingList<String, Int>();
        assert(!a.delete("Any"));
        assert_empty(a);

        a.set("One", 1);
        assert(a.delete("One"));
        assert_empty(a);

        a.set("One", 1);
        assert(!a.delete("Two"));
        assert_notEmpty(a);

        a.set("Two", 2);
        a.set("Three", 3);
        assert(a.delete("One"));
        assert(a.length == 2);
        assert(!a.delete("One"));
        assert(a.length == 2);
        assert(a.delete("Two"));
        assert(a.length == 1);
        assert(!a.delete("Two"));
        assert(a.length == 1);
        assert(a.delete("Three"));
        assert_empty(a);
        assert(!a.delete("Three"));
        assert_empty(a);
    }

    function test_exists() {
        var a = new SelfOrganizingList<String, Int>();
        assert(!a.exists("Any"));

        a.set("One", 1);
        assert(a.exists("One"));
        assert(!a.exists("Any"));
        a.set("Two", 2);
        assert(a.exists("One"));
        assert(a.exists("Two"));
        assert(!a.exists("Any"));
        a.set("Three", 3);
        assert(a.exists("One"));
        assert(a.exists("Two"));
        assert(a.exists("Three"));
        assert(!a.exists("Any"));
    }

    function test_isEmpty() {
        var a = new SelfOrganizingList<String, Int>();
        assert(a.isEmpty());
        a.set("One", 1);
        assert(!a.isEmpty());
    }

    function test_clear() {
        var a = new SelfOrganizingList<String, Int>();
        a.clear();
        assert_empty(a);

        a.set("One", 1);
        a.clear();
        assert_empty(a);

        a.set("One", 1);
        a.set("Two", 2);
        a.set("Three", 3);
        a.clear();
        assert_empty(a);
    }

    function test_iterators() {
        var a = new SelfOrganizingList<String, Int>();
        assert(!a.iterator().hasNext());
        assert(!a.keys().hasNext());
        assert(!a.keyValueIterator().hasNext());

        a.set("One", 1);
        var itA = a.iterator();
        assert(itA.hasNext());
        assert(itA.next() == 1);
        assert(!itA.hasNext());
        var itB = a.keys();
        assert(itB.hasNext());
        assert(itB.next() == "One");
        assert(!itB.hasNext());
        var itC = a.keyValueIterator();
        assert(itC.hasNext());
        assert(Std.string(itC.next()) == Std.string(KVPFactory.create("One", 1)));
        assert(!itC.hasNext());

        a.set("Two", 2);
        itA = a.iterator();
        assert(itA.hasNext());
        assert(itA.next() == 2);
        assert(itA.hasNext());
        assert(itA.next() == 1);
        assert(!itA.hasNext());
        itB = a.keys();
        assert(itB.hasNext());
        assert(itB.next() == "Two");
        assert(itB.hasNext());
        assert(itB.next() == "One");
        assert(!itB.hasNext());
        itC = a.keyValueIterator();
        assert(itC.hasNext());
        assert(Std.string(itC.next()) == Std.string(KVPFactory.create("Two", 2)));
        assert(itC.hasNext());
        assert(Std.string(itC.next()) == Std.string(KVPFactory.create("One", 1)));
        assert(!itC.hasNext());

        a.set("Three", 3);
        itA = a.iterator();
        assert(itA.hasNext());
        assert(itA.next() == 3);
        assert(itA.hasNext());
        assert(itA.next() == 2);
        assert(itA.hasNext());
        assert(itA.next() == 1);
        assert(!itA.hasNext());
        itB = a.keys();
        assert(itB.hasNext());
        assert(itB.next() == "Three");
        assert(itB.hasNext());
        assert(itB.next() == "Two");
        assert(itB.hasNext());
        assert(itB.next() == "One");
        assert(!itB.hasNext());
        itC = a.keyValueIterator();
        assert(itC.hasNext());
        assert(Std.string(itC.next()) == Std.string(KVPFactory.create("Three", 3)));
        assert(itC.hasNext());
        assert(Std.string(itC.next()) == Std.string(KVPFactory.create("Two", 2)));
        assert(itC.hasNext());
        assert(Std.string(itC.next()) == Std.string(KVPFactory.create("One", 1)));
        assert(!itC.hasNext());
    }

    function test_create() {
        var a = new SelfOrganizingList<String, Int>();
        assert_equal(a.copy(), a);
        a.set("One", 1);
        assert_equal(a.copy(), a);
        a.set("Two", 2);
        assert_equal(a.copy(), a);
        a.set("Three", 3);
        assert_equal(a.copy(), a);

        var b = new SelfOrganizingList<String, Int>();
        assert_equal(a.concat(b), a);
        assert_equal(b.concat(a), a);

        var c = new SelfOrganizingList<String, Int>();
        c.set("One", 1);
        c.set("Two", 2);
        c.set("Three", 3);
        c.set("Four", 4);

        b.set("Four", 4);
        assert_equal(a.concat(b), c);
        b.concat(a);
        assert_equal(b.concat(a), c);

        b.set("Three", -3);
        assert_equal(b.concat(a), c);
        c.set("Three", -3);
        assert_equal(a.concat(b), c);
    }

    function test_filter() {
        var a = new SelfOrganizingList<String, Int>();
        var b = new SelfOrganizingList<String, Int>();

        assert_equal(a.filter((v) -> v == 0), b);
        assert_equal(a.filterKeys((k) -> k == "Zero"), b);
        assert_equal(a.filterPairs((p) -> p.key == Std.string(p.value)), b);

        a.set("One", 1);
        assert_equal(a.filter((v) -> v == 0), b);
        assert_equal(a.filterKeys((k) -> k == "Zero"), b);
        assert_equal(a.filterPairs((p) -> p.key == Std.string(p.value)), b);
        a.clear();
        a.set("1", 1);
        b.set("1", 1);
        assert_equal(a.filter((v) -> v == 1), b);
        assert_equal(a.filterKeys((k) -> k == "1"), b);
        assert_equal(a.filterPairs((p) -> p.key == Std.string(p.value)), b);
        a.set("Two", 2);
        assert_equal(a.filter((v) -> v == 1), b);
        assert_equal(a.filterKeys((k) -> k == "1"), b);
        assert_equal(a.filterPairs((p) -> p.key == Std.string(p.value)), b);
    }

    function test_map() {
        var a = new SelfOrganizingList<String, Int>();
        var b = new SelfOrganizingList<String, Int>();

        assert_equal(a.map((v) -> v + 1), b);
        assert_equal(a.mapKeys((k) -> k + " "), b);
        assert_equal(a.mapPairs((p) -> {key: p.key + " ", value: 0}), b);

        a.set("One", 1);
        b.set("One", 2);
        assert_equal(a.map((v) -> v + 1), b);
        b.clear();
        b.set("One ", 1);
        assert_equal(a.mapKeys((k) -> k + " "), b);
        b.clear();
        b.set("One ", 0);
        assert_equal(a.mapPairs((p) -> {key: p.key + " ", value: 0}), b);

        a.set("Two", 2);
        a.set("Three", 3);
        b.clear();
        b.set("One", 2);
        b.set("Two", 3);
        b.set("Three", 4);
        assert_equal(a.map((v) -> v + 1), b);
        b.clear();
        b.set("One ", 1);
        b.set("Two ", 2);
        b.set("Three ", 3);
        assert_equal(a.mapKeys((k) -> k + " "), b);
        b.clear();
        b.set("One ", 0);
        b.set("Two ", 0);
        b.set("Three ", 0);
        assert_equal(a.mapPairs((p) -> {key: p.key + " ", value: 0}), b);
    }

    function test_organize() {
        var a = new SelfOrganizingList<Int, Int>();

        assert_equal(a.organize((a, b) -> a < b), a);

        a.set(1, 0);
        a.set(2, 1);
        a.set(3, 0);
        a.set(4, 1);
        a.set(5, 0);
        assert(a.toString() == "{5=0,4=1,3=0,2=1,1=0}");

        var b = a.copy();

        a = a.organize((a, b) -> a < b);
        assert_equal(a, b);
        assert(a.toString() == "{1=0,2=1,3=0,4=1,5=0}");
    }

    function test_toString() {
        var a = new SelfOrganizingList<String, Int>();
        assert(a.toString() == "{}");
        a.set("One", 1);
        assert(a.toString() == "{One=1}");
        a.set("Two", 2);
        assert(a.toString() == "{Two=2,One=1}");
    }

    function assert_empty(list:SelfOrganizingList<Dynamic, Dynamic>, ?pos:PosInfos) {
        assert(list.length == 0, "length", pos);
        assert(list.isEmpty(), "isEmpty", pos);
        assert(list.head == null, "head", pos);
        assert(list.tail == null, "tail", pos);
    }

    function assert_notEmpty(list:SelfOrganizingList<Dynamic, Dynamic>, ?pos:PosInfos) {
        assert(list.length != 0, "length", pos);
        assert(!list.isEmpty(), "isEmpty", pos);
        assert(list.head != null, "head", pos);
        assert(list.tail != null, "tail", pos);
    }

    function assert_equal<K, V>(listA:SelfOrganizingList<K, V>, listB:SelfOrganizingList<K, V>, ?pos:PosInfos) {
        assert(listA.length == listB.length, "length", pos);
        for (pair in listA.keyValueIterator()) {
            assert(listB.exists(pair.key), "exists", pos);
            assert(pair.value == listB.get(pair.key), "equity", pos);
        }
    }
}

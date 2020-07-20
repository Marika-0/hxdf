package test.lambda;

import hxdf.lambda.Compare;

class CompareTests extends hxtf.TestObject {
    public function new() {
        test_standardEquity();
        test_standardInequity();
        test_reflectiveEquity();
        test_reflectiveComparison();
    }

    function test_standardEquity():Void {
        assert(Compare.standardEquity(1, 1));
        assert(Compare.standardEquity(true, true));
        assert(Compare.standardEquity(false, false));
        assert(Compare.standardEquity("Hello", "Hello"));
        assert(!Compare.standardEquity(1, 2));
        assert(!Compare.standardEquity(true, false));
        assert(!Compare.standardEquity("Hello", "World"));
    }

    function test_standardInequity():Void {
        assert(!Compare.standardInequity(1, 1));
        assert(!Compare.standardInequity(true, true));
        assert(!Compare.standardInequity(false, false));
        assert(!Compare.standardInequity("Hello", "Hello"));
        assert(Compare.standardInequity(1, 2));
        assert(Compare.standardInequity(true, false));
        assert(Compare.standardInequity("Hello", "World"));
    }

    function test_reflectiveEquity():Void {
        assert(Compare.reflectiveEquity(1, 1));
        assert(Compare.reflectiveEquity(true, true));
        assert(Compare.reflectiveEquity(false, false));
        assert(Compare.reflectiveEquity("Hello", "Hello"));
        var v = {x: 42, y: 11.7};
        assert(Compare.reflectiveEquity(v, v));
    }

    function test_reflectiveComparison():Void {
        assert(Compare.reflectiveComparison(1, 1) == 0);
        assert(Compare.reflectiveComparison(true, true) == 0);
        assert(Compare.reflectiveComparison(false, false) == 0);
        assert(Compare.reflectiveComparison(0, 1) < 0);
        assert(Compare.reflectiveComparison(1, 0) > 0);
        var v = {x: 42, y: 11.7};
        assert(Compare.reflectiveComparison(v, v) == 0);
    }
}

package test.ds;

class TestSuite extends TestBroker {
    public function new() {
        addTest(test.ds.ArrayTests);
        addBroker(test.ds.list.TestSuite);
        addBroker(test.ds.tuple.TestSuite);
        addBroker(test.ds.unit.TestSuite);
    }
}

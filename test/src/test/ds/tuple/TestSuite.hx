package test.ds.tuple;

class TestSuite extends TestBroker {
    public function new() {
        addTest(test.ds.tuple.DoubleTests);
        addTest(test.ds.tuple.TripleTests);
        addTest(test.ds.tuple.QuadrupleTests);
    }
}

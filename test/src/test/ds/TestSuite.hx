package test.ds;

class TestSuite extends TestBroker {
    public function new() {
        addBroker(test.ds.tuple.TestSuite);
    }
}
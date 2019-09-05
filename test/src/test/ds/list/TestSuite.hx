package test.ds.list;

class TestSuite extends TestBroker {
    public function new() {
        addTest(test.ds.list.AssociativeListTests);
    }
}

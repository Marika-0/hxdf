package test.ds.list;

class TestSuite extends TestBroker {
    public function new() {
        addTest(test.ds.list.AssociativeListTests);
        addTest(test.ds.list.DoubleLinkedListTests);
        addTest(test.ds.list.SelfOrganizingListTests);
        addTest(test.ds.list.SingleLinkedListTests);
    }
}

package test.ds.list;

class TestSuite {
    public function new() {
        addObject(AssociativeListTests);
        addObject(DoubleLinkedListTests);
        addObject(SelfOrganizingListTests);
        addObject(SingleLinkedListTests);
    }
}

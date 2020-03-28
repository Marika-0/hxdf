package test.ds.unit;

class TestSuite {
    public function new() {
        addObject(DoubleNodeTests);
        addObject(KeyValuePairTests);
        addObject(SingleAssociationNodeTests);
        addObject(SingleNodeTests);
    }
}

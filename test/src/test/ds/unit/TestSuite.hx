package test.ds.unit;

class TestSuite extends TestBroker {
    public function new() {
        addTest(test.ds.unit.DoubleNodeTests);
        addTest(test.ds.unit.KeyValuePairTests);
        addTest(test.ds.unit.SingleAssociationNodeTests);
        addTest(test.ds.unit.SingleNodeTests);
    }
}

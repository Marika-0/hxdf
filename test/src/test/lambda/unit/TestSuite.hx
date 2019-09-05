package test.lambda.unit;

class TestSuite extends TestBroker {
    public function new() {
        addTest(test.lambda.unit.BackwardsDoubleNodeIteratorTests);
        addTest(test.lambda.unit.ForwardsDoubleNodeIteratorTests);
        addTest(test.lambda.unit.SingleAssociationNodeIteratorTests);
        addTest(test.lambda.unit.SingleAssociationNodeKeyIteratorTests);
        addTest(test.lambda.unit.SingleAssociationNodeValueIteratorTests);
        addTest(test.lambda.unit.SingleNodeIteratorTests);
    }
}

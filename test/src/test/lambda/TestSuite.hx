package test.lambda;

class TestSuite extends TestBroker {
    public function new() {
        addBroker(test.lambda.unit.TestSuite);
    }
}

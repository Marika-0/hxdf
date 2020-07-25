package test.lambda;

class TestSuite {
    public function new() {
        addObject(CompareTests);
        addObject(ConvertTests);
        addObject(SortTests);
    }
}

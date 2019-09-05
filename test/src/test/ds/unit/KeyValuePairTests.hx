package test.ds.unit;

import hxdf.ds.unit.KeyValuePair;
import hxdf.ds.unit.KeyValuePair.KVPFactory;

class KeyValuePairTests extends TestCase {
    public function new() {
        var s:KeyValuePair<String, Int> = KVPFactory.create("One", 1);
        assert(s.key == "One");
        assert(s.value == 1);
    }
}

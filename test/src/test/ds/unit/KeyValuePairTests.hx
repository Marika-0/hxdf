package test.ds.unit;

import hxdf.ds.unit.KeyValuePair;

class KeyValuePairTests extends hxtf.TestObject {
    public function new() {
        var pair = new KeyValuePair(19, true);
        assert(pair.key == 19);
        assert(pair.value);

        pair.key = -2;
        pair.value = false;
        assert(pair.key == -2);
        assert(!pair.value);
    }
}

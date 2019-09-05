package test.lambda.unit;

import hxdf.ds.unit.SingleAssociationNode as SAN;
import hxdf.lambda.unit.SingleAssociationNodeIterator as SANIterator;

class SingleAssociationNodeIteratorTests extends TestCase {
    public function new() {
        var a:SAN<String, Int> = null;
        assert(!new SANIterator(a).hasNext());

        var b = new SAN("One", 1);
        for (pair in new SANIterator(b)) {
            assert(pair.key == "One");
            assert(pair.value == 1);
        }

        var c = new SAN("One", 1, new SAN("Two", 2, new SAN("Three", 3)));
        var i = 0;
        for (pair in new SANIterator(c)) {
            assert(pair.key == ["One", "Two", "Three"][i]);
            assert(pair.value == ++i);
        }

        i = 0;
        for (key => value in new SANIterator(c)) {
            assert(key == ["One", "Two", "Three"][i]);
            assert(value == ++i);
        }
    }
}

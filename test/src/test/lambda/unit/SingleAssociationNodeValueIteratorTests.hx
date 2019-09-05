package test.lambda.unit;

import hxdf.ds.unit.SingleAssociationNode as SAN;
import hxdf.lambda.unit.SingleAssociationNodeValueIterator as SANVIterator;

class SingleAssociationNodeValueIteratorTests extends TestCase {
    public function new() {
        var a:SAN<String, Int> = null;
        assert(!new SANVIterator(a).hasNext());

        var b = new SAN("One", 1);
        for (value in new SANVIterator(b)) {
            assert(value == 1);
        }

        var c = new SAN("One", 1, new SAN("Two", 2, new SAN("Three", 3)));
        var i = 0;
        for (value in new SANVIterator(c)) {
            assert(value == ++i);
        }
    }
}

package test.lambda.unit;

import hxdf.ds.unit.SingleAssociationNode as SAN;
import hxdf.lambda.unit.SingleAssociationNodeKeyIterator as SANKIterator;

class SingleAssociationNodeKeyIteratorTests extends TestCase {
    public function new() {
        var a:SAN<String, Int> = null;
        assert(!new SANKIterator(a).hasNext());

        var b = new SAN("One", 1);
        for (key in new SANKIterator(b)) {
            assert(key == "One");
        }

        var c = new SAN("One", 1, new SAN("Two", 2, new SAN("Three", 3)));
        var i = 0;
        for (key in new SANKIterator(c)) {
            assert(key == ["One", "Two", "Three"][i++]);
        }
    }
}

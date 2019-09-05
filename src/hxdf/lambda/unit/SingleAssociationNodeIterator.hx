package hxdf.lambda.unit;

import hxdf.ds.unit.SingleAssociationNode;
import hxdf.ds.unit.KeyValuePair;
import hxdf.ds.unit.KeyValuePair.KVPFactory;

/**
    An iterator for the `hxdf.ds.unit.SingleAssociationNode` type, iterating
    over key/value pairs.

    This iterator conforms to the Haxe 4 KeyValueIterator protocol.

    @see <https://github.com/HaxeFoundation/haxe/wiki/What%27s-new-in-Haxe-4#key-value-iterators>
**/
class SingleAssociationNodeIterator<K, V> {
    var node:SingleAssociationNode<K, V>;

    /**
        Create a new SingleAssociationNodeIterator beginning iteration from an
        initial node `head`.
    **/
    public function new(head:SingleAssociationNode<K, V>) {
        node = head;
    }

    /**
        Tells if `this` SingleAssociationNodeIterator has at least one more
        element to iterate on.
    **/
    public function hasNext():Bool {
        return node != null;
    }

    /**
        Accesses the current element of iteration and increments `this`
        SingleAssociationNodeIterator.
    **/
    public function next():KeyValuePair<K, V> {
        var pair = KVPFactory.create(node.key, node.value);
        node = node.next;
        return pair;
    }
}

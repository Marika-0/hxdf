package hxdf.ds.list;

import hxdf.ds.unit.KeyValuePair;
import hxdf.ds.unit.SingleAssociationNode;

/**
    A self-organizing association list implementing iteration-space bisection.

    Comparison of keys is done using an internal `compare` method, which can be
    overridden by extending classes. By default,
    `hxdf.lambda.Compare.reflectiveEquity()` is used to test the equity of keys.

    New key/value bindings are placed at the beginning of the list, while
    existing bindings are reassigned in-place.

    This list organizes itself by moving accessed bindings halfway towards the
    front of the list, halving the search time for each subsequent access of the
    same binding.
**/
@:access(hxdf.ds.list.SingleLinkedList)
class SelfOrganizingList<K, V> extends AssociativeList<K, V>
{
    override function find(key:K, operate:(SingleAssociationNode<K, V>) -> Void, failure:() -> Void):Bool
    {
        var parent = null;
        var node:SingleAssociationNode<K, V> = list.head;

        if (node == null)
        {
            failure();
            return false;
        }

        var bisector = new SingleAssociationNode<K, V>(node.key, node.value, node);
        var increment = false;

        while (node != null)
        {
            if (compare(node.key, key))
            {
                operate(node);
                if (parent != null)
                {
                    parent.next = node.next;
                    if (parent == list.head) list.head = new SingleAssociationNode<K, V>(node.key, node.value, list.head);
                    else bisector.next = new SingleAssociationNode<K, V>(node.key, node.value, bisector.next);
                }
                return true;
            }
            parent = node;
            node = node.next;
            if (increment) bisector = bisector.next;
            increment = !increment;
        }
        failure();
        return false;
    }
}

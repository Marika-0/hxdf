package hxdf.ds.list;

import hxdf.ds.Container.AssociativeContainer;
import hxdf.ds.unit.KeyValuePair;
import hxdf.ds.unit.SingleAssociationNode;
import hxdf.lambda.Iterator.InputIterator as InputIteratorTemplate;

/**
    A singly-linked association list.

    Comparison of keys is done using an internal `compare` method, which can be
    overridden by extending classes. By default,
    `hxdf.lambda.Compare.reflectiveEquity()` is used to test the equity of keys.

    New key/value bindings are placed at the beginning of the list, while
    existing bindings are reassigned in-place. No guarantees are made for the
    order of key/value pairs.
**/
@:access(hxdf.ds.list.SingleLinkedList)
class AssociativeList<K, V> implements AssociativeContainer<K, V>
{
    /**
        The number of key/value pairs in `this` AssociativeList.
    **/
    public var length(default, null):Int;

    var list:SingleLinkedList<KeyValuePair<K, V>>;

    /**
        Creates a new empty AssociativeList.
    **/
    public function new()
    {
        length = 0;
        list = new SingleLinkedList<KeyValuePair<K, V>>();
    }

    /**
        Returns the binding of `key`.

        If `key` is not bound to a value, returns `null`.
    **/
    public function get(key:K):Null<V>
    {
        var value:Null<V>;
        find(key, (node) -> value = node.value, () -> value = null);
        return value;
    }

    /**
        Binds `key` to `value` and returns `value`.

        If `key` is already bound to a value, that binding is overridden.
    **/
    public inline function set(key:K, value:V):Void
    {
        find(key, (node) -> node.value = value, () ->
        {
            list.head = new SingleAssociationNode<K, V>(key, value, list.head);
            length = ++list.length;
        });
    }

    /**
        Returns the number of key/value bindings in `this` AssociativeList.
    **/
    public inline function size():Int
    {
        return length;
    }

    /**
        Returns if the given `key` is bound to a value.

        This function does now modify `this` AssociativeList.
    **/
    public inline function exists(key:K):Bool
    {
        return find(key, (node) -> {}, () -> {});
    }

    /**
        Removes the binding of `key` and returns `true` if it existed.

        If `key` is not bound, returns `false`, and `this` AssociativeList is
        unchanged.
    **/
    public function delete(key:K):Bool
    {
        return findWithParent(key, (node, parent) ->
        {
            if (parent == null) list.head = list.head.next;
            else parent.next = node.next;
            length = --list.length;
        }, () -> {});
    }

    /**
        Removes the binding of `key` and returns its value.

        If `key` is not bound, returns `null`, and `this` AssociativeList is
        unchanged.
    **/
    public function remove(key:K):Null<V>
    {
        var value:Null<V>;
        findWithParent(key, (node, parent) ->
        {
            value = node.value;
            if (parent == null) list.head = list.head.next;
            else parent.next = node.next;
            length = --list.length;
        }, () -> value = null);
        return value;
    }

    /**
        Returns an iterator over the values of `this` AssociativeList.
    **/
    public inline function iterator():ValueInputIterator<V>
    {
        return new ValueInputIterator<V>(list.head);
    }

    /**
        Returns an iterator over the keys of `this` AssociativeList.
    **/
    public inline function keyIterator():KeyInputIterator<K>
    {
        return new KeyInputIterator<K>(list.head);
    }

    /**
        Returns an iterator over the key/value pairs of `this` AssociativeList.
    **/
    public inline function keyValueIterator():PairInputIterator<K, V>
    {
        return new PairInputIterator<K, V>(list.head);
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f(value)` returns `true`.

        This function does not modify `this` AssociativeList.
    **/
    public inline function filter(f:(V) -> Bool):AssociativeList<K, V>
    {
        return internalFilter((pair) -> f(pair.value));
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f(key)` returns `true`.

        This function does not modify `this` AssociativeList.
    **/
    public inline function filterKeys(f:(K) -> Bool):AssociativeList<K, V>
    {
        return internalFilter((pair) -> f(pair.key));
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f({key:K, value:V})` returns `true`.

        This function does not modify `this` AssociativeList.
    **/
    public inline function filterPairs(f:(KeyValuePair<K, V>) -> Bool):AssociativeList<K, V>
    {
        return internalFilter(f);
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will retain all its original keys with each
        key/value pair's value binding being set to `f(value)`.
    **/
    public inline function map<S>(f:(V) -> S):AssociativeList<K, S>
    {
        return internalMap((pair) -> new KeyValuePair(pair.key, f(pair.value)));
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will retain all its original keys with each
        key/value pair's key binding being set to `f(key)`.

        If the mapping function produces collisions, the value bound to the
        collision key is unspecified.
    **/
    public inline function mapKeys<S>(f:(K) -> S):AssociativeList<S, V>
    {
        return internalMap((pair) -> new KeyValuePair(f(pair.key), pair.value));
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will contain the key/value pair bindings
        from the output of `f({key:K, value:V})`.

        If the mapping function produces collisions, the value bound to the
        collision key is unspecified.
    **/
    public inline function mapPairs<X, Y>(f:(KeyValuePair<K, V>) -> KeyValuePair<X, Y>):AssociativeList<X, Y>
    {
        return internalMap(f);
    }

    /**
        Tells if `this` AssociativeList is empty.
    **/
    public inline function isEmpty():Bool
    {
        return length == 0;
    }

    /**
        Removes all bindings from `this` AssociativeList.

        This function does not traverse the list.
    **/
    public inline function clear():Void
    {
        list.clear();
        length = 0;
    }

    /**
        Returns a shallow copy of `this` AssociativeList.

        The elements are not copied and retain their identity.
    **/
    public function copy():AssociativeList<K, V>
    {
        var list = new AssociativeList<K, V>();
        list.list = this.list.copy();
        list.length = length;
        return list;
    }

    /**
        Converts `this` AssociativeList into a string representation.

        Internally, this function calls `Std.string` on each key/value binding
        of `this` AssociativeList.

        The output is formatted to be enclosed by `"{}"`, with each pair in the
        form `"key=>value"` and separated by `","`.
    **/
    public function toString():String
    {
        if (length == 0) return "{}";

        var buf = new StringBuf();
        var node = list.head;

        inline function addPair(pair:KeyValuePair<K, V>, buf:StringBuf)
        {
            buf.add(Std.string(pair.key));
            buf.addChar("=".code);
            buf.addChar(">".code);
            buf.add(Std.string(pair.value));
        }
        buf.addChar("{".code);

        addPair(node.data, buf);
        node = node.next;
        while (node != null)
        {
            buf.addChar(",".code);
            addPair(node.data, buf);
            node = node.next;
        }
        buf.addChar("}".code);
        return buf.toString();
    }

    inline function compare(a:K, b:K):Bool
    {
        return hxdf.lambda.Compare.reflectiveEquity(a, b);
    }

    /**
        Searches for a node with key `key` and calls `operate(node)` on that node.

        If a node with key `key` cannot be found, calls `failure()`.
    **/
    function find(key:K, operate:(SingleAssociationNode<K, V>) -> Void, failure:() -> Void):Bool
    {
        var node:SingleAssociationNode<K, V> = list.head;
        while (node != null)
        {
            if (compare(node.key, key))
            {
                operate(node);
                return true;
            }
            node = node.next;
        }
        failure();
        return false;
    }

    /**
        Searches for a node with key `key` and its parent node, and calls
        `operate(node, parent)` on that node and parent.

        If a node with key `key` cannot be found, calls `failure()`.
    **/
    function findWithParent(
        key:K, operate:(SingleAssociationNode<K, V>, SingleAssociationNode<K, V>) -> Void, failure:() -> Void
    ):Bool
    {
        var parent = null;
        var node:SingleAssociationNode<K, V> = list.head;
        while (node != null)
        {
            if (compare(node.key, key))
            {
                operate(node, parent);
                return true;
            }
            parent = node;
            node = node.next;
        }
        failure();
        return false;
    }

    /**
        Creates a copy of this AssociativeList containing every node of this
        AssociativeList (in the same order) where `evaluate(node)` on that node
        returns `true`.

        The elements are not copied and retain their identity.
    **/
    function internalFilter(evaluate:(KeyValuePair<K, V>) -> Bool):AssociativeList<K, V>
    {
        var list = new AssociativeList<K, V>();
        for (pair in keyValueIterator())
        {
            if (evaluate(pair))
            {
                list.list.head = new SingleAssociationNode<K, V>(pair.key, pair.value, list.list.head);
                list.length = ++list.list.length;
            }
        }
        return list;
    }

    /**
        Creates a copy of this AssociativeList containing every node of this
        AssociativeList (in the same order) mapped by calling `transform(node)`
        on that node.
    **/
    function internalMap<X, Y>(transform:(KeyValuePair<K, V>) -> KeyValuePair<X, Y>):AssociativeList<X, Y>
    {
        var list = new AssociativeList<X, Y>();
        for (pair in keyValueIterator())
        {
            var map = transform(pair);
            list.set(map.key, map.value);
        }
        return list;
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class PairInputIterator<K, V> implements InputIteratorTemplate<KeyValuePair<K, V>>
{
    var node:SingleAssociationNode<K, V>;

    public function new(head:SingleAssociationNode<K, V>)
    {
        node = head;
    }

    public inline function hasNext():Bool
    {
        return node != null;
    }

    public function next():KeyValuePair<K, V>
    {
        var pair = node.pair;
        node = node.next;
        return pair;
    }

    public function advance(distance:Int):Bool
    {
        while (0 < distance-- && hasNext()) node = node.next;
        return hasNext();
    }

    public inline function copy():PairInputIterator<K, V>
    {
        return new PairInputIterator<K, V>(node);
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class KeyInputIterator<K> implements InputIteratorTemplate<K>
{
    var node:SingleAssociationNode<K, Dynamic>;

    public function new(head:SingleAssociationNode<K, Dynamic>)
    {
        node = head;
    }

    public inline function hasNext():Bool
    {
        return node != null;
    }

    public function next():K
    {
        var key = node.key;
        node = node.next;
        return key;
    }

    public function advance(distance:Int):Bool
    {
        while (0 < distance-- && hasNext()) node = node.next;
        return hasNext();
    }

    public inline function copy():KeyInputIterator<K>
    {
        return new KeyInputIterator<K>(node);
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class ValueInputIterator<V> implements InputIteratorTemplate<V>
{
    var node:SingleAssociationNode<Dynamic, V>;

    public function new(head:SingleAssociationNode<Dynamic, V>)
    {
        node = head;
    }

    public inline function hasNext():Bool
    {
        return node != null;
    }

    public function next():V
    {
        var value = node.value;
        node = node.next;
        return value;
    }

    public function advance(distance:Int):Bool
    {
        while (0 < distance-- && hasNext()) node = node.next;
        return hasNext();
    }

    public inline function copy():ValueInputIterator<V>
    {
        return new ValueInputIterator<V>(node);
    }
}

package hxdf.ds.list;

import hxdf.ds.Container.AssociativeContainer;
import hxdf.ds.unit.SingleAssociationNode;
import hxdf.ds.unit.KeyValuePair;
import hxdf.ds.unit.KeyValuePair.KVPFactory;
import hxdf.lambda.unit.SingleAssociationNodeIterator;
import hxdf.lambda.unit.SingleAssociationNodeKeyIterator;
import hxdf.lambda.unit.SingleAssociationNodeValueIterator;

/**
    A singly-linked association list.

    Comparison of keys is done using an internal `compare` method, which can be
    overridden by extending classes. By default it uses `Reflect.compare` and
    `Reflect.compareMethods` to test equity of keys.

    New key/value bindings are placed at the beginning of the list, while
    existing binding are reassigned in-place.
**/
class AssociativeList<K, V> implements AssociativeContainer<K, V> {
    /**
        The number of key/value bindings in `this` AssociativeList.
    **/
    public var length(default, null):Int;

    var head:SingleAssociationNode<K, V>;
    var tail:SingleAssociationNode<K, V>;

    /**
        Creates a new empty AssociativeList.
    **/
    public function new() {
        length = 0;
        head = null;
        tail = null;
    }

    /**
        Returns the number of key/value bindings in `this` AssociativeList.
    **/
    public inline function size():Int {
        return length;
    }

    /**
        Binds `key` to `value` and returns `value`.

        If `key` is already bound to a value, that binding is overridden.

        If `key` is null, the result is unspecified.
    **/
    public function set(key:K, value:V):V {
        if (head == null) {
            head = tail = new SingleAssociationNode<K, V>(key, value);
        } else {
            var node = head;
            while (node != null) {
                if (compare(key, node.key)) {
                    return node.value = value;
                }
                node = node.next;
            }
            head = new SingleAssociationNode<K, V>(key, value, head);
        }
        length++;
        return value;
    }

    /**
        Returns the binding of `key`.

        If `key` is not bound to a value, returns `null`.

        If `key` is null, the result is unspecified.
    **/
    public function get(key:K):Null<V> {
        var node = head;
        while (node != null) {
            if (compare(key, node.key)) {
                return node.value;
            }
            node = node.next;
        }
        return null;
    }

    /**
        Removes the binding of `key` and returns it's value.

        If `key` is not bound, returns `null`, and `this` AssociativeList is
        unchanged.

        If `key` is null, the result is unspecified.
    **/
    public function remove(key:K):Null<V> {
        var prev:SingleAssociationNode<K, V> = null;
        var node = head;
        while (node != null) {
            if (compare(key, node.key)) {
                var data = node.value;
                if (prev == null) {
                    head = head.next;
                } else {
                    prev.next = node.next;
                }
                if (node == tail) {
                    tail = prev;
                }
                length--;
                return data;
            }
            prev = node;
            node = node.next;
        }
        return null;
    }

    /**
        Removes the binding of `key` and returns `true` if it existed.

        If `key` is not bound, returns `false`, and `this` AssociativeList is
        unchanged.

        if `key` is null, the result is unspecified.
    **/
    public function delete(key:K):Bool {
        var prev:SingleAssociationNode<K, V> = null;
        var node = head;
        while (node != null) {
            if (compare(key, node.key)) {
                if (prev == null) {
                    head = head.next;
                } else {
                    prev.next = node.next;
                }
                if (node == tail) {
                    tail = prev;
                }
                length--;
                return true;
            }
            prev = node;
            node = node.next;
        }
        return false;
    }

    /**
        Returns if the given `key` is bound to a value.

        This function does now modify `this` AssociativeList.

        If `key` is null, the result is unspecified.
    **/
    public function exists(key:K):Bool {
        for (bind in keys()) {
            if (compare(key, bind)) {
                return true;
            }
        }
        return false;
    }

    /**
        Tells if `this` AssociativeList is empty.
    **/
    public function isEmpty():Bool {
        return head == null;
    }

    /**
        Removes all bindings from `this` AssociativeList.

        This function does not traverse the elements, but sets internal
        references to null and `this.length` to 0.
    **/
    public function clear():Void {
        length = 0;
        head = null;
        tail = null;
    }

    /**
        Returns an iterator over the values of `this` AssociativeList.
    **/
    public inline function iterator():SingleAssociationNodeValueIterator<V> {
        return new SingleAssociationNodeValueIterator<V>(head);
    }

    /**
        Returns an iterator over the keys of `this` AssociativeList.
    **/
    public inline function keys():SingleAssociationNodeKeyIterator<K> {
        return new SingleAssociationNodeKeyIterator<K>(head);
    }

    /**
        Returns an iterator over the key/value pairs of `this` AssociativeList.
    **/
    public inline function keyValueIterator():SingleAssociationNodeIterator<K, V> {
        return new SingleAssociationNodeIterator<K, V>(head);
    }

    /**
        Returns a shallow copy of `this` AssociativeList.

        The elements are not copied and retain their identity.
    **/
    public function copy():AssociativeList<K, V> {
        var list = new AssociativeList<K, V>();
        if (head != null) {
            var node = list.head = new SingleAssociationNode(head.key, head.value);
            var iter = head.next;
            while (iter != null) {
                node = node.next = new SingleAssociationNode(iter.key, iter.value);
                iter = iter.next;
            }
            list.tail = node;
            list.length = length;
        }
        return list;
    }

    /**
        Creates a new AssociativeList by writing the bindings of `list` into a
        copy of `this` AssociativeList.

        This operations does not modify `list` or `this` AssociativeList.

        Key/value bindings in the copy of `this` AssociativeList are overridden
        by bindings in `list`.

        if `list` is null, the result is unspecified.
    **/
    public function concat(list:AssociativeList<K, V>):AssociativeList<K, V> {
        if (head == null) {
            return list.copy();
        }
        var conc = copy();
        var node = list.head;
        while (node != null) {
            var iter = conc.head;
            var replaced = false;
            while (iter != null) {
                if (compare(node.key, iter.key)) {
                    iter.value = node.value;
                    replaced = true;
                    break;
                }
                iter = iter.next;
            }
            if (!replaced) {
                conc.head = new SingleAssociationNode<K, V>(node.key, node.value, conc.head);
                conc.length++;
            }
            node = node.next;
        }
        return conc;
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f(value)` returns `true`.

        This function does not modify `this` AssociativeList.

        If `f` is null, the result is unspecified.
    **/
    public inline function filter(f:V->Bool):AssociativeList<K, V> {
        return internalFilter(f, (n) -> n.value);
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f(key)` returns `true`.

        This function does not modify `this` AssociativeList.

        If `f` is null, the result is unspecified.
    **/
    public inline function filterKeys(f:K->Bool):AssociativeList<K, V> {
        return internalFilter(f, (n) -> n.key);
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f({key:K, value:V})` returns `true`.

        This function does not modify `this` AssociativeList.

        If `f` is null, the result is unspecified.
    **/
    public inline function filterPairs(f:KeyValuePair<K, V>->Bool):AssociativeList<K, V> {
        return internalFilter(f, (n) -> KVPFactory.create(n.key, n.value));
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will retain all its original keys with each
        key/value pair's value binding being set to `f(value)`.

        if `f` is null, the result is unspecified.
    **/
    public inline function map<Y>(f:V->Y):AssociativeList<K, Y> {
        return internalMap((p) -> KVPFactory.create(p.key, f(p.value)));
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will retain all its original keys with each
        key/value pair's key binding being set to `f(key)`.

        If the mapping function produces collisions, later bindings will
        override earlier ones.

        if `f` is null, the result is unspecified.
    **/
    public inline function mapKeys<X>(f:K->X):AssociativeList<X, V> {
        return internalMap((p) -> KVPFactory.create(f(p.key), p.value));
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will contain the key/value pair bindings
        from the output of `f({key:K, value:V})`.

        If the mapping function produces key collisions, later bindings will
        override earlier ones.

        if `f` is null, the result is unspecified.
    **/
    public inline function mapPairs<X, Y>(f:KeyValuePair<K, V>->KeyValuePair<X, Y>):AssociativeList<X, Y> {
        return internalMap(f);
    }

    /**
        Converts `this` AssociativeList into a string representation.

        Internally, this function calls `Std.string` on each key/value binding
        of `this` AssociativeList.

        The output is formatted to be enclosed by `"{}"`, with each pair in the
        form `"key=value"` and separated by `","`.
    **/
    public function toString():String {
        var buf = new StringBuf();
        buf.addChar("{".code);
        var node = head;
        while (node != null) {
            buf.add(Std.string(node.key));
            buf.addChar("=".code);
            buf.add(Std.string(node.value));
            if ((node = node.next) != null) {
                buf.addChar(",".code);
            }
        }
        buf.addChar("}".code);
        return buf.toString();
    }

    /**
        Internal comparison function for testing if two given keys are equal.
    **/
    function compare<K>(a:K, b:K):Bool {
        return if (Reflect.isFunction(a)) {
            Reflect.compareMethods(a, b);
        } else {
            Reflect.compare(a, b) == 0;
        }
    }

    /**
        Internal filtering function for different methods of filtering.
    **/
    function internalFilter<T>(eval:T->Bool, process:SingleAssociationNode<K, V>->T):AssociativeList<K, V> {
        var list = new AssociativeList<K, V>();
        var node = head;
        while (node != null) {
            if (eval(process(node))) {
                if (list.head == null) {
                    list.head = list.tail = new SingleAssociationNode<K, V>(node.key, node.value);
                } else {
                    list.head = new SingleAssociationNode<K, V>(node.key, node.value, list.head);
                }
                list.length++;
            }
            node = node.next;
        }
        return list;
    }

    /**
        Internal mapping function for different methods of mapping.
    **/
    function internalMap<X, Y>(transform:KeyValuePair<K, V>->KeyValuePair<X, Y>):AssociativeList<X, Y> {
        var list = new AssociativeList<X, Y>();
        var node = head;
        while (node != null) {
            var pair = transform(KVPFactory.create(node.key, node.value));
            if (list.head == null) {
                list.head = list.tail = new SingleAssociationNode<X, Y>(pair.key, pair.value);
            } else {
                var iter = list.head;
                while (iter != null) {
                    if (compare(pair.key, iter.key)) {
                        iter.value = pair.value;
                        break;
                    }
                    iter = iter.next;
                }
                if (iter == null) {
                    list.head = new SingleAssociationNode<X, Y>(pair.key, pair.value);
                }
            }
            node = node.next;
        }
        list.length = length;
        return list;
    }
}

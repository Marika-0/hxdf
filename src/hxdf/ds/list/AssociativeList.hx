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
abstract AssociativeList<K, V>(_AssociativeList<K, V>) from _AssociativeList<K, V> {
    /**
        The number of key/value pairs in `this` AssociativeList.
    **/
    public var length(get, never):Int;

    inline function get_length():Int {
        return this.length;
    }

    /**
        Creates a new empty AssociativeList.
    **/
    public inline function new() {
        this = new _AssociativeList<K, V>();
    }

    /**
        Returns the binding of `key`.

        If `key` is not bound to a value, returns `null`.
    **/
    @:arrayAccess public inline function get(key:K):Null<V> {
        return this.get(key);
    }

    /**
        Binds `key` to `value` and returns `value`.

        If `key` is already bound to a value, that binding is overridden.
    **/
    @:arrayAccess public inline function set(key:K, value:V):Void {
        this.set(key, value);
    }

    /**
        Removes the binding of `key` and returns it's value.

        If `key` is not bound, returns `null`, and `this` AssociativeList is
        unchanged.
    **/
    public inline function remove(key:K):Null<V> {
        return this.remove(key);
    }

    /**
        Returns the number of key/value bindings in `this` AssociativeList.
    **/
    public inline function size():Int {
        return this.size();
    }

    /**
        Returns if the given `key` is bound to a value.

        This function does now modify `this` AssociativeList.
    **/
    public inline function exists(key:K):Bool {
        return this.exists(key);
    }

    /**
        Removes the binding of `key` and returns `true` if it existed.

        If `key` is not bound, returns `false`, and `this` AssociativeList is
        unchanged.
    **/
    public inline function delete(key:K):Bool {
        return this.delete(key);
    }

    /**
        Returns an iterator over the values of `this` AssociativeList.
    **/
    public inline function iterator():ValueInputIterator<V> {
        return this.iterator();
    }

    /**
        Returns an iterator over the keys of `this` AssociativeList.
    **/
    public inline function keyIterator():KeyInputIterator<K> {
        return this.keyIterator();
    }

    /**
        Returns an iterator over the key/value pairs of `this` AssociativeList.
    **/
    public inline function keyValueIterator():PairInputIterator<K, V> {
        return this.keyValueIterator();
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f(value)` returns `true`.

        This function does not modify `this` AssociativeList.
    **/
    public inline function filter(f:(V) -> Bool):AssociativeList<K, V> {
        return (this.filter(f) : AssociativeList<K, V>);
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f(key)` returns `true`.

        This function does not modify `this` AssociativeList.
    **/
    public inline function filterKeys(f:(K) -> Bool):AssociativeList<K, V> {
        return (this.filterKeys(f) : AssociativeList<K, V>);
    }

    /**
        Returns a new AssociativeList filtered with function `f`.

        The returned AssociativeList will contain all key/value bindings of
        `this` AssociativeList for which `f({key:K, value:V})` returns `true`.

        This function does not modify `this` AssociativeList.
    **/
    public inline function filterPairs(f:(KeyValuePair<K, V>) -> Bool):AssociativeList<K, V> {
        return (this.filterPairs(f) : AssociativeList<K, V>);
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will retain all its original keys with each
        key/value pair's value binding being set to `f(value)`.
    **/
    public inline function map<S>(f:(V) -> S):AssociativeList<K, S> {
        return (this.map(f) : AssociativeList<K, S>);
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will retain all its original keys with each
        key/value pair's key binding being set to `f(key)`.

        If the mapping function produces collisions, the value bound to the
        collision key is unspecified.
    **/
    public inline function mapKeys<S>(f:(K) -> S):AssociativeList<S, V> {
        return (this.mapKeys(f) : AssociativeList<S, V>);
    }

    /**
        Returns a new AssociativeList mapped with function `f`.

        The returned AssociativeList will contain the key/value pair bindings
        from the output of `f({key:K, value:V})`.

        If the mapping function produces collisions, the value bound to the
        collision key is unspecified.
    **/
    public inline function mapPairs<X, Y>(f:(KeyValuePair<K, V>) -> KeyValuePair<X, Y>):AssociativeList<X, Y> {
        return (this.mapPairs(f) : AssociativeList<X, Y>);
    }

    /**
        Tells if `this` AssociativeList is empty.
    **/
    public inline function isEmpty():Bool {
        return this.isEmpty();
    }

    /**
        Removes all bindings from `this` AssociativeList.

        This function does not traverse the list.
    **/
    public inline function clear():Void {
        this.clear();
    }

    /**
        Returns a shallow copy of `this` AssociativeList.

        The elements are not copied and retain their identity.
    **/
    public inline function copy():AssociativeList<K, V> {
        return (this.copy() : AssociativeList<K, V>);
    }

    /**
        Converts `this` AssociativeList into a string representation.

        Internally, this function calls `Std.string` on each key/value binding
        of `this` AssociativeList.

        The output is formatted to be enclosed by `"{}"`, with each pair in the
        form `"key=value"` and separated by `","`.
    **/
    public inline function toString():String {
        return this.toString();
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class _AssociativeList<K, V> implements AssociativeContainer<K, V> {
    public var length(default, null):Int;

    var head:SingleAssociationNode<K, V>;

    public function new() {
        length = 0;
        head = null;
    }

    public function get(key:K):Null<V> {
        var value:Null<V>;
        find(key, (node) -> value = node.value, () -> value = null);
        return value;
    }

    public function set(key:K, value:V):Void {
        find(key, (node) -> node.value = value, () -> {
            head = new SingleAssociationNode<K, V>(key, value, head);
            length++;
        });
    }

    public function remove(key:K):Null<V> {
        var value:Null<V>;
        findWithParent(key, (node, parent) -> {
            value = node.value;
            length--;
            if (parent == null) {
                head = head.next;
            } else {
                parent.next = node.next;
            }
        }, () -> value = null);
        return value;
    }

    public inline function size():Int {
        return length;
    }

    public inline function exists(key:K):Bool {
        return find(key, (node) -> {}, () -> {});
    }

    public function delete(key:K):Bool {
        return findWithParent(key, (node, parent) -> {
            length--;
            if (parent == null) {
                head = head.next;
            } else {
                parent.next = node.next;
            }
        }, () -> {});
    }

    public inline function iterator():ValueInputIterator<V> {
        return new ValueInputIterator(head);
    }

    public inline function keyIterator():KeyInputIterator<K> {
        return new KeyInputIterator(head);
    }

    public inline function keyValueIterator():PairInputIterator<K, V> {
        return new PairInputIterator(head);
    }

    public inline function filter(f:(V) -> Bool):_AssociativeList<K, V> {
        return internalFilter((node) -> node.value, f);
    }

    public inline function filterKeys(f:(K) -> Bool):_AssociativeList<K, V> {
        return internalFilter((node) -> node.key, f);
    }

    public inline function filterPairs(f:(KeyValuePair<K, V>) -> Bool):_AssociativeList<K, V> {
        return internalFilter((node) -> node.pair, f);
    }

    public inline function map<S>(f:(V) -> S):_AssociativeList<K, S> {
        return internalMap((node) -> new KeyValuePair(node.key, f(node.value)));
    }

    public inline function mapKeys<S>(f:(K) -> S):_AssociativeList<S, V> {
        return internalMap((node) -> new KeyValuePair(f(node.key), node.value));
    }

    public inline function mapPairs<X, Y>(f:(KeyValuePair<K, V>) -> KeyValuePair<X, Y>):_AssociativeList<X, Y> {
        return internalMap(f);
    }

    public inline function isEmpty():Bool {
        return length == 0;
    }

    public function clear():Void {
        length = 0;
        head = null;
    }

    public function copy():_AssociativeList<K, V> {
        var list = new _AssociativeList<K, V>();
        for (pair in keyValueIterator()) {
            list.head = new SingleAssociationNode<K, V>(pair.key, pair.value, list.head);
            list.length++;
        }
        return list;
    }

    public function toString():String {
        if (head == null) {
            return "{}";
        }

        var buf = new StringBuf();
        var node = head;

        inline function addPair(node:SingleAssociationNode<K, V>, buf:StringBuf) {
            buf.add(Std.string(node.key));
            buf.addChar("=".code);
            buf.addChar(">".code);
            buf.add(Std.string(node.value));
        }

        buf.addChar("{".code);
        addPair(node, buf);
        node = node.next;
        while (node != null) {
            buf.addChar(",".code);
            addPair(node, buf);
            node = node.next;
        }
        buf.addChar("}".code);
        return buf.toString();
    }

    inline function compare(a:K, b:K):Bool {
        return hxdf.lambda.Compare.reflectiveEquity(a, b);
    }

    final function find(key:K, operate:(SingleAssociationNode<K, V>) -> Void, failure:() -> Void):Bool {
        var node = head;
        while (node != null) {
            if (compare(node.key, key)) {
                operate(node);
                return true;
            }
            node = node.next;
        }
        failure();
        return false;
    }

    final function findWithParent(key:K, operate:(SingleAssociationNode<K, V>, SingleAssociationNode<K, V>) -> Void, failure:() -> Void):Bool {
        var parent = null;
        var node = head;
        while (node != null) {
            if (compare(node.key, key)) {
                operate(node, parent);
                return true;
            }
            parent = node;
            node = node.next;
        }
        failure();
        return false;
    }

    function internalFilter<T>(process:(SingleAssociationNode<K, V>) -> T, evaluate:(T) -> Bool):_AssociativeList<K, V> {
        var list = new _AssociativeList<K, V>();
        var node = head;
        while (node != null) {
            if (evaluate(process(node))) {
                list.head = new SingleAssociationNode<K, V>(node.key, node.value, list.head);
                list.length++;
            }
            node = node.next;
        }
        return list;
    }

    function internalMap<X, Y>(transform:(KeyValuePair<K, V>) -> KeyValuePair<X, Y>):_AssociativeList<X, Y> {
        var list = new _AssociativeList<X, Y>();
        for (pair in keyValueIterator()) {
            var map = transform(pair);
            list.set(map.key, map.value);
        }
        return list;
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class PairInputIterator<K, V> implements InputIteratorTemplate<KeyValuePair<K, V>> {
    var node:SingleAssociationNode<K, V>;

    public function new(head:SingleAssociationNode<K, V>) {
        node = head;
    }

    public inline function hasNext():Bool {
        return node != null;
    }

    public function next():KeyValuePair<K, V> {
        var pair = node.pair;
        node = node.next;
        return pair;
    }

    public inline function copy():PairInputIterator<K, V> {
        return new PairInputIterator(node);
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class KeyInputIterator<K> implements InputIteratorTemplate<K> {
    var node:SingleAssociationNode<K, Dynamic>;

    public function new(head:SingleAssociationNode<K, Dynamic>) {
        node = head;
    }

    public inline function hasNext():Bool {
        return node != null;
    }

    public function next():K {
        var key = node.key;
        node = node.next;
        return key;
    }

    public inline function copy():KeyInputIterator<K> {
        return new KeyInputIterator(node);
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class ValueInputIterator<V> implements InputIteratorTemplate<V> {
    var node:SingleAssociationNode<Dynamic, V>;

    public function new(head:SingleAssociationNode<Dynamic, V>) {
        node = head;
    }

    public inline function hasNext():Bool {
        return node != null;
    }

    public function next():V {
        var value = node.value;
        node = node.next;
        return value;
    }

    public inline function copy():ValueInputIterator<V> {
        return new ValueInputIterator(node);
    }
}

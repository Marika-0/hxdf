package hxdf.ds.list;

import hxdf.ds.Container.ExtractableContainer;
import hxdf.ds.unit.KeyValuePair;
import hxdf.ds.unit.SingleNode;
import hxdf.lambda.Compare;

/**
    A singly-linked list.
**/
class SingleLinkedList<T> implements ExtractableContainer<T> {
    /**
        The number of items in `this` SingleLinkedList.
    **/
    public var length(default, null):Int;

    var head:SingleNode<T>;
    var tail:SingleNode<T>;

    /**
        Creates a new empty SingleLinkedList.
    **/
    public function new() {
        length = 0;
        head = null;
        tail = null;
    }

    /**
        Adds `item` to the front of `this` SingleLinkedList.
    **/
    public function push(item:T):Void {
        head = new SingleNode<T>(item, head);
        if (tail == null) {
            tail = head;
        }
        length++;
    }

    /**
        Removes the first item from the front of `this` SingleLinkedList and
        returns it.

        If `this` SingleLinkedList is empty, returns null.
    **/
    public function pop():Null<T> {
        if (head == null) {
            return null;
        }
        var x = head.data;
        head = head.next;
        if (head == null) {
            tail = null;
        }
        length--;
        return x;
    }

    /**
        Returns the first item at the front of `this` SingleLinkedList.

        If `this` SingleLinkedList is empty, returns null.
    **/
    public inline function peek():Null<T> {
        return head == null ? null : head.data;
    }

    /**
        Adds `item` to the end of `this` SingleLinkedList.
    **/
    public function unshift(item:T):Void {
        if (head == null) {
            head = tail = new SingleNode<T>(item);
        } else {
            tail = tail.next = new SingleNode<T>(item);
        }
        length++;
    }

    /**
        Returns the first item at the end of `this` SingleLinkedList.

        if `this` SingleLinkedList is empty, retuns null.
    **/
    public inline function spy():Null<T> {
        return tail == null ? null : tail.data;
    }

    /**
        Returns an iterator over the elements of `this` SingleLinkedList.
    **/
    public inline function iterator():UnidirectionalIterator<T> {
        return new UnidirectionalIterator<T>(head);
    }

    /**
        Returns a key-value iterator over the element of `this` SingleLinkedList
        and their positions.

        Equivalent to `indexIterator()`.
    **/
    public inline function keyValueIterator():IndexIterator<T> {
        return new IndexIterator<T>(head);
    }

    /**
        Returns a key-value iterator over the element of `this` SingleLinkedList
        and their positions.

        Equivalent to `keyValueIterator()`.
    **/
    public inline function indexIterator():IndexIterator<T> {
        return keyValueIterator();
    }

    /**
        Returns a new SingleLinkedList containing each element `item` of `this`
        SingleLinkedList for which `f(item)` returns `true`.

        The individual elements are not copied and retain their identity.

        if `f` is null, the result is unspecified.
    **/
    public function filter(f:(T) -> Bool):SingleLinkedList<T> {
        var list = new SingleLinkedList<T>();
        for (item in this) {
            if (f(item)) {
                list.unshift(item);
            }
        }
        return list;
    }

    /**
        Returns a new SingleLinkedList containing each element `item` of `this`
        SingleLinkedList transformed by `f(item)`.

        If `f` is null, the result is unspecified.
    **/
    public function map<S>(f:(T) -> S):SingleLinkedList<S> {
        var list = new SingleLinkedList<S>();
        for (item in this) {
            list.unshift(f(item));
        }
        return list;
    }

    /**
        Removes the first element `item` from `this` SingleLinkedList for which
        `comp(val, item)` returns `true`.

        If `comp` is null, standard equity is used.

        Returns `true` if an element was removed, or `false` otherwise.
    **/
    public function remove(val:T, ?comp:(T, T) -> Bool):Bool {
        if (isEmpty()) {
            return false;
        }

        if (comp == null) {
            comp = Compare.standardEquity;
        }
        if (comp(val, head.data)) {
            if (head == tail) {
                head = tail = null;
            } else {
                head = head.next;
            }
            length--;
            return true;
        }

        var prev = head;
        var node = head.next;
        while (node != null) {
            if (comp(val, node.data)) {
                prev.next = node.next;
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
        Returns `true` if `this` SingleLinkedList is empty, or `false`
        otherwise.
    **/
    public inline function isEmpty():Bool {
        return head == null;
    }

    /**
        Removes all elements from `this` SingleLinkedList.

        This function does not traverse the elements.
    **/
    public function clear():Void {
        head = tail = null;
        length = 0;
    }

    /**
        Creates a copy of `this` SingleLinkedList.

        The elements of `this` SingleLinkedList are not copied and retain their
        identity.
    **/
    public function copy():SingleLinkedList<T> {
        var list = new SingleLinkedList<T>();
        for (item in this) {
            list.unshift(item);
        }
        return list;
    }

    /**
        Converts `this` SingleLinkedList into a string representation.
    **/
    public inline function toString():String {
        return '[${join(",")}]';
    }

    /**
        Converts `this` SingleLinkedList into a string representation where
        each element is separated by `sep`.
    **/
    public function join(sep:String):String {
        if (isEmpty()) {
            return "";
        }
        var buf = new StringBuf();
        var iterator = iterator();
        buf.add(Std.string(iterator.next()));
        while (iterator.hasNext()) {
            buf.add(Std.string(sep));
            buf.add(Std.string(iterator.next()));
        }
        return buf.toString();
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class UnidirectionalIterator<T> implements hxdf.lambda.Iterator.UnidirectionalIterator<T> {
    var node:SingleNode<T>;

    public function new(head:SingleNode<T>) {
        node = head;
    }

    public inline function hasNext():Bool {
        return node != null;
    }

    public function next():T {
        var data = node.data;
        node = node.next;
        return data;
    }

    public function advance(steps:Int):T {
        while (0 < steps--) {
            node = node.next;
        }
        return node.data;
    }

    public inline function value():T {
        return node.data;
    }

    public inline function equals(it:hxdf.lambda.Iterator.SequentialIterator<T>):Bool {
        return node == (cast it).node;
    }

    public inline function copy():UnidirectionalIterator<T> {
        return new UnidirectionalIterator(node);
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class IndexIterator<T> implements hxdf.lambda.Iterator.IndexIterator<T> {
    var node:SingleNode<T>;
    var index:Int;

    public function new(head:SingleNode<T>, pos = 0) {
        node = head;
        index = pos;
    }

    public inline function hasNext():Bool {
        return node != null;
    }

    public function next():KeyValuePair<Int, T> {
        var data = node.data;
        node = node.next;
        return KVPFactory.create(index++, data);
    }

    public function advance(steps:Int):KeyValuePair<Int, T> {
        if (0 < steps) {
            index += steps;
        }
        while (0 < steps--) {
            node = node.next;
        }
        return KVPFactory.create(index, node.data);
    }

    public inline function key():Int {
        return index;
    }

    public inline function position():Int {
        return index;
    }

    public inline function value():T {
        return node.data;
    }

    public inline function pair():KeyValuePair<Int, T> {
        return KVPFactory.create(index, node.data);
    }

    public inline function equals(it:hxdf.lambda.Iterator.SequentialIterator<KeyValuePair<Int, T>>):Bool {
        return index == (cast it).index;
    }

    public inline function copy():IndexIterator<T> {
        return new IndexIterator(node, index);
    }
}

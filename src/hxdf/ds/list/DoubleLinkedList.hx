package hxdf.ds.list;

import hxdf.ds.unit.DoubleNode;
import hxdf.ds.unit.KeyValuePair;
import hxdf.lambda.Iterator.BidirectionalIterator as BidirectionalTemplate;
import hxdf.lambda.Iterator.IndexIterator as IndexTemplate;
import hxdf.lambda.Iterator.SequentialIterator as SequentialTemplate;

class DoubleLinkedList<T> implements hxdf.ds.Container.TraversableContainer<T> implements hxdf.ds.Container.ExtractableContainer<T> {
    public var length(default, null):Int;

    var head:DoubleNode<T>;
    var tail:DoubleNode<T>;

    public function new() {
        length = 0;
        head = null;
        tail = null;
    }

    public function push(item:T):Void {
        head = new DoubleNode<T>(item, head);
        if (tail == null) {
            tail = head;
        } else {
            head.next.prev = head;
        }
        length++;
    }

    public function pop():Null<T> {
        if (head == null) {
            return null;
        }
        var x = head.data;
        head = head.next;
        if (head == null) {
            tail = null;
        } else {
            head.prev = null;
        }
        length--;
        return x;
    }

    public inline function peek():Null<T> {
        return head == null ? null : head.data;
    }

    public function unshift(item:T):Void {
        tail = new DoubleNode<T>(item, null, tail);
        if (head == null) {
            head = tail;
        } else {
            tail.prev.next = tail;
        }
        length++;
    }

    public function shift():Null<T> {
        if (tail == null) {
            return null;
        }
        var x = tail.data;
        tail = tail.prev;
        if (tail == null) {
            head = null;
        } else {
            tail.next = null;
        }
        length--;
        return x;
    }

    public inline function spy():Null<T> {
        return tail == null ? null : tail.data;
    }

    public inline function iterator():BeginIterator<T> {
        return new BeginIterator<T>(head);
    }

    public inline function reverseIterator():EndIterator<T> {
        return new EndIterator<T>(tail);
    }

    public inline function beginIterator():BeginIterator<T> {
        return iterator();
    }

    public inline function endIterator():EndIterator<T> {
        return reverseIterator();
    }

    public inline function keyValueIterator():IndexIterator<T> {
        return new IndexIterator<T>(head);
    }

    public inline function indexIterator():IndexIterator<T> {
        return keyValueIterator();
    }

    public function filter(f:(T) -> Bool):DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        for (item in this) {
            if (f(item)) {
                list.unshift(item);
            }
        }
        return list;
    }

    public function map<S>(f:(T) -> S):DoubleLinkedList<S> {
        var list = new DoubleLinkedList<S>();
        for (item in this) {
            list.unshift(f(item));
        }
        return list;
    }

    public function remove(val:T, ?comp:(T, T) -> Bool):Bool {
        if (isEmpty()) {
            return false;
        }

        if (comp == null) {
            comp = hxdf.lambda.Compare.standardEquity;
        }
        if (comp(val, head.data)) {
            if (head == tail) {
                head = tail = null;
            } else {
                head = head.next;
                head.prev = null;
            }
            length--;
            return true;
        }

        var node = head.next;
        while (node != null) {
            if (comp(val, node.data)) {
                node.prev.next = node.next;
                if (node == tail) {
                    tail = node.prev;
                } else {
                    node.next.prev = node.prev;
                }
                length--;
                return true;
            }
            node = node.next;
        }
        return false;
    }

    public inline function isEmpty():Bool {
        return head == null;
    }

    public function clear():Void {
        head = tail = null;
        length = 0;
    }

    public function copy():DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        for (item in this) {
            list.unshift(item);
        }
        return list;
    }

    public inline function toString():String {
        return '[${join(",")}]';
    }

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
private class BeginIterator<T> implements BidirectionalTemplate<T> {
    var node:DoubleNode<T>;

    public function new(head:DoubleNode<T>) {
        if (head != null) {
            node = new DoubleNode<T>(head.data, head, head);
        }
    }

    public inline function hasNext():Bool {
        return node != null && node.next != null;
    }

    public function next():T {
        node = node.next;
        return node.data;
    }

    public inline function hasPrev():Bool {
        return node != null && node.prev != null && node.next != node.prev;
    }

    public function prev():T {
        node = node.prev;
        return node.data;
    }

    public inline function equals(it:SequentialTemplate<T>):Bool {
        return node == null ? (cast it).node == null : node.next == (cast it).node.next;
    }

    public function copy():BeginIterator<T> {
        var it = new BeginIterator<T>(node);
        it.node = node;
        return it;
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class EndIterator<T> implements BidirectionalTemplate<T> {
    var node:DoubleNode<T>;

    public function new(head:DoubleNode<T>) {
        if (head != null) {
            node = new DoubleNode<T>(head.data, head, head);
        }
    }

    public inline function hasNext():Bool {
        return node != null && node.prev != null;
    }

    public function next():T {
        node = node.prev;
        return node.data;
    }

    public inline function hasPrev():Bool {
        return node != null && node.next != null && node.next != node.prev;
    }

    public function prev():T {
        node = node.next;
        return node.data;
    }

    public inline function equals(it:SequentialTemplate<T>):Bool {
        return node == null ? (cast it).node == null : node.prev == (cast it).node.prev;
    }

    public function copy():EndIterator<T> {
        var it = new EndIterator<T>(node);
        it.node = node;
        return it;
    }
}

@SuppressWarnings(["checkstyle:TypeDocComment", "checkstyle:FieldDocComment"])
private class IndexIterator<T> implements IndexTemplate<T> implements BidirectionalTemplate<KeyValuePair<Int, T>> {
    var index:Int;
    var iterator:BeginIterator<T>;

    public function new(head:DoubleNode<T>) {
        index = 0;
        iterator = new BeginIterator<T>(head);
    }

    public inline function hasNext():Bool {
        return iterator.hasNext();
    }

    public inline function next():KeyValuePair<Int, T> {
        return KVPFactory.create(index++, iterator.next());
    }

    public inline function hasPrev():Bool {
        return iterator.hasPrev();
    }

    public inline function prev():KeyValuePair<Int, T> {
        return KVPFactory.create(--index, iterator.prev());
    }

    public inline function equals(it:SequentialTemplate<KeyValuePair<Int, T>>):Bool {
        return index == (cast it).index;
    }

    public inline function compare(it:IndexTemplate<T>):Int {
        return index - (cast it).index;
    }

    public function copy():IndexIterator<T> {
        var copy = new IndexIterator(null);
        copy.index = index;
        copy.iterator = iterator.copy();
        return copy;
    }
}

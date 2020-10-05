package hxdf.ds.list;

import hxdf.ds.unit.DoubleNode;
import hxdf.ds.unit.KeyValuePair;
import hxdf.lambda.Compare;
import hxdf.lambda.Convert;
import hxdf.lambda.Iterator.BidirectionalIterator as BidirectionalTemplate;
import hxdf.lambda.Iterator.IndexIterator as IndexTemplate;
import hxdf.lambda.Iterator.SequentialIterator as SequentialTemplate;
import hxdf.lambda.Sort;

/**
    A doubly-linked list.
**/
class DoubleLinkedList<T> implements hxdf.ds.Container.TraversableContainer<T> implements hxdf.ds.Container.ExtractableContainer<T> {
    /**
        The number of items in `this` DoubleLinkedList.
    **/
    public var length(default, null):Int;

    var head:DoubleNode<T>;
    var tail:DoubleNode<T>;

    /**
        Creates a new empty DoubleLinkedList.
    **/
    public function new() {
        length = 0;
        head = null;
        tail = null;
    }

    /**
        Adds `item` to the front of `this` DoubleLinkedList.
    **/
    public function push(item:T):Void {
        head = new DoubleNode<T>(item, head);
        if (tail == null) {
            tail = head;
        } else {
            head.next.prev = head;
        }
        length++;
    }

    /**
        Removes the first item from the front of `this` DoubleLinkedList and
        returns it.

        If `this` DoubleLinkedList is empty, returns null.
    **/
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

    /**
        Returns the first item at the front of `this` DoubleLinkedList.

        If `this` DoubleLinkedList is empty, returns null.
    **/
    public inline function peek():Null<T> {
        return head == null ? null : head.data;
    }

    /**
        Adds `item` to the end of `this` DoubleLinkedList.
    **/
    public function unshift(item:T):Void {
        tail = new DoubleNode<T>(item, null, tail);
        if (head == null) {
            head = tail;
        } else {
            tail.prev.next = tail;
        }
        length++;
    }

    /**
        Removes the first item from the end of `this` DoubleLinkedList and
        returns it.

        If `this` DoubleLinkedList is empty, returns null.
    **/
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

    /**
        Returns the first item at the end of `this` DoubleLinkedList.

        if `this` DoubleLinkedList is empty, retuns null.
    **/
    public inline function spy():Null<T> {
        return tail == null ? null : tail.data;
    }

    /**
        Returns a sorted copy of `this` DoubleLinkedList.

        If `f` is unspecified `hxdf.lambda.Compare.reflectiveComparison` is
        used.

        If `ascending` is `true`, the returned DoubleLinkedList is sorted in
        ascending order. Otherwise, it is sorted in descending order.

        The elements of `this` DoubleLinkedList are not copied and retain their
        identity.
    **/
    public function sort(?f:(T, T) -> Int, ascending = true):DoubleLinkedList<T> {
        if (f == null) {
            f = Compare.reflectiveComparison;
        }
        if (!ascending) {
            f = Compare.reverse(f);
        }

        return Convert.toDoubleLinkedList(Sort.mergeSort(this, f));
    }

    /**
        Returns a reversed copy of this DoubleLinkedList.

        The elements of `this` DoubleLinkedList are not copied and retain their
        identity.
    **/
    public function reverse():DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        list.length = length;

        var iterator = iterator();
        if (iterator.hasNext()) {
            list.head = list.tail = new DoubleNode<T>(iterator.next());
        }
        while (iterator.hasNext()) {
            list.head = new DoubleNode<T>(iterator.next(), list.head);
            list.head.next.prev = list.head;
        }

        return list;
    }

    /**
        Returns an iterator over the elements of `this` DoubleLinkedList.
    **/
    public inline function iterator():BeginIterator<T> {
        return new BeginIterator<T>(head);
    }

    /**
        Returns an iterator over the elements of `this` DoubleLinkedList in
        reverse.
    **/
    public inline function reverseIterator():EndIterator<T> {
        return new EndIterator<T>(tail);
    }

    /**
        Returns a bidirectional iterator over the elements of `this`
        DoubleLinkedList.
    **/
    public inline function beginIterator():BeginIterator<T> {
        return iterator();
    }

    /**
        Returns a bidirectional iterator over the elements of `this`
        DoubleLinkedList in reverse.
    **/
    public inline function endIterator():EndIterator<T> {
        return reverseIterator();
    }

    /**
        Returns a key-value iterator over the element of `this` DoubleLinkedList
        and their positions.

        Equivalent to `indexIterator()`.
    **/
    public inline function keyValueIterator():IndexIterator<T> {
        return new IndexIterator<T>(head);
    }

    /**
        Returns a key-value iterator over the element of `this` DoubleLinkedList
        and their positions.

        Equivalent to `keyValueIterator()`.
    **/
    public inline function indexIterator():IndexIterator<T> {
        return keyValueIterator();
    }

    /**
        Returns a new DoubleLinkedList containing each element `item` of `this`
        DoubleLinkedList for which `f(item)` returns `true`.

        The individual elements are not copied and retain their identity.

        if `f` is null, the result is unspecified.
    **/
    public function filter(f:(T) -> Bool):DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        for (item in this) {
            if (f(item)) {
                list.unshift(item);
            }
        }
        return list;
    }

    /**
        Returns a new DoubleLinkedList containing each element `item` of `this`
        DoubleLinkedList transformed by `f(item)`.

        If `f` is null, the result is unspecified.
    **/
    public function map<S>(f:(T) -> S):DoubleLinkedList<S> {
        var list = new DoubleLinkedList<S>();
        for (item in this) {
            list.unshift(f(item));
        }
        return list;
    }

    /**
        Removes the first element `item` from `this` DoubleLinkedList for which
        `comp(val, item)` returns `true`.

        If `comp` is null, standard equity is used.

        Returns `true` if an element was removed, or `false` otherwise.
    **/
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

    /**
        Returns `true` if `this` DoubleLinkedList is empty, or `false`
        otherwise.
    **/
    public inline function isEmpty():Bool {
        return head == null;
    }

    /**
        Removes all elements from `this` DoubleLinkedList.

        This function does not traverse the list, but sets internal references
        to null and `this.length` to `0`.
    **/
    public function clear():Void {
        head = tail = null;
        length = 0;
    }

    /**
        Creates a copy of `this` DoubleLinkedList.

        The elements of `this` DoubleLinkedList are not copied and retain their
        identity.
    **/
    public function copy():DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        for (item in this) {
            list.unshift(item);
        }
        return list;
    }

    /**
        Converts `this` DoubleLinkedList into a string representation.
    **/
    public inline function toString():String {
        return '[${join(",")}]';
    }

    /**
        Converts `this` DoubleLinkedList into a string representation where
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

    public function advance(distance:Int):Bool {
        while (0 < distance && hasNext()) {
            node = node.next;
            --distance;
        }
        return hasNext();
    }

    public inline function hasPrev():Bool {
        return node != null && node.prev != null && node.next != node.prev;
    }

    public function prev():T {
        node = node.prev;
        return node.data;
    }

    public function retreat(distance:Int):Bool {
        while (0 < distance && hasPrev()) {
            node = node.prev;
            --distance;
        }
        return hasNext();
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

    public function advance(distance:Int):Bool {
        while (0 < distance && hasNext()) {
            node = node.prev;
            --distance;
        }
        return hasNext();
    }

    public inline function hasPrev():Bool {
        return node != null && node.next != null && node.next != node.prev;
    }

    public function prev():T {
        node = node.next;
        return node.data;
    }

    public function retreat(distance:Int):Bool {
        while (0 < distance && hasPrev()) {
            node = node.next;
            --distance;
        }
        return hasNext();
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
        return new KeyValuePair(index++, iterator.next());
    }

    public inline function advance(distance:Int):Bool {
        return iterator.advance(distance);
    }

    public inline function hasPrev():Bool {
        return iterator.hasPrev();
    }

    public inline function prev():KeyValuePair<Int, T> {
        return new KeyValuePair(index, iterator.prev());
    }

    public inline function retreat(distance:Int):Bool {
        return iterator.retreat(distance);
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

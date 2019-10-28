package hxdf.ds.list;

import hxdf.ds.Container;
import hxdf.ds.unit.SingleNode;
import hxdf.lambda.unit.SingleNodeIterator;

/**
    A singly-linked list.

    This list supports removal of elements from the end of the list, but does
    so inefficiently. If tail-end removal occurs frequently, consider using a
    `hxdf.ds.list.DoubleLinkedList`.
**/
class SingleLinkedList<T> implements BilateralContainer<T> implements ExtractableContainer<T> {
    /**
        The length of `this` SingleLinkedList.
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
        Adds element `item` to the front of `this` SingleLinkedList and returns
        it.
    **/
    public function push(item:T):T {
        head = new SingleNode<T>(item, head);
        if (tail == null) {
            tail = head;
        }
        length++;
        return item;
    }

    /**
        Removes the first element of `this` SingleLinkedList and returns it.

        If `this` SingleLinkedList is empty, returns `null`.
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
        Adds element `item` to the end of `this` SingleLinkedList and returns
        it.
    **/
    public function unshift(item:T):T {
        if (head == null) {
            tail = head = new SingleNode<T>(item);
        } else {
            tail = tail.next = new SingleNode<T>(item);
        }
        length++;
        return item;
    }

    /**
        Removes the last element of `this` SingleLinkedList and returns it.

        If `this` SingleLinkedList is empty, returns `null`.

        This function iterates over the whole length of `this` SingleLinkedList.
        If it is going to be called often, consider using a
        `hxdf.ds.list.DoubleLinkedList`.
    **/
    public function shift():Null<T> {
        if (head == null) {
            return null;
        }

        var x = tail.data;
        if (head == tail) {
            head = tail = null;
        } else {
            var node = head;
            while (node.next != tail) {
                node = node.next;
            }
            tail = node;
            tail.next = null;
        }
        length--;
        return x;
    }

    /**
        Removes the first instance of `v` tested sequentially against each
        `item` in `this` SingleLinkedList using `comp(v, item)` if `comp` is
        specified, or standard equity otherwise.

        If an item was removed, returns `true`, otherwise returns `false`.
    **/
    public function remove(v:T, ?comp:T->T->Bool):Bool {
        if (comp == null) {
            comp = (v, x) -> v == x;
        }

        var prev:SingleNode<T> = null;
        var node = head;
        while (node != null) {
            if (comp(v, node.data)) {
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
        Tells if `this` SingleLinkedList is empty.
    **/
    public inline function isEmpty():Bool {
        return head == null;
    }

    /**
        Clears all items from `this` SingleLinkedList.

        This function does not traverse the elements, but sets internal
        references to null and `this.length` to 0.
    **/
    public function clear():Void {
        length = 0;
        head = null;
        tail = null;
    }

    /**
        Accesses the first element of `this` SingleLinkedList and returns it.

        If `this` SingleLinkedList is empty, returns `null`.
    **/
    public function first():Null<T> {
        return head == null ? null : head.data;
    }

    /**
        Accesses the last element of `this` SingleLinkedList and returns it.

        If `this` SingleLinkedList is empty, returns `null`.
    **/
    public function last():Null<T> {
        return tail == null ? null : tail.data;
    }

    /**
        Returns an iterator on the elements of `this` SingleLinkedList.
    **/
    public inline function iterator():SingleNodeIterator<T> {
        return new SingleNodeIterator<T>(head);
    }

    /**
        Returns a shallow copy of `this` SingleLinkedList.

        The elements are not copied and retain their identity, such that
        `list.first() == list.copy().first()` is true, but `list == list.copy()`
        is false.
    **/
    public function copy():SingleLinkedList<T> {
        var list = new SingleLinkedList<T>();
        if (head != null) {
            list.head = new SingleNode<T>(head.data);
            var node = list.head;
            var it = iterator();
            it.next();
            while (it.hasNext()) {
                node = node.next = new SingleNode<T>(it.next());
            }
            list.tail = node;
            list.length = length;
        }
        return list;
    }

    /**
        Creates a new SingleLinkedList by appending a copy of `list` to a copy
        of `this` SingleLinkedList.

        This operation does not modify `list` or `this` SingleLinkedList.

        The length of the returned SingleLinkedList is equal to the sum of
        `this.length` and `l.length`.

        If `list` is null, the result is unspecified.
    **/
    public function concat(list:SingleLinkedList<T>):SingleLinkedList<T> {
        if (head == null) {
            return list.copy();
        }
        var conc = copy();
        conc.length += list.length;
        conc.tail.next = list.copy().head;
        return conc;
    }

    /**
        Returns a new SingleLinkedList filtered with function `f`.

        The returned SingleLinkedList will contain all elements of `this`
        SingleLinkedList for which `f(element)` returns `true`, preserving the
        order of elements.

        This function does not modify `this` SingleLinkedList.

        If `f` is null, the result is unspecified.
    **/
    public function filter(f:T->Bool):SingleLinkedList<T> {
        var list = new SingleLinkedList<T>();
        for (item in iterator()) {
            if (f(item)) {
                inline list.unshift(item);
            }
        }
        return list;
    }

    /**
        Returns a new SingleLinkedList mapped with function `f`.

        The returned SingleLinkedList will contain the output of `f(element)` on
        each element of `this` SingleLinkedList, preserving the order of
        elements.

        If `f` is null, the result is unspecified.
    **/
    public function map<S>(f:T->S):SingleLinkedList<S> {
        var list = new SingleLinkedList<S>();
        if (head != null) {
            list.head = new SingleNode<S>(f(head.data));
            var node = list.head;
            var it = iterator();
            it.next();
            while (it.hasNext()) {
                node = node.next = new SingleNode<S>(f(it.next()));
            }
            list.tail = node;
            list.length = length;
        }
        return list;
    }

    /**
        Converts `this` SingleLinkedList into a String representation.

        Internally, this function calls `Std.string` on each element of `this`
        SingleLinkedList.

        The output is formatted to be enclosed by `"[]"`, with each element
        separated by `","`.
    **/
    public inline function toString():String {
        return '[${join(",")}]';
    }

    /**
        Converts `this` SingleLinkedList into a String representation where each
        element is separated by `sep`.

        Internally, this function calls `Std.string` on each element of `this`
        SingleLinkedList.
    **/
    public function join(sep:String):String {
        var buf = new StringBuf();
        var it = iterator();
        while (it.hasNext()) {
            buf.add(Std.string(it.next()));
            if (it.hasNext()) {
                buf.add(sep);
            }
        }
        return buf.toString();
    }
}

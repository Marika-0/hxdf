package hxdf.ds.list;

import hxdf.ds.Container.BilateralContainer;
import hxdf.ds.Container.ExtractableContainer;
import hxdf.ds.unit.DoubleNode;
import hxdf.lambda.unit.BackwardsDoubleNodeIterator;
import hxdf.lambda.unit.ForwardsDoubleNodeIterator;

/**
    A doubly-linked list.

    Supports arbitrary adding and removing elements from both ends, and
    iterating in either direction along the list.
**/
class DoubleLinkedList<T> implements BilateralContainer<T> implements ExtractableContainer<T> {
    /**
        The length of `this` DoubleLinkedList.
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
        Adds element `item` to the front of `this` DoubleLinkedList and returns
        it.
    **/
    public function push(item:T):T {
        if (head == null) {
            head = tail = new DoubleNode<T>(item);
        } else {
            head = head.prev = new DoubleNode<T>(item, head);
        }
        length++;
        return item;
    }

    /**
        Removes the first element of `this` DoubleLinkedList and returns it.

        If `this` DoubleLinkedList is empty, returns `null`.
    **/
    public function pop():Null<T> {
        if (head == null) {
            return null;
        }
        var x = head.data;
        if (head == tail) {
            head = tail = null;
        } else {
            head = head.next;
            head.prev = null;
        }
        length--;
        return x;
    }

    /**
        Adds element `item` to the end of `this` DoubleLinkedList and returns
        it.
    **/
    public function unshift(item:T):T {
        if (head == null) {
            tail = head = new DoubleNode<T>(item);
        } else {
            tail = tail.next = new DoubleNode<T>(item, null, tail);
        }
        length++;
        return item;
    }

    /**
        Removes the last element of `this` DoubleLinkedList and returns it.

        If `this` DoubleLinkedList is empty, returns `null`.
    **/
    public function shift():Null<T> {
        if (head == null) {
            return null;
        }
        var x = tail.data;
        if (head == tail) {
            head = tail = null;
        } else {
            tail = tail.prev;
            tail.next = null;
        }
        length--;
        return x;
    }

    /**
        Removes the first instance of `v` tested sequentially against each
        `item` in `this` DoubleLinkedList using `comp(v, item)` if `comp` is
        specified, or standard equity otherwise.

        If an item was removed, returns `true`, otherwise returns `false`.
    **/
    public function remove(v:T, ?comp:T->T->Bool):Bool {
        if (comp == null) {
            comp = (v, x) -> v == x;
        }

        var node = head;
        while (node != null) {
            if (comp(v, node.data)) {
                if (head == tail) {
                    head = tail = null;
                } else if (node == head) {
                    head = head.next;
                    head.prev = null;
                } else if (node == tail) {
                    tail = tail.prev;
                    tail.next = null;
                } else {
                    node.prev.next = node.next;
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
        Tells if `this` DoubleLinkedList is empty.
    **/
    public inline function isEmpty():Bool {
        return head == null;
    }

    /**
        Clears all items from `this` DoubleLinkedList.

        This function does not traverse the elements, but sets internal
        references to null and `this.length` to 0.
    **/
    public function clear():Void {
        length = 0;
        head = null;
        tail = null;
    }

    /**
        Accesses the first element of `this` DoubleLinkedList and returns it.

        If `this` DoubleLinkedList is empty, returns `null`.
    **/
    public function first():Null<T> {
        return head == null ? null : head.data;
    }

    /**
        Accesses the last element of `this` DoubleLinkedList and returns it.

        If `this` DoubleLinkedList is empty, returns `null`.
    **/
    public function last():Null<T> {
        return tail == null ? null : tail.data;
    }

    /**
        Returns an iterator on the elements of `this` DoubleLinkedList going
        from head to tail.
    **/
    public inline function iterator():ForwardsDoubleNodeIterator<T> {
        return new ForwardsDoubleNodeIterator<T>(head);
    }

    /**
        Returns an iterator on the elements of `this` DoubleLinkedList going
        from tail to head.
    **/
    public inline function reverseIterator():BackwardsDoubleNodeIterator<T> {
        return new BackwardsDoubleNodeIterator<T>(tail);
    }

    /**
        Returns a shallow copy of `this` DoubleLinkedList.

        The elements are not copied and retain their identity, such that
        `list.first() == list.copy().first()` is true, but `list == list.copy()`
        is false.
    **/
    public function copy():DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        if (head != null) {
            list.head = new DoubleNode<T>(head.data);
            var node = list.head;
            var it = iterator();
            it.next();
            while (it.hasNext()) {
                node = node.next = new DoubleNode<T>(it.next(), null, node);
            }
            list.tail = node;
            list.length = length;
        }
        return list;
    }

    /**
        Creates a new DoubleLinkedList by appending a copy of `list` to a copy
        of `this` DoubleLinkedList.

        This operation does not modify `list` or `this` DoubleLinkedList.

        The length of the returned DoubleLinkedList is equal to the sum of
        `this.length` and `l.length`.

        If `list` is null, the result is unspecified.
    **/
    public function concat(list:DoubleLinkedList<T>):DoubleLinkedList<T> {
        if (head == null) {
            return list.copy();
        }
        var conc = copy();
        if (list.head != null) {
            conc.length += list.length;
            conc.tail.next = list.copy().head;
            conc.tail.next.prev = conc.tail;
        }
        return conc;
    }

    /**
        Returns a new DoubleLinkedList filtered with function `f`.

        The returned DoubleLinkedList will contain all elements of `this`
        DoubleLinkedList for which `f(element)` returns `true`, preserving the
        order of elements.

        This function does not modify `this` DoubleLinkedList.

        if `f` is null, the result is unspecified.
    **/
    public function filter(f:T->Bool):DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        for (item in iterator()) {
            if (f(item)) {
                inline list.unshift(item);
            }
        }
        return list;
    }

    /**
        Returns a new DoubleLinkedList mapped with function `f`.

        The returned DoubleLinkedList will contain the output of `f(element)` on
        each element of `this` DoubleLinkedList, preserving the order of
        elements.

        if `f` is null, the result is unspecified.
    **/
    public function map<S>(f:T->S):DoubleLinkedList<S> {
        var list = new DoubleLinkedList<S>();
        if (head != null) {
            list.head = new DoubleNode<S>(f(head.data));
            var node = list.head;
            var it = iterator();
            it.next();
            while (it.hasNext()) {
                node = node.next = new DoubleNode<S>(f(it.next()), null, node);
            }
            list.tail = node;
            list.length = length;
        }
        return list;
    }

    /**
        Converts `this` DoubleLinkedList into a String representation.

        Internally, this function calls `Std.string` on each element of `this`
        DoubleLinkedList.

        The output is formatted to be enclosed by `"[]"` with each element
        separated by `","`.
    **/
    public inline function toString():String {
        return '[${join(",")}]';
    }

    /**
        Converts `this` DoubleLinkedList into a String representation where each
        element is separated by `sep`.

        Internally, this function calls `Std.string` on each element of `this`
        DoubleLinkedList.
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

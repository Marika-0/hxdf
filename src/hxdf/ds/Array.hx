package hxdf.ds;

import hxdf.ds.Container;
import hxdf.lambda.BackwardsArrayIterator;
import hxdf.lambda.ForwardsArrayIterator;

/**
    A naive wrapping of `std.Array`.
**/
@:access(hxdf.ds._Array)
abstract Array<T>(_Array<T>) from _Array<T> to _Array<T> {
    /**
        The number of allocated elements in `this` Array.
    **/
    public var length(get, never):Int;

    inline function get_length() {
        return this.length;
    }

    /**
        The number of allocated elements in the underlying array data.

        While `length < capacity` is true, pushing to `this` Array is guaranteed
        to not resize the underlying array data.
    **/
    public var capacity(get, never):Int;

    inline function get_capacity() {
        return this.capacity;
    }

    @:from static function from_Array<T>(array:std.Array<T>):Array<T> {
        var arr = new _Array<T>();
        arr.array = array;
        arr.length = array.length;
        return arr;
    }

    @:to function to_Array():std.Array<T> {
        this.shrink();
        return this.array;
    }

    /**
        Creates a new Array with `amount` elements assigned as `x`.
    **/
    public static inline function fill<T>(x:T, amount:Int):Array<T> {
        return _Array.fill(x, amount);
    }

    /**
        Creates a new empty Array.
    **/
    public inline function new() {
        this = new _Array<T>();
    }

    /**
        Adds `item` to the end of `this` Array.
    **/
    public inline function push(item:T):T {
        return this.push(item);
    }

    /**
        Removes the last item from `this` Array and returns it.

        Returns null if `this` Array is empty.

        This function will naively shrink the underlying array data to fit the
        length of `this` Array.
    **/
    public inline function pop():Null<T> {
        return this.pop();
    }

    /**
        Adds `item` to the end of `this` Array.
    **/
    public inline function unshift(item:T):T {
        return this.unshift(item);
    }

    /**
        Removes the first item from `this` Array and returns it.

        Returns null if `this` Array is empty.

        This function will naively shrink the underlying array data to fit the
        length of `this` Array.
    **/
    public inline function shift():Null<T> {
        return this.shift();
    }

    /**
        Returns the first item of `this` Array, or null if `this` Array is
        empty.
    **/
    public inline function first():Null<T> {
        return this.first();
    }

    /**
        Returns the last item of `this` Array, or null if `this` Array is empty.
    **/
    public inline function last():Null<T> {
        return this.last();
    }

    /**
        Returns the element at position `index` of `this` Array.

        If `index` is outside the bounds of `[0, length)`, the result is
        undefined.
    **/
    @:arrayAccess public inline function get(index:Int):T {
        return this.get(index);
    }

    /**
        Sets the element at position `index` of `this` Array to `value` and
        returns it.

        If `index` is outside the bounds of `[0, length)`, the result is
        undefined.
    **/
    @:arrayAccess public inline function set(index:Int, value:T):T {
        return this.set(index, value);
    }

    /**
        Resizes the underlying array data to have the capacity for a minimum of
        `size` number of elements when pushing before needing to resize again.
    **/
    public inline function reserve(size:Int):Void {
        this.reserve(size);
    }

    /**
        Resizes the underlying array data to `size` number of elements,
        potentially slicing off trailing elements.
    **/
    public inline function resize(size:Int):Void {
        this.resize(size);
    }

    /**
        Resizes the underlying array data to perfectly fit `length`.
    **/
    public inline function shrink():Void {
        this.shrink();
    }

    /**
        Removes the first instance of `v` tested sequentially against each
        `item` in `this` Array using `comp(v, item)` if `comp` is specified, or
        standard equity otherwise.

        If an item was removed, returns `true`, otherwise returns `false`.
    **/
    public inline function remove(v:T, ?comp:T->T->Bool):Bool {
        return this.remove(v, comp);
    }

    /**
        Returns if `this` Array is empty.

        Equivalent to `length == 0`.
    **/
    public inline function isEmpty():Bool {
        return this.isEmpty();
    }

    /**
        Removes all elements of `this` Array by removing internal references
        and setting `length` (and `capacity`) to zero.
    **/
    public inline function clear():Void {
        this.clear();
    }

    /**
        "Removes" all elements of `this` Array by setting `length` to zero.

        Internal references and `capacity` remain such that `reserve()` does not
        need to be calle.
    **/
    public inline function dump():Void {
        this.dump();
    }

    /**
        Returns an iterator over the elements of `this` Array.
    **/
    public inline function iterator():Iterator<T> {
        return this.iterator();
    }

    /**
        Returns an iterator over the elements of `this` Array running from end
        to front.
    **/
    public inline function reverseIterator():Iterator<T> {
        return this.reverseIterator();
    }

    /**
        Returns a shallow copy of `this` Array.

        The elements are not copied and retain their identity.
    **/
    public inline function copy():Array<T> {
        return this.copy();
    }

    /**
        Returns a new Array by appending the elements of `array` to the elements
        of `this` Array.
    **/
    public inline function concat(array:Array<T>):Array<T> {
        return this.concat(array);
    }

    /**
        Returns a new Array of every `item` in `this` Array where `f(item)`
        returned `true`.
    **/
    public inline function filter(f:T->Bool):Array<T> {
        return this.filter(f);
    }

    /**
        Returns a new Array of every `item` in `this` Array which has been
        mapped through `f(item)`.
    **/
    public inline function map<S>(f:T->S):Array<S> {
        return this.map(f);
    }

    /**
        Converts `this` Array into a String representation.

        Internally, this function calls `Std.string` on each element of `this`
        Array.

        The output is formatted to be enclosed by `"[]"` with each element
        separated by `","`.
    **/
    public inline function toString():String {
        return this.toString();
    }

    /**
        Converts `this` DoubleLinkedList into a String representation where each
        element is separated by `sep`.

        Internally, this function calls `Std.string` on each element of `this`
        DoubleLinkedList.
    **/
    public inline function join(sep:String):String {
        return this.join(sep);
    }
}

private class _Array<T> implements RandomAccessContainer<T> implements ExtractableContainer<T> {
    public var length(default, null):Int;

    public var capacity(get, null):Int;

    var array:std.Array<T>;

    public function get_capacity():Int {
        return array.length;
    }

    public static function fill<T>(x:T, amount:Int):_Array<T> {
        var array = new _Array<T>();
        array.reserve(amount);
        while (array.length < amount) {
            inline array.push(x);
        }
        return array;
    }

    public function new() {
        array = new std.Array<T>();
        length = 0;
    }

    public function push(item:T):T {
        if (length < capacity) {
            array[length] = item;
        } else {
            array.push(item);
        }
        length++;
        return item;
    }

    public function pop():Null<T> {
        if (capacity != length) {
            shrink();
        }
        length--;
        return array.pop();
    }

    public function unshift(item:T):T {
        array.unshift(item);
        length++;
        return item;
    }

    public function shift():Null<T> {
        if (capacity != length) {
            shrink();
        }
        length--;
        return array.shift();
    }

    public function first():Null<T> {
        if (isEmpty()) {
            return null;
        }
        return array[0];
    }

    public function last():Null<T> {
        if (isEmpty()) {
            return null;
        }
        return array[length - 1];
    }

    public inline function get(index:Int):T {
        return array[index];
    }

    public inline function set(index:Int, value:T):T {
        return array[index] = value;
    }

    public function reserve(size:Int):Void {
        if (capacity < size) {
            array.resize(size);
        }
    }

    public function resize(size:Int):Void {
        array.resize(size);
        if (capacity < length) {
            length = capacity;
        }
    }

    public function shrink():Void {
        array.resize(length);
    }

    public function remove(v:T, ?comp:T->T->Bool):Bool {
        if (comp == null) {
            if (array.remove(v)) {
                length--;
                return true;
            }
            return false;
        }

        var index = 0;
        while (index < length) {
            if (comp(v, array[index])) {
                array.splice(index, 1);
                length--;
                return true;
            }
            index++;
        }
        return false;
    }

    public inline function isEmpty():Bool {
        return length == 0;
    }

    public inline function clear():Void {
        array = new std.Array<T>();
        length = 0;
    }

    public inline function dump():Void {
        length = 0;
    }

    public inline function iterator():Iterator<T> {
        return new ForwardsArrayIterator(this);
    }

    public inline function reverseIterator():Iterator<T> {
        return new BackwardsArrayIterator(this);
    }

    public function copy():_Array<T> {
        var copy = new _Array<T>();
        copy.array = array.slice(0, length);
        copy.length = length;
        return copy;
    }

    public function concat(arr:_Array<T>):_Array<T> {
        var concat = new _Array<T>();
        concat.array = array.copy().splice(0, length).concat(arr.array.copy().splice(0, arr.length));
        concat.length = concat.array.length;
        return concat;
    }

    public function filter(f:T->Bool):_Array<T> {
        var filter = new _Array<T>();
        filter.array = array.filter(f);
        filter.length = filter.array.length;
        return filter;
    }

    public function map<S>(f:T->S):_Array<S> {
        var map = new _Array<S>();
        map.array = array.map(f);
        map.length = length;
        return map;
    }

    public inline function toString():String {
        return '[${join(",")}]';
    }

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

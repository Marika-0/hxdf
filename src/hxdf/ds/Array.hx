package hxdf.ds;

import hxdf.ds.Container;

private class Array<T> implements RandomAccessContainer<T> {
    public var length(default, null):Int;

    public var capacity(get, null):Int;

    var array(null, null):std.Array<T>;

    public function get_capacity():Int {
        return array.length;
    }

    public static function filled<T>(x:T, num:Int):Array<T> {
        var array = new Array<T>();
        while (array.length < num) {
            array.push(x);
        }
        return array;
    }

    public static function fromIterator<T>(it:Iterator<T>):Array<T> {
        var array = new Array<T>();
        while (it.hasNext()) {
            array.push(it.next());
        }
        return array;
    }

    public inline function new() {
        array = new std.Array<T>();
        length = 0;
    }

    public inline function push(item:T):T {
        if (length < capacity) {
            array[++length] = item;
        } else {
            array.push(item);
        }
        return item;
    }

    public inline function pop():Null<T> {
        if (isEmpty()) {
            return null;
        }
        var x = array[--length];
        array.pop();
        return x;
    }

    public inline function unshift(item:T):T {
        array.unshift(item);
        length++;
        return item;
    }

    public inline function shift():Null<T> {
        if (!isEmpty()) {
            length--;
        }
        return array.shift();
    }

    public inline function resize(size:Int):Void {
        array.resize(size);
        if (capacity < length) {
            length = capacity;
        }
    }

    public function reserve(size:Int):Void {
        if (capacity < size) {
            array.resize(size);
        }
    }

    public inline function shrink():Void {
        array.resize(length);
    }

    public function remove(v:T, ?comp:T->T->Bool):Bool {
        if (comp == null) {
            comp = (v, x) -> v == x;
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
        return array[length];
    }

    public function get(index:Int):T {
        return array[index];
    }

    public function set(index:Int, value:T):T {
        return array[index] = value;
    }

    public function iterator():Iterator<T> {
        return new ForwardsArrayIterator(this);
    }

    public function backwardsIterator():Iterator<T> {
        return new BackwardsArrayIterator(this);
    }

    public function copy():Array<T> {
        var array = new Array<T>();
        array.array = array.splice(0, length);
        array.length = array.array.length;
        return array;
    }

    public function concat(array:Array<T>):Array<T> {
        var array = new Array<T>();
        array.array = this.array.splice(0, length).concat(array.array.splice(0, array.length));
        array.length = array.array.length;
        return array;
    }

    public function filter(f:T->Bool):Array<T> {
        var array = new Array<T>();
        for (item in iterator()) {
            if (f(item)) {
                #if haxe4 inline #end array.push(item);
            }
        }
        return array;
    }

    public function map<S>(f:T->S):Array<S> {
        var array = new Array<S>();
        for (item in iterator()) {
            #if haxe4 inline #end array.push(f(item));
        }
        return array;
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

class ForwardsArrayIterator<T> {
    var array:Array<T>;
    var index:Int;

    public function new(array:Array<T>) {
        this.array = array;
        index = 0;
    }

    public function hasNext():Bool {
        return index < array.length;
    }

    public function next():T {
        return array.get(index++);
    }
}

class BackwardsArrayIterator<T> {
    var array:Array<T>;
    var index:Int;

    public function new(array:Array<T>) {
        this.array = array;
        index = array.length;
    }

    public function hasNext():Bool {
        return 0 < index;
    }

    public function next():T {
        return array.get(--index);
    }
}

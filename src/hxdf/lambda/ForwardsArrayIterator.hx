package hxdf.lambda;

import hxdf.ds.Array;

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

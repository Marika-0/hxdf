package hxdf.lambda;

import hxdf.ds.Array;

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

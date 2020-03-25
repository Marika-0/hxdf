package hxdf.ds.unit;

/**
    A key/value pair.
**/
class KeyValuePair<K, V> {
    /**
        The key of `this` KeyValuePair.
    **/
    public var key:K;

    /**
        The value of `this` KeyValuePair.
    **/
    public var value:V;

    /**
        Creates a new KeyValuePair with key `key` and value `value`.
    **/
    public inline function new(key:K, value:V) {
        this.key = key;
        this.value = value;
    }
}

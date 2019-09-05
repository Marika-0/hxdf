package hxdf.ds.unit;

/**
    Represents a key/value pair.

    Used internally instead of specifying an anonymous object.
**/
typedef KeyValuePair<K, V> = {
    var key:K;
    var value:V;
}

/**
    A factory for creating KeyValuePair instances.
**/
class KVPFactory {
    /**
        Creates a new KeyValuePair with given key `k` and value `v`.
    **/
    public static inline function create<K, V>(k:K, v:V):KeyValuePair<K, V> {
        return {
            key: k,
            value: v
        };
    }
}

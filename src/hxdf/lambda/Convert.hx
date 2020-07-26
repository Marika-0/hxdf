package hxdf.lambda;

import hxdf.ds.Container.SequentialContainer;
import hxdf.ds.list.DoubleLinkedList;
import hxdf.ds.list.SingleLinkedList;

/**
    Various conversions between datastructure types.
**/
class Convert {
    /**
        Converts `container` into a `hxdf.ds.list.SingleLinkedList`.

        The elements of `container` are not copied and retain their identity.
    **/
    public static function toSingleLinkedList<T>(container:SequentialContainer<T>):SingleLinkedList<T> {
        var list = new SingleLinkedList<T>();
        for (item in container) {
            list.unshift(item);
        }
        return list;
    }

    /**
        Converts `container` into a `hxdf.ds.list.DoubleLinkedList`.

        The elements of `container` are not copied and retain their identity.
    **/
    public static function toDoubleLinkedList<T>(container:SequentialContainer<T>):DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        for (item in container) {
            list.unshift(item);
        }
        return list;
    }
}

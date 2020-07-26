package hxdf.lambda;

import hxdf.ds.Container.SequentialContainer;
import hxdf.ds.list.DoubleLinkedList;
import hxdf.ds.list.SingleLinkedList;
import hxdf.ds.unit.DoubleNode;
import hxdf.ds.unit.SingleNode;

class Convert {
    @:access(hxdf.ds.list.SingleLinkedList)
    public static function toSingleLinkedList<T>(container:SequentialContainer<T>):SingleLinkedList<T> {
        var list = new SingleLinkedList<T>();
        for (item in container) {
            list.unshift(item);
        }
        return list;
    }

    @:access(hxdf.ds.list.DoubleLinkedList)
    public static function toDoubleLinkedList<T>(container:SequentialContainer<T>):DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        for (item in container) {
            list.unshift(item);
        }
        return list;
    }
}

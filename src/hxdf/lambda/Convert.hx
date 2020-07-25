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
        list.length = container.length;

        var iterator = container.iterator();
        if (iterator.hasNext()) {
            list.head = list.tail = new SingleNode<T>(iterator.next());
        }
        while (iterator.hasNext()) {
            list.head = new SingleNode<T>(iterator.next(), list.head);
        }

        return list;
    }

    @:access(hxdf.ds.list.DoubleLinkedList)
    public static function toDoubleLinkedList<T>(container:SequentialContainer<T>):DoubleLinkedList<T> {
        var list = new DoubleLinkedList<T>();
        list.length = container.length;

        var iterator = container.iterator();
        if (iterator.hasNext()) {
            list.head = list.tail = new DoubleNode<T>(iterator.next());
        }
        while (iterator.hasNext()) {
            list.tail.prev.next = list.tail = new DoubleNode<T>(iterator.next(), null, list.tail);
        }

        return list;
    }
}

package test.lambda;

import hxdf.ds.Container.SequentialContainer;
import hxdf.ds.list.SingleLinkedList;
import hxdf.ds.list.DoubleLinkedList;
import hxdf.lambda.Convert;
import hxdf.lambda.Iterator;

class ConvertTests extends hxtf.TestObject {
    public function new() {
        test_sequentialConversion();
    }

    function test_sequentialConversion():Void {
        var containers = new Array<SequentialContainer<Dynamic>>();

        var valuesA = [42, 37, 99, 0, 19, 84, 21];
        var valuesB = ["Hello", "world", "test"];
        var valuesC = [];



        var singleLinkedListA = new SingleLinkedList<Int>();
        var singleLinkedListB = new SingleLinkedList<String>();
        var singleLinkedListC = new SingleLinkedList<Dynamic>();
        var doubleLinkedListA = new DoubleLinkedList<Int>();
        var doubleLinkedListB = new DoubleLinkedList<String>();
        var doubleLinkedListC = new DoubleLinkedList<Dynamic>();

        for (value in valuesA) {
            singleLinkedListA.unshift(value);
            doubleLinkedListA.unshift(value);
        }
        for (value in valuesB) {
            singleLinkedListB.unshift(value);
            doubleLinkedListB.unshift(value);
        }
        for (value in valuesC) {
            singleLinkedListC.unshift(value);
            doubleLinkedListC.unshift(value);
        }

        containers.push(singleLinkedListA);
        containers.push(singleLinkedListB);
        containers.push(singleLinkedListC);
        containers.push(doubleLinkedListA);
        containers.push(doubleLinkedListB);
        containers.push(doubleLinkedListC);

        test_toSingleLinkedList(containers);
        test_toDoubleLinkedList(containers);
    }

    function test_toSingleLinkedList(containers:Array<SequentialContainer<Dynamic>>):Void {
        var index = 0;
        for (container in containers) {
            assert(container.toString() == Convert.toSingleLinkedList(container).toString(), "container " + index);
            index++;
        }
    }

    function test_toDoubleLinkedList(containers:Array<SequentialContainer<Dynamic>>):Void {
        var index = 0;
        for (container in containers) {
            assert(container.toString() == Convert.toDoubleLinkedList(container).toString(), "container " + index);
            index++;
        }
    }
}

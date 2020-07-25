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
        inline function runConversion<T>(values:Array<T>, f:(SequentialContainer<T>)->SequentialContainer<T>):Array<SequentialContainer<T>> {
            var singleLinkedList = new SingleLinkedList<T>();
            var doubleLinkedList = new DoubleLinkedList<T>();

            for (value in values) {
                singleLinkedList.push(value);
                doubleLinkedList.push(value);
            }

            var array = new Array<SequentialContainer<T>>();
            array.push(f(singleLinkedList));
            array.push(f(doubleLinkedList));

            return array;
        }

        inline function testEquities<T>(containers:Array<SequentialContainer<T>>, values:Array<T>, note:String):Void {
            var iterators = new Array<Iterator<T>>();
            {
                // Test that all containers are the right length.
                var index = 0;
                for (container in containers) {
                    assert(container.length == values.length, note + ", container: " + index);
                    iterators.push(container.iterator());
                    index++;
                }
            }

            {
                // Test that all container values are correct.
                for (value in values) {
                    var index = -1;
                    for (iterator in iterators) {
                        index++;
                        assert(iterator.hasNext(), note + ", container: " + index + ", value: " + value);
                        if (!iterator.hasNext()) {
                            continue;
                        }
                        assert(value == iterator.next(), note + ", container: " + index + ", value: " + value);
                    }
                }
            }

            {
                // Extra test that iterators complete correctly (ie containers are the right length, again).
                var index = 0;
                for (iterator in iterators) {
                    assert(!iterator.hasNext(), note + ", container: " + index);
                    index++;
                }
            }
        }

        var valuesA = [42, 37, 99, 0, 19, 84, 21];
        var valuesB = ["Hello", "world", "test"];
        var valuesC = [];

        testEquities(runConversion(valuesA, Convert.toSingleLinkedList), valuesA, "Lists: A");
        testEquities(runConversion(valuesB, Convert.toSingleLinkedList), valuesB, "Lists: B");
        testEquities(runConversion(valuesC, Convert.toSingleLinkedList), valuesC, "Lists: C");
    }
}

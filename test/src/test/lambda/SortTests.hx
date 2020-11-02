package test.lambda;

import hxdf.ds.list.SingleLinkedList;
import hxdf.ds.list.DoubleLinkedList;
import hxdf.lambda.Sort;

class SortTests extends hxtf.TestObject {
    public function new() {
        test_mergeSort();
    }

    function test_mergeSort():Void {
        var list = new SingleLinkedList<Int>();
        var result = new SingleLinkedList<Int>();

        Sort.mergeSort(list, result);
        assert(result.toString() == "[]");
        result.clear();

        list.push(42);
        Sort.mergeSort(list, result);
        assert(result.toString() == "[42]");
        result.clear();

        list.push(37);
        Sort.mergeSort(list, result);
        assert(result.toString() == "[37,42]");
        result.clear();
        Sort.mergeSort(list, result, true);
        assert(result.toString() == "[42,37]");
        result.clear();

        list.push(99);
        Sort.mergeSort(list, result);
        assert(result.toString() == "[37,42,99]");
        result.clear();
        Sort.mergeSort(list, result, true);
        assert(result.toString() == "[99,42,37]");
        result.clear();

        list.push(7);
        list.push(66);
        list.push(31);
        list.push(95);
        list.push(12);
        list.push(74);
        list.push(41);
        list.push(21);
        Sort.mergeSort(list, result);
        assert(result.toString() == "[7,12,21,31,37,41,42,66,74,95,99]");
        result.clear();
        Sort.mergeSort(list, result, true);
        assert(result.toString() == "[99,95,74,66,42,41,37,31,21,12,7]");
        result.clear();
    }
}

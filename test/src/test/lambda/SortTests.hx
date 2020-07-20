package test.lambda;

import hxdf.ds.list.SingleLinkedList;
import hxdf.lambda.Sort;

class SortTests extends hxtf.TestObject {
    public function new() {
        test_mergeSort();
    }

    function test_mergeSort():Void {
        var list = new SingleLinkedList<Int>();
        assert(Sort.mergeSort(list).toString() == "[]");

        list.push(42);
        assert(Sort.mergeSort(list).toString() == "[42]");

        list.push(37);
        assert(Sort.mergeSort(list).toString() == "[37,42]");

        list.push(99);
        assert(Sort.mergeSort(list).toString() == "[37,42,99]");

        list.push(7);
        list.push(66);
        list.push(31);
        list.push(95);
        list.push(12);
        list.push(74);
        list.push(41);
        list.push(21);
        assert(Sort.mergeSort(list).toString() == "[7,12,21,31,37,41,42,66,74,95,99]");

        list.clear();
        list.push(52);
        list.push(45);
        list.push(11);
        list.push(26);
        list.push(39);
        list.push(0);
        list.push(98);
        list.push(55);
        list.push(26);
        list.push(23);
        list.push(53);
        list.push(27);
        list.push(89);
        assert(Sort.mergeSort(list).toString() == "[0,11,23,26,26,27,39,45,52,53,55,89,98]");
    }
}

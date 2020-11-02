package hxdf.lambda;

import hxdf.ds.Container.SequentialContainer;
import hxdf.ds.list.SingleLinkedList;

/**
    Functions for sorting containers.
**/
class Sort
{
    /**
        Sorts the given container `container` and pushes the sorted result to
        `output` using that containers `push()` method.

        Comparison between two elements is done using `comp`. If `comp` is
        unspecified, `hxdf.lambda.Compare.reflectiveComparison` is used.

        if `reverse` is `true`, the sorted result is pushed to `output` in
        reverse.
    **/
    public static function mergeSort<T>(
        container:SequentialContainer<T>, output:SequentialContainer<T>, ?comp:(T, T) -> Int, reverse = false
    ):Void
    {
        inline function advanceIterator(it:Iterator<T>, amount:Int):Bool
        {
            while (0 < amount && it.hasNext())
            {
                it.next();
                amount--;
            }
            return amount == 0;
        }

        if (container.length < 2)
        {
            for (item in container) output.push(item);
            return;
        }

        if (comp == null) comp = Compare.reflectiveComparison;
        if (reverse) comp = Compare.reverse(comp);

        var binSize = 1;
        while (binSize < container.length)
        {
            var merge:SequentialContainer<T> = container.length <= binSize * 2 ? output : new SingleLinkedList<T>();

            var iterA = container.iterator();
            var iterB = container.iterator();
            advanceIterator(iterB, binSize);

            while (merge.length != container.length)
            {
                var valA = iterA.next();
                var valB = iterB.next();
                var posA = 0;
                var posB = 0;

                while (posA < binSize && posB < binSize)
                {
                    if (0 < comp(valA, valB))
                    {
                        merge.push(valB);
                        posB++;
                        if (!iterB.hasNext())
                        {
                            posB = binSize;
                            break;
                        }
                        valB = iterB.next();
                    }
                    else
                    {
                        merge.push(valA);
                        posA++;
                        valA = iterA.next();
                    }
                }
                while (posA < binSize)
                {
                    merge.push(valA);
                    posA++;
                    valA = iterA.next();
                }
                if (posB < binSize)
                {
                    posB++;
                    merge.push(valB);
                    if (iterB.hasNext())
                    {
                        valB = iterB.next();
                        while (posB < binSize && iterB.hasNext())
                        {
                            posB++;
                            merge.push(valB);
                            valB = iterB.next();
                        }
                    }
                }

                advanceIterator(iterA, binSize - 1);
                advanceIterator(iterB, binSize - 1);
                if (!iterB.hasNext())
                {
                    while (iterA.hasNext()) merge.push(iterA.next());
                    break;
                }
            }

            binSize *= 2;
            container = merge;
        }
    }
}

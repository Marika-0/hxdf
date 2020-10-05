package hxdf.lambda;

import hxdf.ds.Container.SequentialContainer;
import hxdf.ds.list.SingleLinkedList;

class Sort
{
    public static function mergeSort<T>(container:SequentialContainer<T>, ?comp:(T, T) -> Int):SingleLinkedList<T>
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
            var list = new SingleLinkedList<T>();
            for (item in container) list.unshift(item);
            return list;
        }

        if (comp == null) comp = Compare.reflectiveComparison;

        var binSize = 1;
        var merge = new SingleLinkedList<T>();
        while (binSize < container.length)
        {
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
                        merge.unshift(valB);
                        posB++;
                        if (!iterB.hasNext())
                        {
                            posB = binSize;
                            break;
                        }
                        valB = iterB.next();
                    } else
                    {
                        merge.unshift(valA);
                        posA++;
                        valA = iterA.next();
                    }
                }
                while (posA < binSize)
                {
                    posA++;
                    merge.unshift(valA);
                    valA = iterA.next();
                }
                if (posB < binSize)
                {
                    posB++;
                    merge.unshift(valB);
                    if (iterB.hasNext())
                    {
                        valB = iterB.next();
                        while (posB < binSize && iterB.hasNext())
                        {
                            posB++;
                            merge.unshift(valB);
                            valB = iterB.next();
                        }
                    }
                }

                advanceIterator(iterA, binSize - 1);
                advanceIterator(iterB, binSize - 1);
                if (!iterB.hasNext())
                {
                    while (iterA.hasNext()) merge.unshift(iterA.next());
                    break;
                }
            }

            binSize *= 2;
            if (binSize < container.length)
            {
                container = merge;
                merge = new SingleLinkedList<T>();
            }
        }

        return merge;
    }
}

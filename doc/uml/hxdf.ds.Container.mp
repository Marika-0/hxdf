prologues := 3;

input metauml;

verbatimtex
%&latex
\documentclass{minimal}
\begin{document}
etex


string interface_stereotype; interface_stereotype := "«interface»";
% Guillemets (u00AB and u00BB) char bytes may need to be added manually.

numeric offset;              offset             := 40;
pair h_offset;               h_offset           := (40, 0);
pair v_offset;               v_offset           := (0, 40);
numeric nointersect_radius;  nointersect_radius := 5;


beginfig(1);

	Class.Container("Container")
		(	"+length : Int")
		(	"+isEmpty() : Bool",
			"+clear() : Void",
			"+copy() : Container",
			"+toString() : String");
	Class_stereotypes.Container(interface_stereotype);

	Class.WalkableContainer("WalkableContainer<T>")
		()
		(	"+iterator() : UnidirectionalIterator<T>",
			"+filter(T->Bool) : WalkableContainer<T>",
			"+map<S>(T->S) : WalkableContainer<S>");
	Class_stereotypes.WalkableContainer(interface_stereotype);
	ClassTemplate.WalkableTemplate("T")(WalkableContainer);

	Class.SpaceContainer("SpaceContainer<T>")
		()
		(	"+size() : Int",
			"+exists(item:T) : Bool",
			"+delete(item:T) : Bool");
	Class_stereotypes.SpaceContainer(interface_stereotype);
	ClassTemplate.SpaceTemplate("T")(SpaceContainer);

	Class.SequentialContainer("SequentialContainer<T>")
		()
		(	"+push(item:T) : Void",
			"+pop() : Null<T>",
			"+first() : Null<T>",
			"+join(delim:String) : String");
	Class_stereotypes.SequentialContainer(interface_stereotype);
	ClassTemplate.SequentialTemplate("T")(SequentialContainer);

	Class.TraversableContainer("TraversableContainer<T>")
		()
		(	"+reverseIterator() : UnidirectionalIterator<T>",
			"+beginIterator() : BidirectionalIterator<T>",
			"+endIterator() : BidirectionalIterator<T>");
	Class_stereotypes.TraversableContainer(interface_stereotype);
	ClassTemplate.TraversableTemplate("T")(TraversableContainer);

	Class.SetContainer("SetContainer<T>")
		()
		(	"+add(item:T) : Void",
			"+remove(item:T) : Null<T>");
	Class_stereotypes.SetContainer(interface_stereotype);
	ClassTemplate.SetTemplate("T")(SetContainer);

	Class.AssociativeContainer("AssociativeContainer<K, V>")
		()
		(	"+get(key:K) : Null<V>",
			"+set(key:K, value:V) : Void",
			"+keyIterator() : Unidirectionaliterator<K>",
			"+pairIterator() : UnidirectionalIterator<KeyValuePair<K, V>>",
			"+filterKeys(f:K->Bool) : AssociativeContainer<K, V>",
			"+filterPairs(f:KeyValuePair<K, V>->Bool) : AssociativeContainer<K, V>",
			"+mapKeys<S>(f:K->S) : AssociativeContainer<S, V>",
			"+mapPairs<X, Y>(f:KeyValuePair<K, V>->KeyValuePair<X, Y>) : AssociativeContainer<X, Y>");
	Class_stereotypes.AssociativeContainer(interface_stereotype);
	ClassTemplate.AssociativeTemplate("", "WalkableContainer<V>", "SpaceContainer<K>")(AssociativeContainer);

	Class.BilateralContainer("BilateralContainer<T>")
		()
		(	"+unshift(item:T) : Void",
			"+shift() : Null<T>",
			"+last() : Null<T>");
	Class_stereotypes.BilateralContainer(interface_stereotype);
	ClassTemplate.BilateralTemplate("T")(BilateralContainer);

	Class.RandomAccessContainer("RandomAccessContainer<T>")
		()
		(	"+get(index:Int) : T",
			"+set(index:Int, value:T) : Void");
	Class_stereotypes.RandomAccessContainer(interface_stereotype);
	ClassTemplate.RandomAccessTemplate("T")(RandomAccessContainer);


	leftToRight(offset)(SequentialContainer, TraversableContainer, SetContainer, AssociativeContainer);
	BilateralContainer.n = (xpart (SequentialContainer.c + TraversableContainer.c) / 2, min(SequentialContainer.bottom, TraversableContainer.bottom)) - v_offset;
	RandomAccessContainer.n = BilateralContainer.s - v_offset;

	numeric midY; midY := max(SequentialContainer.top, TraversableContainer.top, SetContainer.top, AssociativeContainer.top) + offset + max(WalkableContainer.height, SpaceContainer.height) / 2;
	WalkableContainer.c = (xpart (SequentialContainer.c + TraversableContainer.c + SetContainer.c + AssociativeContainer.c) / 4, midY);
	SpaceContainer.c = (xpart (SetContainer.c + AssociativeContainer.c) / 2, midY);

	Container.s = (xpart (WalkableContainer.c + SpaceContainer.c) / 2, max(WalkableContainer.top, SpaceContainer.top) + offset);


	drawObject(Container);

	drawObjects(WalkableContainer, WalkableTemplate);
	link(inheritance)(rpathStepY(Container.s, WalkableContainer.n, -offset / 2));

	drawObjects(SpaceContainer, SpaceTemplate);
	link(inheritance)(rpathStepY(Container.s, SpaceContainer.n, -offset / 2));

	drawObjects(SequentialContainer, SequentialTemplate);
	link(inheritance)(rpathStepY(WalkableContainer.sw + (WalkableContainer.width / 3, 0), SequentialContainer.n, -offset / 2));

	drawObjects(TraversableContainer, TraversableTemplate);
	link(inheritance)(rpathStepY(WalkableContainer.sw + (WalkableContainer.width / 3, 0), TraversableContainer.n, -offset / 2));

	drawObjects(SetContainer, SetTemplate);
	drawObjects(AssociativeContainer, AssociativeTemplate);
	pair midStep; midStep = (xpart (WalkableContainer.c + SpaceContainer.c) / 2, max(SetContainer.top, AssociativeContainer.top) + offset / 4);
	link(inheritance)(SetContainer.n -- (xpart SetContainer.c, ypart midStep) -- midStep -- midStep + v_offset / 4 -- SpaceContainer.s - v_offset / 2 -- SpaceContainer.s);
	link(inheritance)(AssociativeContainer.n -- (xpart AssociativeContainer.c, ypart midStep) -- midStep -- midStep + v_offset / 4 -- WalkableContainer.se - (WalkableContainer.width / 3, 0) - v_offset / 2 -- WalkableContainer.se - (WalkableContainer.width / 3, 0));

	drawObjects(BilateralContainer, BilateralTemplate);
	link(inheritance)(pathStepY(BilateralContainer.n, SequentialContainer.s, offset / 2));
	link(inheritance)(pathStepY(BilateralContainer.n, TraversableContainer.s, offset / 2));

	drawObjects(RandomAccessContainer, RandomAccessTemplate);
	link(inheritance)(RandomAccessContainer.n -- BilateralContainer.s);

endfig;
end

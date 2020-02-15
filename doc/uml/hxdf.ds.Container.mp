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
		(	"+length(default, null) : Int")
		(	"+isEmpty() : Bool",
			"+clear() : Void",
			"+copy() : Container<T>",
			"+toString() : String");
	Class_stereotypes.Container(interface_stereotype);
	ClassTemplate.ContainerTemplate("T")(Container);

	Class.SequentialContainer("SequentialContainer<T>")
		()
		(	"+push(item:T) : Void",
			"+pop() : Null<T>",
			"+peek() : Null<T>",
			"+join(sep:String) : String");
	Class_stereotypes.SequentialContainer(interface_stereotype);
	ClassTemplate.SequentialTemplate("T")(SequentialContainer);

	Class.WalkableContainer("WalkableContainer<T>")
		()
		(	"+iterator() : UnidirectionalIterator<T>",
			"+filter(f:(T)->Bool) : WalkableContainer<T>",
			"+map<S>(f:(T)->S) : WalkableContainer<S>");
	Class_stereotypes.WalkableContainer(interface_stereotype);
	ClassTemplate.WalkableTemplate("T")(WalkableContainer);

	Class.SpaceContainer("SpaceContainer<T>")
		()
		(	"+size() : Int",
			"+exists(val:T) : Bool",
			"+delete(val:T) : Bool");
	Class_stereotypes.SpaceContainer(interface_stereotype);
	ClassTemplate.SpaceTemplate("T")(SpaceContainer);

	Class.BilateralContainer("BilateralContainer<T>")
		()
		(	"+unshift(item:T) : Void",
			"+shift() : Null<T>",
			"+spy() : Null<T>");
	Class_stereotypes.BilateralContainer(interface_stereotype);
	ClassTemplate.BilateralTemplate("T")(BilateralContainer);

	Class.TraversableContainer("TraversableContainer<T>")
		()
		(	"+reverseIterator() : UnidirectionalIterator<T>",
			"+beginIterator() : BidirectionalIterator<T>",
			"+endIterator() : BidirectionalIterator<T>");
	Class_stereotypes.TraversableContainer(interface_stereotype);
	ClassTemplate.TraversableTemplate("T")(TraversableContainer);

	Class.ExtractableContainer("ExtractableContainer<T>")
		()
		(	"+indexIterator() : IndexIterator<T>",
			"+keyValueIterator() : IndexIterator<T>",
			"+remove(val:T, ?comp:(T, T)->Bool) : Bool");
	Class_stereotypes.ExtractableContainer(interface_stereotype);
	ClassTemplate.ExtractableTemplate("T")(ExtractableContainer);

	Class.AssociativeContainer("AssociativeContainer<K, V>")
		()
		(	"+set(key:K, value:V) : Void",
			"+get(key:K) : Null<V>",
			"+remove(key:K) : Null<V>",
			"+keyIterator() : Unidirectionaliterator<K>",
			"+keyValueIterator() : KeyValueIterator<K, V>",
			"+filterKeys(f:(K)->Bool) : AssociativeContainer<K, V>",
			"+filterPairs(f:(KeyValuePair<K, V>)->Bool) : AssociativeContainer<K, V>",
			"+mapKeys<S>(f:(K)->S) : AssociativeContainer<S, V>",
			"+mapPairs<X, Y>(f:(KeyValuePair<K, V>)->KeyValuePair<X, Y>) : AssociativeContainer<X, Y>");
	Class_stereotypes.AssociativeContainer(interface_stereotype);
	ClassTemplate.AssociativeTemplate("", "SpaceContainer<K>", "WalkableContainer<V>")(AssociativeContainer);

	Class.SetContainer("SetContainer<T>")
		()
		(	"+add(val:T) : Void");
	Class_stereotypes.SetContainer(interface_stereotype);
	ClassTemplate.SetTemplate("T")(SetContainer);

	Class.RandomAccessContainer("RandomAccessContainer<T>")
		()
		(	"+get(index:Int) : T",
			"+set(index:Int, value:T) : Void");
	Class_stereotypes.RandomAccessContainer(interface_stereotype);
	ClassTemplate.RandomAccessTemplate("T")(RandomAccessContainer);


	leftToRight(offset)(BilateralContainer, ExtractableContainer, TraversableContainer, AssociativeContainer, SetContainer);
	numeric midRowY; midRowY = max(BilateralContainer.top, ExtractableContainer.top, TraversableContainer.top, AssociativeContainer.top, SetContainer.top) + offset + max(SequentialContainer.height, WalkableContainer.height, SpaceContainer.height) / 2;
	SequentialContainer.c = ((xpart BilateralContainer.c + ExtractableContainer.left + ExtractableContainer.width / 3) / 2, midRowY);
	WalkableContainer.c = ((ExtractableContainer.right - ExtractableContainer.width / 3 + xpart TraversableContainer.c + AssociativeContainer.left + AssociativeContainer.width / 3) / 2, midRowY);
	SpaceContainer.c = ((AssociativeContainer.right - AssociativeContainer.width / 3 + xpart SetContainer.c) / 2, midRowY);
	Container.s = (xpart (SequentialContainer.c + WalkableContainer.c + SpaceContainer.c), max(SequentialContainer.top, WalkableContainer.top, SpaceContainer.top) + offset);
	RandomAccessContainer.n = (xpart (BilateralContainer.c + ExtractableContainer.c + TraversableContainer.c) / 3, min(BilateralContainer.bottom, ExtractableContainer.bottom, TraversableContainer.bottom, AssociativeContainer.bottom, SetContainer.bottom) - offset);


	drawObjects(Container, ContainerTemplate);

	drawObjects(SequentialContainer, SequentialTemplate);
	link(inheritance)(rpathStepY(Container.s, SequentialContainer.n, -offset / 2));

	drawObjects(WalkableContainer, WalkableTemplate);
	link(inheritance)(rpathStepY(Container.s, WalkableContainer.n, -offset / 2));

	drawObjects(SpaceContainer, SpaceTemplate);
	link(inheritance)(rpathStepY(Container.s, SpaceContainer.n, -offset / 2));

	drawObjects(BilateralContainer, BilateralTemplate);
	link(inheritance)(rpathStepY(SequentialContainer.s, BilateralContainer.n, (max(BilateralContainer.top, ExtractableContainer.top) - SequentialContainer.bottom) / 2));

	drawObjects(ExtractableContainer, ExtractableTemplate);
	link(inheritance)(rpathStepY(SequentialContainer.s, ExtractableContainer.nw + (ExtractableContainer.width / 3, 0), (max(BilateralContainer.top, ExtractableContainer.top) - SequentialContainer.bottom) / 2));
	link(inheritance)(rpathStepY(WalkableContainer.s, ExtractableContainer.ne - (ExtractableContainer.width / 3, 0), (max(ExtractableContainer.top, TraversableContainer.top, AssociativeContainer.top) - WalkableContainer.bottom) / 2));

	drawObjects(TraversableContainer, TraversableTemplate);
	link(inheritance)(rpathStepY(WalkableContainer.s, TraversableContainer.n, (max(ExtractableContainer.top, TraversableContainer.top, AssociativeContainer.top) - WalkableContainer.bottom) / 2));

	drawObjects(SetContainer, SetTemplate);
	link(inheritance)(rpathStepY(SpaceContainer.s, SetContainer.n, (max(SetContainer.top, AssociativeContainer.top) - SpaceContainer.bottom) / 2));

	drawObjects(AssociativeContainer, AssociativeTemplate);
	link(inheritance)(rpathStepY(WalkableContainer.s, AssociativeContainer.nw + (AssociativeContainer.width / 3, 0), (max(ExtractableContainer.top, TraversableContainer.top, AssociativeContainer.top) - WalkableContainer.bottom) / 2));
	link(inheritance)(rpathStepY(SpaceContainer.s, AssociativeContainer.ne - (AssociativeContainer.width / 3, 0), (max(SetContainer.top, AssociativeContainer.top) - SpaceContainer.bottom) / 2));

	drawObjects(RandomAccessContainer, RandomAccessTemplate);
	link(inheritance)(pathStepY(RandomAccessContainer.n, BilateralContainer.s, (min(BilateralContainer.bottom, ExtractableContainer.bottom, TraversableContainer.bottom) - RandomAccessContainer.top) / 2));
	link(inheritance)(pathStepY(RandomAccessContainer.n, ExtractableContainer.s, (min(BilateralContainer.bottom, ExtractableContainer.bottom, TraversableContainer.bottom) - RandomAccessContainer.top) / 2));
	link(inheritance)(pathStepY(RandomAccessContainer.n, TraversableContainer.s, (min(BilateralContainer.bottom, ExtractableContainer.bottom, TraversableContainer.bottom) - RandomAccessContainer.top) / 2));


	Note.package(
		"package: hxdf.ds",
		"module:  Container",
		"",
		"imports",
		"  hxdf.ds.unit.KeyValuePair",
		"  hxdf.lambda.Iterator");
	package.info.foreColor := (2/3, 2/3, 1);
	package.ne = ulcorner currentpicture - h_offset;
	drawObject(package);

endfig;
end

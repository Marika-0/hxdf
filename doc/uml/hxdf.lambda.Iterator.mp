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

	Class.InputIterator("InputIterator<T>")
		()
		(	"+hasNext() : Bool",
			"+next() : T",
			"+copy() : InputIterator<T>");
	Class_stereotypes.InputIterator(interface_stereotype);
	ClassTemplate.InputTemplate("T")(InputIterator);
	
	Class.ExtractableIterator("ExtractableIterator<T>")
		()
		(	"+value() : T");
	Class_stereotypes.ExtractableIterator(interface_stereotype);
	ClassTemplate.ExtractableTemplate("T")(ExtractableIterator);
	
	Class.SequentialIterator("SequentialIterator<T>")
		()
		(	"+advance(steps:Int) : T",
			"+equals(it:SequentialIterator<T>) : Bool");
	Class_stereotypes.SequentialIterator(interface_stereotype);
	ClassTemplate.SequentialTemplate("T")(SequentialIterator);

	Class.KeyValueIterator("KeyValueIterator<K, V>")
		()
		(	"+key() : K",
			"+value() : V",
			"+pair() : KeyValuePair<K, V>");
	Class_stereotypes.KeyValueIterator(interface_stereotype);
	ClassTemplate.KeyValueTemplate("KeyValuePair<K, V>")(KeyValueIterator);

	Class.IndexIterator("IndexIterator<T>")
		()
		(	"+position() : Int");
	Class_stereotypes.IndexIterator(interface_stereotype);
	ClassTemplate.IndexTemplate("", "SequentialIterator<KeyValuePair<Int, T>>", "KeyValueIterator<Int, T>")(IndexIterator);

	Class.UnidirectionalIterator("UnidirectionalIterator<T>")
		()
		();
	Class_stereotypes.UnidirectionalIterator(interface_stereotype);
	ClassTemplate.UnidirectionalTemplate("T")(UnidirectionalIterator);

	Class.BidirectionalIterator("BidirectionalIterator<T>")
		()
		(	"+hasPrev() : Bool",
			"+prev() : T",
			"+retreat(steps:Int) : T");
	Class_stereotypes.BidirectionalIterator(interface_stereotype);
	ClassTemplate.BidirectionalTemplate("T")(BidirectionalIterator);

	Class.RandomAccessIterator("RandomAccessIterator<T>")
		()
		(	"+position() : Int",
			"+setToPosition(pos:Int) : T",
			"+getOffset(offset:Int) : T",
			"+compare(it:RandomAccessIterator<T>) : Int");
	Class_stereotypes.RandomAccessIterator(interface_stereotype);
	ClassTemplate.RandomAccessTemplate("T")(RandomAccessIterator);
	
	
	leftToRight(offset)(ExtractableIterator, SequentialIterator, KeyValueIterator);
	InputIterator.s = (xpart (ExtractableIterator.c + SequentialIterator.c + KeyValueIterator.c) / 3, max(ExtractableIterator.top, SequentialIterator.top, KeyValueIterator.top) + offset);
	numeric midRowY; midRowY = min(ExtractableIterator.bottom, SequentialIterator.bottom, KeyValueIterator.bottom) - offset - max(UnidirectionalIterator.height, IndexIterator.height) / 2;
	UnidirectionalIterator.c = ((xpart ExtractableIterator.c + SequentialIterator.left + SequentialIterator.width / 3) / 2, midRowY);
	IndexIterator.c = ((SequentialIterator.right - SequentialIterator.width / 3 + xpart KeyValueIterator.c) / 2, midRowY);
	BidirectionalIterator.n = UnidirectionalIterator.s - v_offset;
	RandomAccessIterator.n = BidirectionalIterator.s - v_offset;


	drawObjects(InputIterator, InputTemplate);
	
	drawObjects(ExtractableIterator, ExtractableTemplate);
	link(inheritance)(rpathStepY(InputIterator.s, ExtractableIterator.n, -offset / 2));
	
	drawObjects(SequentialIterator, SequentialTemplate);
	link(inheritance)(rpathStepY(InputIterator.s, SequentialIterator.n, -offset / 2));
	
	drawObjects(KeyValueIterator, KeyValueTemplate);
	link(inheritance)(rpathStepY(InputIterator.s, KeyValueIterator.n, -offset / 2));

	drawObjects(UnidirectionalIterator, UnidirectionalTemplate);
	link(inheritance)(pathStepY(UnidirectionalIterator.n, ExtractableIterator.s, (min(ExtractableIterator.bottom, SequentialIterator.bottom) - UnidirectionalIterator.top) / 2));
	link(inheritance)(pathStepY(UnidirectionalIterator.n, SequentialIterator.sw + (SequentialIterator.width / 3, 0), (min(ExtractableIterator.bottom, SequentialIterator.bottom) - UnidirectionalIterator.top) / 2));
	
	drawObjects(IndexIterator, IndexTemplate);
	link(inheritance)(pathStepY(IndexIterator.n, SequentialIterator.se - (SequentialIterator.width / 3, 0), offset / 2));
	link(inheritance)(pathStepY(IndexIterator.n, KeyValueIterator.s, offset / 2));

	drawObjects(BidirectionalIterator, BidirectionalTemplate);
	link(inheritance)(BidirectionalIterator.n -- UnidirectionalIterator.s);

	drawObjects(RandomAccessIterator, RandomAccessTemplate);
	link(inheritance)(RandomAccessIterator.n -- BidirectionalIterator.s);


	Note.package(
		"package: hxdf.lambda",
		"module:  Iterator",
		"",
		"imports",
		"  hxdf.ds.unit.KeyValuePair");
	package.info.foreColor := (2/3, 2/3, 1);
	package.ne = ulcorner currentpicture - h_offset;
	drawObject(package);

endfig;
end

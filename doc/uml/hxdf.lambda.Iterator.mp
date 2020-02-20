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

	Class.SequentialIterator("SequentialIterator<T>")
		()
		(	"+equals(it:SequentialIterator<T>) : Bool");
	Class_stereotypes.SequentialIterator(interface_stereotype);
	ClassTemplate.SequentialTemplate("T")(SequentialIterator);

	Class.IndexIterator("IndexIterator<T>")
		()
		(	"+compare(it:IndexIterator<T>) : Int");
	Class_stereotypes.IndexIterator(interface_stereotype);
	ClassTemplate.IndexTemplate("KeyValuePair<Int, T>")(IndexIterator);

	Class.BidirectionalIterator("BidirectionalIterator<T>")
		()
		(	"+hasPrev() : Bool",
			"+prev() : T");
	Class_stereotypes.BidirectionalIterator(interface_stereotype);
	ClassTemplate.BidirectionalTemplate("T")(BidirectionalIterator);

	Class.RandomAccessIterator("RandomAccessIterator<T>")
		()
		(	"+position() : Int",
			"+setTo(pos:Int) : T",
			"+compare(it:RandomAccessIterator<T>) : Int");
	Class_stereotypes.RandomAccessIterator(interface_stereotype);
	ClassTemplate.RandomAccessTemplate("T")(RandomAccessIterator);


	topToBottom(offset)(SequentialIterator, BidirectionalIterator, RandomAccessIterator);
	IndexIterator.w = SequentialIterator.e + h_offset;
	InputIterator.s = (xpart (SequentialIterator.c + IndexIterator.c) / 2, max(SequentialIterator.top, IndexIterator.top) + offset);


	drawObjects(InputIterator, InputTemplate);

	drawObjects(IndexIterator, IndexTemplate);
	link(inheritance)(rpathStepY(InputIterator.s, IndexIterator.n, (max(SequentialIterator.top, IndexIterator.top) - InputIterator.bottom) / 2));

	drawObjects(SequentialIterator, SequentialTemplate);
	link(inheritance)(rpathStepY(InputIterator.s, SequentialIterator.n, (max(SequentialIterator.top, IndexIterator.top) - InputIterator.bottom) / 2));

	drawObjects(BidirectionalIterator, BidirectionalTemplate);
	link(inheritance)(BidirectionalIterator.n -- SequentialIterator.s);

	drawObjects(RandomAccessIterator, RandomAccessTemplate);
	link(inheritance)(RandomAccessIterator.n -- BidirectionalIterator.s);


	Note.package(
		"package: hxdf.lambda",
		"module:  Iterator",
		"",
		"imports:",
		"  hxdf.ds.unit.KeyValuePair");
	package.info.foreColor := (2/3, 2/3, 1);
	package.ne = ulcorner currentpicture - h_offset;
	drawObject(package);

endfig;
end

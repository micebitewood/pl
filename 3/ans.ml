(*Set*)
signature SET =
sig
	type 'a set
	val insert : ''a * ''a set -> ''a set
	val remove: ''a * ''a set -> ''a set
	val member: ''a * ''a set -> bool
	val size: 'a set -> int
end
	
structure Set : SET =
struct
	type 'a set = 'a list
	fun insert (x, s::xs) = if x=s then s::xs else s::insert(x, xs)
		|insert (x, []) = [x]
	fun remove (x, s::xs) = if x=s then xs else s::remove(x, xs)
		|remove(x, []) = []
	fun member (x, s::xs) = if x=s then true else member(x, xs)
		|member (x, []) = false
	fun size (s::xs) = 1 + size(xs)
		|size [] = 0
end


(*Graph*)
type vertex = int
datatype edge = Edge of vertex * vertex

signature GRAPH =
sig
	type vertices
	type edges
	val addVertex : vertex * (vertices * edges) -> vertices * edges
	val addEdge: edge * (vertices * edges) -> vertices * edges
	val successor: vertex * (vertices * edges) -> vertices
	val predecessor: vertex * (vertices * edges) -> vertices
end
	
structure Graph : GRAPH =
struct
	type vertices = vertex Set.set
	type edges = edge Set.set
	fun addVertex (x, (xs, edges)) = (Set.insert(x, xs), edges)
	fun addEdge (x, (vertices, xs)) = (vertices, Set.insert(x, xs))
	fun successor (x, (vertices, Edge(a, b)::xs)) = if x=a then b::successor(x, (vertices, xs)) else successor(x, (vertices, xs))
		|successor (x, _) = []
	fun predecessor (x, (vertices, Edge(a, b)::xs)) = if b=x then a::predecessor(x, (vertices, xs)) else predecessor(x, (vertices, xs))
		|predecessor (x, _) = []
end

(*hamcycle*)
(*count different vertices of input edges*)
fun count (c, _, []) = c
	|count (c, set, Edge(a, b)::edges) = 
			(*if both a and b are in the set*)
			if Set.member(a, set) andalso Set.member(b, set) 
			then count(c, set, edges)
			(*if b is not in the set*)
			else if Set.member(a, set)
			then count(c + 1, Set.insert(b, set), edges)
			(*if a is not in the set*)
			else if Set.member(b, set)
			then count(c + 1, Set.insert(a, set), edges)
			(*if neither is in the set*)
			else count(c + 2, Set.insert(a, Set.insert(b, set)), edges)

fun check (num, totalEdges, [], vertexSet, edgeSet) = NONE
	|check (num, totalEdges, Edge(a, b)::edges, [], []) = 
		let
			(*if the first edge is in the answer*)
			val ans = check(num, edges, edges, Set.insert(b, Set.insert(a, [])), Set.insert(Edge(a, b), []))
		in
			if isSome ans then ans
			(*if the first edge is not in the answer, throw it away*)
			else check(num, edges, edges, [], [])
		end
	|check (num, totalEdges, Edge(a, b)::edges, vertexSet, edgeSet) = 
		(*if a is the end vertex of last edge*)
		if (List.last vertexSet)=a then
			(*if hamcycle is found*)
			if (hd vertexSet)=b andalso (length vertexSet)=num then
				SOME (Set.insert(Edge(a, b), edgeSet))
			(*if hamcycle is not found yet*)
			else
				(*if b is in the set, which means there is a small cycle*)
				if Set.member(b, vertexSet) then
					check(num, totalEdges, edges, vertexSet, edgeSet)
				(*if b is a new vertex*)
				else
					let
						val ans = check(num, totalEdges, totalEdges, Set.insert(b, vertexSet), Set.insert(Edge(a, b), edgeSet))
					in
						(*if there is a hamcycle and Edge(a, b) is in the answer*)
						if isSome ans then ans
						(*is Edge(a, b) is not in the answer, test other edges.*)
						else check(num, totalEdges, edges, vertexSet, edgeSet)
					end
		(*if a is not the end vertex of last edge*)
		else check(num, totalEdges, edges, vertexSet, edgeSet)
			
fun hamcycle [] = NONE
	|hamcycle edges = 
		let
			val verticeNum = count(0, [], edges)
		in
			check(verticeNum, edges, edges, [], [])
		end
		

val a = hamcycle [Edge(1, 2), Edge(2, 4), Edge(2, 5), Edge(5, 1)]

val b = hamcycle [Edge(1, 2), Edge(2, 4), Edge(2, 6), Edge(5, 1)]

val c = hamcycle [Edge(1, 2)]

val d = hamcycle [Edge(7,4),Edge(6,8),Edge(6,4),Edge(3,7),Edge(2,10),Edge(8,3),Edge(10,1),Edge(7,4),Edge(7,1),Edge(7,3),Edge(9,2),Edge(10,8),Edge(1,3),Edge(4,3),Edge(6,8),Edge(3,10),Edge(9,3),Edge(8,10),Edge(7,4),Edge(3,2),Edge(4,10),Edge(10,2),Edge(8,5),Edge(5,9),Edge(1,6),Edge(7,4),Edge(1,2),Edge(4,7),Edge(1,3),Edge(2,7)];

val e = hamcycle [Edge(6,6),Edge(8,5),Edge(6,7),Edge(10,7),Edge(8,4),Edge(6,5),Edge(6,3),Edge(8,5),Edge(5,5),Edge(1,4),Edge(9,8),Edge(9,7),Edge(5,9),Edge(2,4),Edge(10,5),Edge(1,3),Edge(9,7),Edge(3,10),Edge(7,7),Edge(10,5),Edge(1,6),Edge(9,5),Edge(2,8),Edge(3,8),Edge(3,8),Edge(7,3),Edge(1,2),Edge(2,7),Edge(10,6),Edge(10,5)];

val f = hamcycle [Edge(10,1),Edge(8,2),Edge(2,8),Edge(6,2),Edge(8,10),Edge(7,8),Edge(4,8),Edge(6,7),Edge(4,7),Edge(5,10),Edge(2,9),Edge(10,3),Edge(10,4),Edge(9,1),Edge(6,9),Edge(10,1),Edge(4,7),Edge(6,9),Edge(2,7),Edge(6,2),Edge(9,10),Edge(9,5),Edge(1,2),Edge(1,4),Edge(5,5),Edge(5,5),Edge(7,8),Edge(2,4),Edge(6,8),Edge(7,10)];

val g = hamcycle [Edge(2,3),Edge(9,8),Edge(8,6),Edge(2,5),Edge(6,9),Edge(8,10),Edge(4,6),Edge(9,9),Edge(2,4),Edge(10,9),Edge(5,7),Edge(4,4),Edge(9,4),Edge(1,7),Edge(9,5),Edge(9,9),Edge(8,10),Edge(7,8),Edge(4,5),Edge(4,1),Edge(10,1),Edge(6,3),Edge(1,5),Edge(10,6),Edge(7,5),Edge(3,10),Edge(5,3),Edge(8,8),Edge(5,6),Edge(2,9)];

val h = hamcycle [Edge(9,3),Edge(4,10),Edge(9,7),Edge(3,1),Edge(1,2),Edge(2,6),Edge(1,2),Edge(6,9),Edge(7,1),Edge(7,5),Edge(6,3),Edge(7,9),Edge(9,3),Edge(8,5),Edge(5,3),Edge(7,1),Edge(10,3),Edge(1,10),Edge(2,9),Edge(2,4),Edge(1,2),Edge(5,4),Edge(4,1),Edge(2,10),Edge(7,10),Edge(4,10),Edge(9,4),Edge(6,1),Edge(7,7),Edge(1,5)];

val i = hamcycle [Edge(3,7),Edge(5,1),Edge(8,7),Edge(7,6),Edge(9,10),Edge(3,8),Edge(3,9),Edge(10,10),Edge(1,7),Edge(8,3),Edge(2,7),Edge(3,4),Edge(6,2),Edge(10,10),Edge(5,2),Edge(2,10),Edge(8,1),Edge(9,6),Edge(1,8),Edge(9,5),Edge(5,1),Edge(10,3),Edge(2,7),Edge(5,1),Edge(3,3),Edge(1,3),Edge(6,6),Edge(10,3),Edge(3,1),Edge(4,9)];

val j = hamcycle [Edge(1,9),Edge(1,5),Edge(2,10),Edge(7,10),Edge(6,3),Edge(5,5),Edge(10,10),Edge(7,4),Edge(6,1),Edge(3,1),Edge(5,10),Edge(6,4),Edge(8,2),Edge(4,5),Edge(5,2),Edge(10,7),Edge(3,5),Edge(7,3),Edge(2,5),Edge(9,3),Edge(10,9),Edge(9,3),Edge(9,9),Edge(9,7),Edge(9,4),Edge(4,4),Edge(9,4),Edge(5,1),Edge(7,8),Edge(10,9)];

val k = hamcycle [Edge(7,1),Edge(8,9),Edge(1,10),Edge(4,4),Edge(8,4),Edge(3,4),Edge(6,7),Edge(7,3),Edge(9,6),Edge(10,8),Edge(1,7),Edge(2,5),Edge(5,1),Edge(8,9),Edge(9,1),Edge(3,7),Edge(8,5),Edge(4,10),Edge(3,10),Edge(4,9),Edge(2,1),Edge(9,8),Edge(2,10),Edge(5,6),Edge(3,10),Edge(8,6),Edge(10,5),Edge(5,10),Edge(10,6),Edge(6,4)];

val l = hamcycle [Edge(1,8),Edge(2,9),Edge(10,10),Edge(9,8),Edge(6,3),Edge(5,4),Edge(1,10),Edge(1,3),Edge(10,2),Edge(3,7),Edge(3,2),Edge(8,1),Edge(2,4),Edge(10,2),Edge(6,1),Edge(8,7),Edge(5,8),Edge(7,1),Edge(8,5),Edge(9,5),Edge(9,6),Edge(7,3),Edge(7,1),Edge(5,7),Edge(3,7),Edge(10,9),Edge(1,7),Edge(1,8),Edge(1,2),Edge(4,2)];

val m = hamcycle [Edge(8,8),Edge(7,3),Edge(6,5),Edge(1,3),Edge(10,3),Edge(10,1),Edge(5,10),Edge(2,6),Edge(4,1),Edge(9,8),Edge(7,9),Edge(5,1),Edge(8,7),Edge(1,7),Edge(8,10),Edge(10,6),Edge(9,8),Edge(4,6),Edge(9,4),Edge(8,4),Edge(4,10),Edge(9,8),Edge(5,8),Edge(10,2),Edge(10,1),Edge(9,9),Edge(9,6),Edge(4,5),Edge(2,8),Edge(9,4)];

val g1 = Graph.addVertex(1, ([], []))
val g2 = Graph.addVertex(2, g1)
val g3 = Graph.addVertex(3, g2)
val g4 = Graph.addEdge(Edge(1, 2), g3)
val g5 = Graph.addEdge(Edge(1, 3), g4)
val g6 = Graph.addVertex(5, g5)
val g7 = Graph.addEdge(Edge(5, 3), g6)
val suc1 = Graph.successor(1, g7)
val pre3 = Graph.predecessor(3, g7)

val s1 = Set.insert(#"1", []);
val s2 = Set.insert(#"2", s1);
val s3 = Set.insert(#"3", s2);
val s4 = Set.insert(#"1", s3);
val s5 = Set.remove(#"2", s4);
val s6 = Set.member(#"2", s5);
val s7 = Set.size(s4);
//
//  Graph.swift
//  AthenianMaps
//
//  Created by Tavi Greenfield on 5/18/23.
//

import Foundation

class DijkstraGraph {
    var vertices: [String: WeightedVertex]
    var vertexID: [String: String]
    var labels: Set<String>
    var labelList: [String] = []
    
//    var paths : [String: [DijkstraEdge]]
//    var distances : [String: Int]
    
    init() {
        vertices = [:]
        vertexID = [:]
        labels = Set()
        self.addVertex(id: "1", label: "Parking Lot North", coords: [37.83438,-121.95127])
        self.addVertex(id: "2", label: "Parking Lot South",coords: [37.83371,-121.95124])
//        self.addVertex(id: "3", label: "Pickup Line")
//        self.addVertex(id: "4", label: "CIS")
//        self.addVertex(id: "5", label: "Reinhardt North")
//        self.addVertex(id: "6", label: "Main Hall South")
//        self.addVertex(id: "7", label: "Commons North")
//        self.addVertex(id: "8", label: "Main Hall East")
//        self.addVertex(id: "9", label: "Knoll Stairs (Bottom)")
//        self.addVertex(id: "10", label: "Knoll Stairs (Top)")
//        self.addVertex(id: "11", label: "Main Hall North")
//        self.addVertex(id: "12", label: "Main Hall Stairs (Top)")
//        self.addVertex(id: "13", label: "Knoll 1-4")
//        self.addVertex(id: "14", label: "Knoll 5-8")
//        self.addVertex(id: "15", label: "Science Hill (Top)")
//        self.addVertex(id: "16", label: "Science Classrooms")
//        self.addVertex(id: "17", label: "CFTA Road")
//        self.addVertex(id: "18", label: "Science Hill (Bottom)")
//        self.addVertex(id: "19", label: "Soccer Field")
//        self.addVertex(id: "20", label: "CFTA Intersection")
//        self.addVertex(id: "21", label: "CFTA")
//        self.addVertex(id: "22", label: "Commons/Middlefield Intersection")
//        self.addVertex(id: "23", label: "Commons South")
//        self.addVertex(id: "24", label: "Student Store")
//        self.addVertex(id: "25", label: "House 2")
//        self.addVertex(id: "26", label: "Middlefield Intersection")
//        self.addVertex(id: "27", label: "Middlefield")
//        self.addVertex(id: "28", label: "Middlefield/Orchard Intersection")
//        self.addVertex(id: "29", label: "Back Middlefield Intersection")
//        self.addVertex(id: "30", label: "Orchard")
//        self.addVertex(id: "31", label: "Orchard Intersection")
//        self.addVertex(id: "32", label: "Diversity Monument")
//        self.addVertex(id: "33", label: "Library Courtyard")
//        self.addVertex(id: "34", label: "Reinhardt South")
//        self.addVertex(id: "35", label: "Courtside North")
//        self.addVertex(id: "36", label: "Library East")
//        self.addVertex(id: "37", label: "Courtside South")
//        self.addVertex(id: "38", label: "Dase Center")
//        self.addVertex(id: "39", label: "Library/Dase intersection")
//        self.addVertex(id: "40", label: "Library West")
//        self.addVertex(id: "41", label: "House 3")
//        self.addVertex(id: "42", label: "House 9 Stairs")
//        self.addVertex(id: "43", label: "House 9")
//        self.addVertex(id: "44", label: "Dorms Courtyard")
//        self.addVertex(id: "45", label: "Creekside")
//        self.addVertex(id: "46", label: "Appletree")
//        self.addVertex(id: "47", label: "Ridgeview")
//        self.addVertex(id: "48", label: "Knoll 9/10")
//        self.addEdge(id1: "1", id2: "3", weight: 120)
        self.addEdge(id1: "1", id2: "2", weight: 200)
//        self.addEdge(id1: "3", id2: "4", weight: 100)
//        self.addEdge(id1: "3", id2: "11", weight: 260)
//        self.addEdge(id1: "4", id2: "5", weight: 100)
//        self.addEdge(id1: "5", id2: "6", weight: 60)
//        self.addEdge(id1: "11", id2: "12", weight: 30)
//        self.addEdge(id1: "11", id2: "9", weight: 100)
//        self.addEdge(id1: "12", id2: "13", weight: 50)
//        self.addEdge(id1: "13", id2: "10", weight: 50)
//        self.addEdge(id1: "10", id2: "9", weight: 30)
//        self.addEdge(id1: "10", id2: "14", weight: 50)
//        self.addEdge(id1: "14", id2: "15", weight: 50)
//        self.addEdge(id1: "15", id2: "16", weight: 70)
//        self.addEdge(id1: "16", id2: "18", weight: 70)
//        self.addEdge(id1: "16", id2: "17", weight: 130)
//        self.addEdge(id1: "17", id2: "18", weight: 130)
//        self.addEdge(id1: "17", id2: "20", weight: 300)
//        self.addEdge(id1: "20", id2: "21", weight: 280)
//        self.addEdge(id1: "18", id2: "48", weight: 50)
//        self.addEdge(id1: "48", id2: "8", weight: 50)
//        self.addEdge(id1: "8", id2: "7", weight: 100)
//        self.addEdge(id1: "7", id2: "6", weight: 70)
//        self.addEdge(id1: "7", id2: "22", weight: 80)
//        self.addEdge(id1: "6", id2: "32", weight: 100)
//        self.addEdge(id1: "32", id2: "26", weight: 50)
//        self.addEdge(id1: "26", id2: "22", weight: 30)
//        self.addEdge(id1: "26", id2: "27", weight: 75)
//        self.addEdge(id1: "27", id2: "28", weight: 75)
//        self.addEdge(id1: "28", id2: "29", weight: 60)
//        self.addEdge(id1: "29", id2: "24", weight: 70)
//        self.addEdge(id1: "24", id2: "25", weight: 30)
//        self.addEdge(id1: "24", id2: "23", weight: 100)
//        self.addEdge(id1: "23", id2: "22", weight: 30)
//        self.addEdge(id1: "23", id2: "44", weight: 120)
//        self.addEdge(id1: "44", id2: "45", weight: 10)
//        self.addEdge(id1: "44", id2: "46", weight: 10)
//        self.addEdge(id1: "44", id2: "47", weight: 80)
//        self.addEdge(id1: "47", id2: "29", weight: 220)
//        self.addEdge(id1: "28", id2: "30", weight: 30)
//        self.addEdge(id1: "30", id2: "31", weight: 20)
//        self.addEdge(id1: "31", id2: "32", weight: 150)
//        self.addEdge(id1: "32", id2: "33", weight: 60)
//        self.addEdge(id1: "33", id2: "35", weight: 30)
//        self.addEdge(id1: "33", id2: "34", weight: 30)
//        self.addEdge(id1: "33", id2: "36", weight: 30)
//        self.addEdge(id1: "36", id2: "38", weight: 130)
//        self.addEdge(id1: "38", id2: "37", weight: 70)
//        self.addEdge(id1: "38", id2: "39", weight: 60)
//        self.addEdge(id1: "39", id2: "40", weight: 110)
//        self.addEdge(id1: "40", id2: "33", weight: 120)
//        self.addEdge(id1: "40", id2: "3", weight: 120)
//        self.addEdge(id1: "3", id2: "19", weight: 300)
//        self.addEdge(id1: "19", id2: "2", weight: 70)
//        self.addEdge(id1: "31", id2: "37", weight: 50)
//        self.addEdge(id1: "8", id2: "9", weight: 30)
//        self.addEdge(id1: "38", id2: "41", weight: 140)
//        self.addEdge(id1: "10", id2: "42", weight: 60)
//        self.addEdge(id1: "42", id2: "43", weight: 110)
//        paths = [:]
//        distances = [:]
    }
    
    // Adds a vertex to the graph
    func addVertex(id: String, label: String, coords: [Double]) {
        // Check vertex doesn't already exist before adding it
        if vertices[id] == nil {
            let v1 = WeightedVertex(id: id, label: label, coords: coords)
            vertices[id] = v1
            vertexID[label] = id
            labels.insert(label)
            labelList.append(label)
        }
    }
    
    // Adds an edge to the graph
    func addEdge(id1: String, id2: String, weight: Int) {
        // Check vertices exist before adding an edge between them
        if let v1 = vertices[id1], let v2 = vertices[id2] {
            v1.edges.append(DijkstraEdge(source: v1, destination: v2, weight: weight))
            v2.edges.append(DijkstraEdge(source: v2, destination: v1, weight: weight))
        }
    }
    
    // Removes a vertex from the graph
    func removeVertex(id: String) {
        // Check vertex exists before removing it
        if let v1 = vertices[id] {
            // Remove all edges to this vertex
            for edge1 in v1.edges {
                let v2 = edge1.destination;
                // Look through v2 edges for edge to this
                for (index, edge2) in v2.edges.enumerated() {
                    if edge2.destination == v1 {
                        v2.edges.remove(at: index)
                    }
                }
            }
            
            v1.edges.removeAll()
            vertices.removeValue(forKey: id)
        }
    }
    
    // Removes an edge from the graph
    func removeEdge(id1: String, id2: String) {
        // Check vertices exist before removing an edge between them
        if let v1 = vertices[id1], let v2 = vertices[id2] {
            for (index, edge1) in v1.edges.enumerated() {
                if edge1.destination == v2 {
                    v1.edges.remove(at: index)
                }
            }
            
            for (index, edge2) in v2.edges.enumerated() {
                if edge2.destination == v1 {
                    v2.edges.remove(at: index)
                }
            }
        }
    }
    
    // This method carries out Dijkstra's algorithm
    // The algorithm returns a Dictionary for the distances to each node
    func dijkstra(source: String,destination: String) -> Path{
        var visited = Set<String>()
        var distances = [String: Int]()
        var paths  = [String: [DijkstraEdge]]()
        for key in vertices.keys {
            distances[key] = Int.max
            paths[key] = []
        }
        var frontier = PriorityQueue<PQNode>(ascending: true)
        if let sourceVertex = vertices[source] {
            frontier.push(PQNode(v: sourceVertex, priority: 0))
            distances[source] = 0
        }
        while !frontier.isEmpty && !(frontier.peek()?.v.id == destination){
            let v = frontier.pop()!.v
            if (!visited.contains(v.id)){
//                print("Visiting " + v.id + String(distances[v.id]!))
                visited.insert(v.id)
                for edge in v.edges {
                    let destination = edge.destination
    //                print(destination.id)
    //                print(distances[destination.id])
    //                print(edge.weight)
                    if let distanceToV = distances[v.id], let distanceToDest = distances[destination.id], distanceToV + edge.weight < distanceToDest {
                        distances[destination.id] = distanceToV + edge.weight
                        paths[destination.id] = paths[v.id]
                        paths[destination.id]?.append(edge)
                    }
                   
                    frontier.push(PQNode(v: destination, priority: distances[destination.id]!))
                    
                }
            }
        }
        let path = Path(s: source, d: destination, p: paths[destination]!, w: distances[destination]!)
        return path
    }
    
    
    class Path{
        var source: String
        var destination: String
        var path: [DijkstraEdge]
        var weight: Int
        init(s: String, d: String, p: [DijkstraEdge], w: Int){
            source  = s
            destination = d
            path = p
            weight = w
        }
    }
    class WeightedVertex: Equatable {
        static func == (lhs: DijkstraGraph.WeightedVertex, rhs: DijkstraGraph.WeightedVertex) -> Bool {
            return lhs.id == rhs.id
        }
        
        var id: String
        var label: String
        var edges: [DijkstraEdge]
        var coords: [Double]
        
        init(id: String, label: String, coords : [Double]) {
            self.id = id
            self.label = label
            self.edges = []
            self.coords = coords
        }
    }
    
    class PQNode: Comparable {
        static func < (lhs: PQNode, rhs: PQNode) -> Bool {
            lhs.priority < rhs.priority
        }
        
        var v: WeightedVertex
        var priority: Int
        
        init(v: WeightedVertex, priority: Int) {
            self.v = v
            self.priority = priority
        }
        
        static func == (lhs: PQNode, rhs: PQNode) -> Bool {
            lhs.priority == rhs.priority
        }
    }
    
    class DijkstraEdge: Comparable {
        var source: WeightedVertex
        var destination: WeightedVertex
        var weight: Int
        
        init(source: WeightedVertex, destination: WeightedVertex, weight: Int) {
            self.source = source
            self.destination = destination
            self.weight = weight
        }
        
        static func == (lhs: DijkstraEdge, rhs: DijkstraEdge) -> Bool {
            lhs.source as! AnyHashable == rhs.source as! AnyHashable && lhs.destination as! AnyHashable == rhs.destination as! AnyHashable ||
            lhs.source as! AnyHashable == rhs.destination as! AnyHashable && lhs.destination as! AnyHashable == rhs.source as! AnyHashable
        }
        
        static func < (lhs: DijkstraEdge, rhs: DijkstraEdge) -> Bool {
            lhs.weight < rhs.weight
        }
    }
}
public struct PriorityQueue<T: Comparable> {
    
    fileprivate(set) var heap = [T]()
    private let ordered: (T, T) -> Bool
    

    public init(ascending: Bool = false, startingValues: [T] = []) {
        self.init(order: ascending ? { $0 > $1 } : { $0 < $1 }, startingValues: startingValues)
    }
    

    public init(order: @escaping (T, T) -> Bool, startingValues: [T] = []) {
        ordered = order
        
        // Based on "Heap construction" from Sedgewick p 323
        heap = startingValues
        var i = heap.count/2 - 1
        while i >= 0 {
            sink(i)
            i -= 1
        }
    }

    public var count: Int { return heap.count }

    public var isEmpty: Bool { return heap.isEmpty }
    

    public mutating func push(_ element: T) {
        heap.append(element)
        swim(heap.count - 1)
    }

    public mutating func push(_ element: T, maxCount: Int) -> T? {
        precondition(maxCount > 0)
        if count < maxCount {
            push(element)
        } else {
            if let discard = heap.max(by: ordered) {
                if ordered(discard, element) { return element }
                push(element)
                remove(discard)
                return discard
            }
        }
        return nil
    }

    public mutating func pop() -> T? {
        
        if heap.isEmpty { return nil }
        let count = heap.count
        if count == 1 { return heap.removeFirst() }
        fastPop(newCount: count - 1)
        
        return heap.removeLast()
    }
    
    

    public mutating func remove(_ item: T) {
        if let index = heap.firstIndex(of: item) {
            heap.swapAt(index, heap.count - 1)
            heap.removeLast()
            if index < heap.count { // if we removed the last item, nothing to swim
                swim(index)
                sink(index)
            }
        }
    }
    

    public mutating func removeAll(_ item: T) {
        var lastCount = heap.count
        remove(item)
        while (heap.count < lastCount) {
            lastCount = heap.count
            remove(item)
        }
    }

    public func peek() -> T? {
        return heap.first
    }

    public mutating func clear() {
        heap.removeAll(keepingCapacity: false)
    }
    
    // Based on example from Sedgewick p 316
    private mutating func sink(_ index: Int) {
        var index = index
        while 2 * index + 1 < heap.count {
            
            var j = 2 * index + 1
            
            if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) { j += 1 }
            if !ordered(heap[index], heap[j]) { break }
            
            heap.swapAt(index, j)
            index = j
        }
    }
    private mutating func fastPop(newCount: Int) {
        var index = 0
        heap.withUnsafeMutableBufferPointer { bufferPointer in
            let _heap = bufferPointer.baseAddress! // guaranteed non-nil because count > 0
            swap(&_heap[0], &_heap[newCount])
            while 2 * index + 1 < newCount {
                var j = 2 * index + 1
                if j < (newCount - 1) && ordered(_heap[j], _heap[j+1]) { j += 1 }
                if !ordered(_heap[index], _heap[j]) { return }
                swap(&_heap[index], &_heap[j])
                index = j
            }
        }
    }
    
    private mutating func swim(_ index: Int) {
        var index = index
        while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
            heap.swapAt((index - 1) / 2, index)
            index = (index - 1) / 2
        }
    }
}

extension PriorityQueue: IteratorProtocol {
    
    public typealias Element = T
    mutating public func next() -> Element? { return pop() }
}

extension PriorityQueue: Sequence {
    
    public typealias Iterator = PriorityQueue
    public func makeIterator() -> Iterator { return self }
}

extension PriorityQueue: Collection {
    
    public typealias Index = Int
    
    public var startIndex: Int { return heap.startIndex }
    
    public var endIndex: Int { return heap.endIndex }
    
    public subscript(position: Int) -> T {
        precondition(
            startIndex..<endIndex ~= position,
            "SwiftPriorityQueue subscript: index out of bounds"
        )
        return heap[position]
    }
    
    public func index(after i: PriorityQueue.Index) -> PriorityQueue.Index {
        return heap.index(after: i)
    }
    
    
}

extension PriorityQueue: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String { return heap.description }
    public var debugDescription: String { return heap.debugDescription }
}

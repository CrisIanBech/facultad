import kotlin.math.cos

fun djikstra(): List<Node> {
    val graph: HashMap<Node, HashMap<Node, Int>> = hashMapOf()
    val seen: MutableList<Node> = mutableListOf()
    val parents: HashMap<Node, Node> = hashMapOf()
    val costs: HashMap<Node, Int> = hashMapOf()

    val nodeA = Node("a")
    val nodeB = Node("b")
    val nodeC = Node("c")
    val nodeD = Node("d")
    val finish = Node("finish")
    val start = Node("start")

    graph[start] = hashMapOf()
    graph[nodeA] = hashMapOf()
    graph[nodeB] = hashMapOf()
    graph[nodeC] = hashMapOf()
    graph[nodeD] = hashMapOf()
    graph[finish] = hashMapOf()

    // Start
    graph[start]!![nodeA] = 5
    graph[start]!![nodeD] = 2

    // NodeA
    graph[nodeA]!![nodeD] = 2
    graph[nodeA]!![nodeA] = 3
    graph[nodeA]!![nodeC] = 4

    // NodeB
    graph[nodeB]!![nodeA] = 8
    graph[nodeB]!![nodeD] = 7

    graph[nodeC]!![finish] = 3
    graph[nodeC]!![nodeD] = 6

    graph[nodeD]!![finish] = 1

    // Init costs
    graph.keys.forEach {
        costs[it] = Int.MAX_VALUE
    }

    costs[start] = 0

    // Start algorithm
    var currentNode: Node? = minimumCostNode(costs, seen)!!
    while (currentNode != null) {
        val neighbours = graph[currentNode]
        for (neighbourKey in neighbours!!.keys) {
            val currentCost = costs[currentNode]!! + graph[currentNode]!![neighbourKey]!!
            if (costs[neighbourKey]!! >= currentCost) {
                costs[neighbourKey] = currentCost
                parents[neighbourKey] = currentNode
            }
        }
        seen.add(currentNode)
        currentNode = minimumCostNode(costs, seen)
    }

    val path: MutableList<Node> = mutableListOf<Node>().apply {
        add(Node("finish"))
    }
    var currentParent: Node? = parents[finish]
    while (currentParent != null) {
        path.add(0, currentParent)
        currentParent = parents[currentParent]
    }
    return path.apply {
        add(0, Node("start"))
    }
}

fun minimumCostNode(costs: HashMap<Node, Int>, seen: List<Node>): Node? {
    var minCost = Int.MAX_VALUE
    var minimumCostNode: Node? = null
    for (node in costs) {
         if(!seen.contains(node.key)) {
             if (minCost >= costs[node.key]!!) {
                 minCost = costs[node.key]!!
                 minimumCostNode = node.key
             }
         }
    }
    return minimumCostNode
}

class Node(val name: String) {
    override fun equals(other: Any?): Boolean {
        if(other !is Node) return false
        return other.name == name
    }

    override fun hashCode(): Int {
        return name.hashCode()
    }
}
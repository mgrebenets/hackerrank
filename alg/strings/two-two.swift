/// Two Two
/// TODO: link

import Foundation

public func twoTwo() {

    // Compute and store strings for powers of 2
    let maxPower: Int = 800
    let powers = computePowers(maxPower)
    let powerStrings = powers.map { p in
        return String(format: "%.0f", arguments: [p])
    }

    // create trie from prefixes
    let trie: Trie<String> = Trie.buildTrie(powerStrings)

    // loop through test cases
    let n: Int = readLn()
    var ans: [Int] = []
    for _ in 0..<n {
        let string: String = getLine()
        let count = trie.countMatches(string)
        println(count)
    }
}

private func computePowers(maxPower: Int) -> [Double] {
    var powers: [Double] = []
    for p in 0...maxPower {
        powers.append(pow(2, Double(p)))
    }
    return powers
}

final class Trie <T: CollectionType where T.Generator.Element: Hashable, T.Generator.Element: Equatable> {
    typealias Value = T.Generator.Element
    typealias Generator = T.Generator
    typealias Output = T

    let value: Value?   // Root node has no value
    var label: Output? = nil
    var output: [Output] = []
    private var rootGoto: Trie? = nil
    private var fail: Trie? = nil
    private var nodes: [Value: Trie] = [:]

    init(value: Value? = nil) {
        self.value = value
    }

    class func buildTrie(superSet: [T]) -> Trie {
        let rootNode = Trie()
        // Root node goto to self when no matching node
        rootNode.rootGoto = rootNode

        // Phase I: build initial trie
        for set in superSet {
            var node = rootNode
            for element in set {
                node = node.addNode(element)
            }
            // Last node needs to have label and output set
            node.output = [set]
            node.label = set
        }

        // Phase II: construct goto and fail functions
        var queue: [Trie] = []
        for (key, nextNode) in rootNode.nodes {
            nextNode.fail = rootNode
            queue.append(nextNode)
        }

        while !queue.isEmpty {
            let node = queue.removeAtIndex(0)
            for (element, nextNode) in node.nodes {
                queue.append(nextNode)

                var failNode = node.fail!
                while failNode.goto(element) == nil {
                    failNode = failNode.fail!
                }
                nextNode.fail = failNode.goto(element)
                nextNode.output += nextNode.fail!.output
            }
        }

        return rootNode
    }

    func addNode(value: Value) -> Trie {
        if let nextNode = nodes[value] {
            return nextNode
        } else {
            let node = Trie(value: value)
            nodes[value] = node
            return node
        }
    }

    private func goto(value: Value) -> Trie? {
        return nodes[value] ?? rootGoto
    }

    func countMatches(collection: T) -> Int {
        var count = 0
        var node = self

        for element in collection {
            while node.goto(element) == nil {
                node = node.fail!
            }
            node = node.goto(element)!
            count += node.output.count
        }

        return count
    }
}

#if CLI_BUILD
    import StdIO
    // silence the xcode, it doesn't like just calling funcName() directly
    let x: Void = twoTwo()
#endif

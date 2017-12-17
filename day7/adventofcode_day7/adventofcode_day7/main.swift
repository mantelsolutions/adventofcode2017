//
//  main.swift
//  adventofcode_day7
//
//  Created by Matthias Mantel on 07.12.17.
//  Copyright © 2017 Matthias Mantel. All rights reserved.
//

import Foundation

/**
 * A Node in a tree
 **/
class Node: CustomStringConvertible {
    var parent: Node?
    var children: [Node] = []
    var weight: Int?
    let name: String
    
    init(name: String, weight: Int){
        self.weight = weight
        self.name = name
    }
    
    func setWeight(weight: Int){
        self.weight = weight
    }
    
    func setParent(parent: Node){
        self.parent = parent
    }
    
    func addChild(child: Node){
        self.children.append(child)
        child.parent = self
    }
    
    public var description: String {
        return "Node: name: \(name) -- weight: \(weight!) -- children: \(children.count) -- parent: \(parent != nil)"
    }
    
    public var computedWeight: Int {
        var result = self.weight!
        for child in children {
            result = result + child.computedWeight
        }
        return result
    }
    
    public var findUnbalacedNodeInChildHirarchy: Node {
        var nodeWeigthDict = [Int: [Node]]()
        
        // find max weight
        for child in children {
            let computedWeightForChild = child.computedWeight
            var currentListOfNodes = nodeWeigthDict[computedWeightForChild]
            if currentListOfNodes == nil {
                currentListOfNodes = [child]
            }else{
                currentListOfNodes!.append(child)
            }
            nodeWeigthDict[computedWeightForChild] = currentListOfNodes
        }
        
        let unbalancedNodeDict = nodeWeigthDict.filter{ $0.value.count == 1}
        for node in unbalancedNodeDict.values {
            return node[0].findUnbalacedNodeInChildHirarchy
        }
        
        return self
        
    }
}

let file = "/Users/matthiasmantel/development/adventofcode2017/day7/tree.txt"

let fileURL = URL(fileURLWithPath: file)
print("Reading in tree file: \(fileURL.absoluteString)")

//read in the tree
do {
    let treeContents = try String(contentsOf: fileURL, encoding: .utf8)
//    let treeContents = "pbga (66)\nxhth (57)\nebii (61)\nhavc (66)\nktlj (57)\nfwft (72) -> ktlj, cntj, xhth\nqoyq (66)\npadx (45) -> pbga, havc, qoyq\ntknk (41) -> ugml, padx, fwft\njptl (61)\nugml (68) -> gyxo, ebii, jptl\ngyxo (61)\ncntj (57)"
    let leafs = treeContents.components(separatedBy: .newlines)
    
    let regEx = try! NSRegularExpression(pattern: "(?<NODENAME>.*) \\((?<NODEVALUE>\\d+)\\)( -> (?<OTHERNODES>.*))?")
    
    var nodeDictionary = [String: Node]()
    
    for leaf in leafs {
        let leafMatches = regEx.matches(in: leaf, range: NSMakeRange(0, leaf.utf16.count))
        if leafMatches.count > 0 {
            for leafMatch in leafMatches {
                let nodeNameRange = leafMatch.range(withName: "NODENAME")
                let nodeName = (leaf as NSString).substring(with: nodeNameRange)
                let nodeValueRange = leafMatch.range(withName: "NODEVALUE")
                let nodeValue = (leaf as NSString).substring(with: nodeValueRange)
                
                var currentNode = nodeDictionary[nodeName]
                if currentNode == nil {
                    currentNode = Node(name: nodeName, weight: Int(nodeValue)!)
                }else{
                    currentNode?.setWeight(weight: Int(nodeValue)!)
                }
                
                print("current node: \(currentNode!)")
                nodeDictionary[currentNode!.name] = currentNode
                
                let otherNodesRange = leafMatch.range(withName: "OTHERNODES")
                
                if otherNodesRange.length == 0 {
                    print("No other nodes found: \(otherNodesRange)")
                }else{
                    let otherNodesString = (leaf as NSString).substring(with: otherNodesRange)
                    let otherNodesArray : [String] = otherNodesString.components(separatedBy: ", ")
                    print("otherNodes array: \(otherNodesArray)")
                    for otherNode in otherNodesArray {
                        var otherNodeObject = nodeDictionary[otherNode]
                        if otherNodeObject == nil {
                            otherNodeObject = Node(name: otherNode, weight: 0)
                            otherNodeObject?.setParent(parent: currentNode!)
                        }else {
                            if otherNodeObject !== currentNode {
                                otherNodeObject?.setParent(parent: currentNode!)
                            }
                        }
                        currentNode?.addChild(child: otherNodeObject!)
                        nodeDictionary[otherNodeObject!.name] = otherNodeObject
                        print("otherNode: \(otherNodeObject!)")
                    }
                }
            }
        }else{
            print("no match for \(leaf)")
        }
    }
    
    let filtered = nodeDictionary.filter{ $0.value.parent == nil}
    
    print("Task1: no parent node: \(filtered)")
    
    // Task 2
    
    let noParentNodeName = Array(filtered.keys)[0]
    let noParentNode = filtered[noParentNodeName]
    
    var currentWeight = 0
    var currentWeightDifference = 0
    var nodeWithMaxWeight: Node? = nil
    
    // find max weight
    for child in noParentNode!.children {
        print("Node: \(child.name) -- computedWeight: \(child.computedWeight)")
        let computedWeightForChild = child.computedWeight
        if currentWeight < computedWeightForChild {
            currentWeight = computedWeightForChild
            nodeWithMaxWeight = child
        }
    }
    
    
    
    //find difference
    for child in noParentNode!.children {
        if(child !== nodeWithMaxWeight){
            let computedWeightForChild = child.computedWeight
            let difference = computedWeightForChild - currentWeight
            currentWeightDifference = difference
        }
    }
    
    let unbalancedNode = noParentNode?.findUnbalacedNodeInChildHirarchy
    let newWeightForNodeToBeBalanced = unbalancedNode!.weight! + currentWeightDifference
    print("Task2: Unbalanced node: \(String(describing: unbalancedNode)) -- new weight: \(newWeightForNodeToBeBalanced)")
    
    
}

//
//  main.swift
//  adventofcode_day5
//
//  Created by Matthias Mantel on 07.12.17.
//  Copyright © 2017 Matthias Mantel. All rights reserved.
//

import Foundation

let file = "/Users/matthiasmantel/development/adventofcode2017/day5/memory.txt"

let fileURL = URL(fileURLWithPath: file)
print("Reading in memory file: \(fileURL.absoluteString)")

//read in the spreadsheet
do {
    let memoryContents = try String(contentsOf: fileURL, encoding: .utf8)
    let rows = memoryContents.components(separatedBy: .newlines)

    print("number of items before conversion: \(rows.count)")
    var memory = rows.map{Int($0)!}
    print("number of items after conversion: \(memory.count)")
    //var memory2: [Int] = [0, 3, 0, 1, -3]
    
    var index = 0
    var numberOfJumps = 0
    while index < memory.count && index >= 0 {
        let currentValueAtIndex = memory[index]
        //print("currentValueAtIndex: \(currentValueAtIndex)")
        memory[index] = currentValueAtIndex + 1
        //print("updated memory[index] to \(memory[index])")
        
        if currentValueAtIndex != 0{
            index = index + currentValueAtIndex
        }
        //print("next index: \(index)")
        numberOfJumps += 1
        //print("numberOfJumps: \(numberOfJumps)\n\n")
    }
    print("Number of jumps needed for task1: \(numberOfJumps)")
    
    
    var memory2 = rows.map{Int($0)!}
    index = 0
    numberOfJumps = 0
    while index < memory2.count && index >= 0 {
        let currentValueAtIndex = memory2[index]
        //print("currentValueAtIndex: \(currentValueAtIndex)")
        memory2[index] = currentValueAtIndex >= 3 ? currentValueAtIndex - 1 : currentValueAtIndex + 1
        //print("updated memory[index] to \(memory2[index])")
        
        if currentValueAtIndex != 0{
            index = index + currentValueAtIndex
        }
        //print("next index: \(index)")
        numberOfJumps += 1
        //print("numberOfJumps: \(numberOfJumps)\n\n")
    }
    print("Number of jumps needed for task2: \(numberOfJumps)")
}

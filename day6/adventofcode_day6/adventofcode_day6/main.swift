//
//  main.swift
//  adventofcode_day6
//
//  Created by Matthias Mantel on 07.12.17.
//  Copyright © 2017 Matthias Mantel. All rights reserved.
//

import Foundation

func findIndexOfMaxValue(memoryBanks: [Int]) -> Int {
    let maxValue = memoryBanks.max()
    let maxBanks = memoryBanks.indices.filter { memoryBanks[$0] == maxValue }
    return maxBanks[0]
}

let file = "/Users/matthiasmantel/development/adventofcode2017/day6/memorybanks.txt"

let fileURL = URL(fileURLWithPath: file)
print("Reading in memory file: \(fileURL.absoluteString)")

//read in the spreadsheet
do {
    let memoryContents = try String(contentsOf: fileURL, encoding: .utf8)
    let memoryBanks = memoryContents.components(separatedBy: "\t")
    
    var currentMemoryBankLayout = memoryBanks.map{ Int($0)!}
    
    var numberOfRedistributions = 0
    
    var memoryBankLayouts: Set<String> = []
    
    memoryBankLayouts.insert(currentMemoryBankLayout.description)
    
    repeat {
        memoryBankLayouts.insert(currentMemoryBankLayout.description)
        
        let maxIndex = findIndexOfMaxValue(memoryBanks: currentMemoryBankLayout)
        var valueToRebalance = currentMemoryBankLayout[maxIndex]
        
        var currentIndex = maxIndex + 1 < currentMemoryBankLayout.count ? maxIndex + 1 : 0
        currentMemoryBankLayout[maxIndex] = 0
        while valueToRebalance > 0 {
            currentMemoryBankLayout[currentIndex] += 1
            valueToRebalance -= 1
            currentIndex = currentIndex + 1 < currentMemoryBankLayout.count ? currentIndex + 1 : 0
        }
        
        numberOfRedistributions += 1
    }while !memoryBankLayouts.contains(currentMemoryBankLayout.description)
    
    print("number of redistributions task1: \(numberOfRedistributions)")
    
    memoryBankLayouts.removeAll()
    var numberOfRedistributionsTask2 = 0
    let firstRecurringPattern = currentMemoryBankLayout.description
    repeat {
        if numberOfRedistributionsTask2 > 0 {
            memoryBankLayouts.insert(currentMemoryBankLayout.description)
        }
        
        let maxIndex = findIndexOfMaxValue(memoryBanks: currentMemoryBankLayout)
        var valueToRebalance = currentMemoryBankLayout[maxIndex]
        
        var currentIndex = maxIndex + 1 < currentMemoryBankLayout.count ? maxIndex + 1 : 0
        currentMemoryBankLayout[maxIndex] = 0
        while valueToRebalance > 0 {
            currentMemoryBankLayout[currentIndex] += 1
            valueToRebalance -= 1
            currentIndex = currentIndex + 1 < currentMemoryBankLayout.count ? currentIndex + 1 : 0
        }
        
        numberOfRedistributionsTask2 += 1
    }while firstRecurringPattern != currentMemoryBankLayout.description
    
    
    
    print("number of redistributions task2: \(numberOfRedistributionsTask2)")
    
    
    
}


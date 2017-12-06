//
//  main.swift
//  adventofcode_day4
//
//  Created by Matthias Mantel on 06.12.17.
//  Copyright © 2017 Matthias Mantel. All rights reserved.
//

import Foundation

let file = "/Users/matthiasmantel/development/adventofcode2017/day4/passphrases.txt"

let fileURL = URL(fileURLWithPath: file)
print("Reading in spreadsheet file: \(fileURL.absoluteString)")

//read in the spreadsheet
do {
    let passphraseContents = try String(contentsOf: fileURL, encoding: .utf8)
    let rows = passphraseContents.components(separatedBy: .newlines)
    
    var numberOfValidPassphrasesTask1 = 0
    var numberOfValidPassphrasesTask2 = 0
    
    for (_, row) in rows.enumerated() {
        var uniqueWordSet = Set<String>()
        
        var onlyUniqueWordsInPassphrase = true
        var noAnagramsInPassphrase = true
        
        let words = row.components(separatedBy: " ")
        for(_, word) in words.enumerated(){
            if uniqueWordSet.contains(word){
                onlyUniqueWordsInPassphrase = false
                noAnagramsInPassphrase = false
                break
            }
            
            for(_, foundWord) in uniqueWordSet.enumerated() {
                if foundWord.count == word.count && foundWord.sorted() == word.sorted() {
                    
                    print("\(word) is an anagram of \(foundWord)")
                    noAnagramsInPassphrase = false
                    
                }
            }
            uniqueWordSet.insert(word)
        }
        if onlyUniqueWordsInPassphrase {
            numberOfValidPassphrasesTask1 += 1
            if noAnagramsInPassphrase {
                numberOfValidPassphrasesTask2 += 1
            }
        }
    }
    
    print("number of valid passphrases task1: \(numberOfValidPassphrasesTask1)")
    print("number of valid passphrases task2: \(numberOfValidPassphrasesTask2)")
}

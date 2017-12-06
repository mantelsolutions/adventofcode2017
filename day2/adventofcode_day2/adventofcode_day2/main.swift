//
//  main.swift
//  adventofcode_day2
//
//  Created by Matthias Mantel on 03.12.17.
//  Copyright © 2017 Matthias Mantel. All rights reserved.
//

import Foundation

let file = "/Users/matthiasmantel/development/adventofcode2017/day2/spreadsheet.txt"

let fileURL = URL(fileURLWithPath: file)
print("Reading in spreadsheet file: \(fileURL.absoluteString)")

//read in the spreadsheet
do {
    let spreadsheetContents = try String(contentsOf: fileURL, encoding: .utf8)
    let rows = spreadsheetContents.components(separatedBy: .newlines)
    
    var checksum = 0
    
    for (_, row) in rows.enumerated() {
        var min: Int?
        min = nil
        var max: Int?
        max = nil
        
        let cells = row.components(separatedBy: "\t")
        for(_, cell) in cells.enumerated(){
            let cellValue = Int(cell)!
            if ( min == nil) {
                min = cellValue
            }
            if ( max == nil) {
                max = cellValue
            }
            if(cellValue < min!){
                min = cellValue
            }
            if(cellValue > max!){
                max = cellValue
            }
        }
        let rowDiff = max! - min!
        checksum = checksum + rowDiff
    }
    
    print("Answer to the checksum question is: \(checksum)")
}


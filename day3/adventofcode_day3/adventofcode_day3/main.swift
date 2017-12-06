//
//  main.swift
//  adventofcode_day3
//
//  Created by Matthias Mantel on 03.12.17.
//  Copyright © 2017 Matthias Mantel. All rights reserved.
//

import Foundation

// Number / 8 = Z => entrypoint location at = 0+z,0+z

//                33 31
//17  16  15  14  13 30
//18   5   4   3  12 29
//19   6   1   2  11 28
//20   7   8   9  10 27
//21  22  23  24  25 26

let input = Double(277678)

let root = sqrt(input)

print("Root: \(root)")

let index = (root - 1) / 2
print("index: \(index)")

let ceilIndex = ceil(index)
print("ceilIndex: \(ceilIndex)")

let amountOfNumbersForIndex = ceilIndex * 2 + 1
print("amountOfNumbersForIndex: \(amountOfNumbersForIndex)")

let maxNumberForIndex = pow(amountOfNumbersForIndex, 2)
print("maxNumberForIndex: \(maxNumberForIndex)")

let differenceOfInputToMaximum = maxNumberForIndex - input
print("differenceOfInputToMaximum: \(differenceOfInputToMaximum)")

let positionInIndex = differenceOfInputToMaximum / (amountOfNumbersForIndex - 1)
print("positionInIndex: \(positionInIndex)")

let nextMaxNumber = maxNumberForIndex - floor(positionInIndex) * (amountOfNumbersForIndex - 1)
print("nextMaxNumber: \(nextMaxNumber)")

let differenceOfInputToNextMaxNumber = nextMaxNumber - input
print("differenceOfInputToNextMaxNumber: \(differenceOfInputToNextMaxNumber)")

let middleOfIndexRow = ceil(amountOfNumbersForIndex / 2) - 1
print("middleOfIndexRow: \(middleOfIndexRow)")

let positionFromMiddle = differenceOfInputToNextMaxNumber - middleOfIndexRow
print("positionFromMiddle: \(positionFromMiddle)")

let result = positionFromMiddle <= 0 ? amountOfNumbersForIndex - 1 - differenceOfInputToNextMaxNumber : differenceOfInputToNextMaxNumber

print("Steps needed to access port: \(result)")




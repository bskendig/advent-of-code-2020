//
//  main.swift
//  3
//
//  Created by Brian Kendig on 12/2/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func treeCount(with forest: [String], right: Int, down: Int) -> Int {
    var treeCount = 0
    var hPos = 0
    let reducedForest = forest.enumerated().compactMap { (offset, element) in
        offset % down == 0 ? element : nil
    }
    for line in reducedForest {
        if Array(line)[hPos] == "#" {
            treeCount += 1
        }
        hPos = (hPos + right) % line.count
    }
    return treeCount
}

func main() {
    let forest = getInput().split(separator: "\n").map { String($0) }

    print(treeCount(with: forest, right: 3, down: 1))

    print(
        treeCount(with: forest, right: 1, down: 1) *
        treeCount(with: forest, right: 3, down: 1) *
        treeCount(with: forest, right: 5, down: 1) *
        treeCount(with: forest, right: 7, down: 1) *
        treeCount(with: forest, right: 1, down: 2))
}

main()

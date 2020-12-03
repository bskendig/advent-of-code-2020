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

func countTrees(with map: [String.SubSequence], right: Int, down: Int) -> Int {
    var treeCount = 0
    var hPos = 0
    var skipLines = 0
    for line in map {
        if skipLines > 0 {
            skipLines -= 1
            continue
        }
        if Array(line)[hPos] == "#" {
            treeCount += 1
        }
        hPos = (hPos + right) % line.count
        skipLines = down - 1
    }
    return treeCount
}

func main() {
    let map = getInput().split(separator: "\n")

    print(countTrees(with: map, right: 3, down: 1))

    print(
        countTrees(with: map, right: 1, down: 1) *
        countTrees(with: map, right: 3, down: 1) *
        countTrees(with: map, right: 5, down: 1) *
        countTrees(with: map, right: 7, down: 1) *
        countTrees(with: map, right: 1, down: 2))
}

main()

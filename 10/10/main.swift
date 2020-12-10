//
//  main.swift
//  10
//
//  Created by Brian Kendig on 12/10/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

var jolts: [Int] = []
var alreadyCounted: [Int: Int] = [:]

func howManySolutionsFrom(index: Int) -> Int {
    if let ac = alreadyCounted[index] {
        return ac
    }
    let current = jolts[index]
    var total = 0
    for i in index+1 ... index+3 {
        if i >= jolts.count {
            break
        }
        if jolts[i] - current <= 3 {
            total += howManySolutionsFrom(index: i)
        }
    }
    alreadyCounted[index] = total
    return total
}

func main() {
    jolts = getInput().split(separator: "\n").map { Int($0)! }
    jolts.append(0)
    jolts = jolts.sorted()
    alreadyCounted = [(jolts.count - 1): 1]
    var count = [0, 0, 0, 0]  // we'll only use offsets 1 and 3
    count[1] = 0
    count[3] = 1
    for i in 1 ..< jolts.count {
        let diff = jolts[i] - jolts[i-1]
        count[diff] += 1
    }
    print(count[1] * count[3])
    print(howManySolutionsFrom(index: 0))
}

main()

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

func main() {
    let jolts = getInput().split(separator: "\n").map({ Int($0)! }).sorted()
    var count = [0, 0, 0, 0]  // we'll only use offsets 1 and 3
    count[1] = 0
    count[3] = 1  // for the end adapter
    count[jolts[0]] += 1
    for i in 1 ..< jolts.count {
        let diff = jolts[i] - jolts[i-1]
        count[diff] += 1
    }
    print(count[1] * count[3])
}

main()
